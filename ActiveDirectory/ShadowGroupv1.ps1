#region Functions
function Clear-SiteShadowGroupMembers {
    [CmdletBinding()]
    param(
        [parameter(
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            Position = 0)
        ]
        $Site
    )

    process {

        $Users = Get-ADGroup -Identity sg_$($Site)-AllUsers -Properties Members |
            Select-Object -ExpandProperty Members |
            ForEach-Object {
                Get-ADUser -Identity $_ |
                    Where-Object DistinguishedName -NotMatch "OU=$($Site),OU=Facilities,DC=PHSI,DC=PRIMEHEALTHCARE,DC=COM" |
                    Select-Object -ExpandProperty DistinguishedName
                } 
        If ($Users) {
            $Users |
            Remove-ADGroupMember -Identity sg_$($Site)-AllUsers -Members $Users -WhatIf
        } Else {
            Write-Host 'No Users to process'
        }
    
    }
}


function Add-SiteShadowGroupMembers {
    [CmdletBinding()]
    param(
        [parameter(
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            Position = 0)
        ]
        $Site
    )

    process {

        $Users = Get-ADUser -Filter { Enabled -eq $true } -SearchBase "OU=$($Site),OU=Facilities,DC=PHSI,DC=PRIMEHEALTHCARE,DC=COM" -Properties MemberOf |
            Select-Object SamAccountName, MemberOf 
        $Group = Get-ADGroup -Identity sg_$Site-AllUsers
        ForEach ($User in $users) {
            $isNotMember = -not ($User.MemberOf -contains "$($Group.DistinguishedName)")
            If ($isNotMember) {
                $User
                Add-ADGroupMember -Identity $Group.SamAccountName -Members $user.SamAccountName -WhatIf
            }
        }
    
    }
}

function Build-ShadowGroup {
    [CmdletBinding()]
    param(
        [parameter(
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            Position = 0)
        ]
        $Site
    )

    process {
        
        Try{
            Get-ADGroup -Identity "sg_$($Site)-Allusers" -ErrorAction Stop |
            Out-Null
        }
        Catch{
            $newADGroupSplat = @{
                Name = "sg_$($OU)-AllUsers"
                SamAccountName = "sg_$($OU)-AllUsers"
                GroupCategory = 'Security'
                GroupScope = 'Global'
                Path = "OU=Groups,OU=EnterpriseObjects,DC=PHSI,DC=PRIMEHEALTHCARE,DC=COM"
                
            }
            New-ADGroup @newADGroupSplat -WhatIf
        }
    
    }
}


#endregion


#Use this section to Exclude OUs
$WhereFilter = {
    Name -ne ".ArchivedObjects" -and
    Name -ne ".CatchAll" -and
    Name -ne "IOC (MSO)" -and
    Name -notlike "DC-*"
}

#Pull in all the Organization Unit Names
$OUPararms = @{
    Filter = $WhereFilter
    SearchBase = "OU=Facilities,DC=PHSI,DC=PRIMEHEALTHCARE,DC=COM"
    SearchScope =  "OneLevel"
}

Get-ADOrganizationalUnit @OUPararms |
Select-Object Name

#Clear-SiteShadowGroup -Site SMRMC 
#Add-SiteShadowGroup -Site SMRMC