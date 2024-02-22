<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-OrganzationUnitAccessRights {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
                    
        $DistinguishedName
    )

    Begin {
        function IsBuiltInGroup($group) {
            $Domain = (Get-ADDomain).DistinguishedName
            $builtInGroups = Get-Acl -Path "AD:CN=Builtin,$($Domain)"  |
            Select-Object -ExpandProperty Access | 
            Select-Object -ExpandProperty IdentityReference
        
            return $builtInGroups -contains $group
        }
    }
    Process {
        #Pull All ACLs for specific OU and remove ACLs that are in the Buildin OU on the domain
        Get-Acl -Path "AD:$($DistinguishedName)" |
        Select-Object -ExpandProperty Access | Where-Object { -not (IsBuiltInGroup $_.IdentityReference.Value) } |
        #Group Identity References
        Group-Object IdentityReference
        

    }
    End {
    }
}

function IsBuiltInGroup($group) {
    $Domain = (Get-ADDomain).DistinguishedName
    $builtInGroups = Get-Acl -Path "AD:CN=Builtin,$($Domain)"  |
    Select-Object -ExpandProperty Access | 
    Select-Object -ExpandProperty IdentityReference

    return $builtInGroups -contains $group
}

$Data = Get-Acl -Path 'AD:OU=FACILITIES,DC=phsi,DC=primehealthcare,DC=com' |
Select-Object -ExpandProperty Access | Where-Object { -not (IsBuiltInGroup $_.IdentityReference.Value) } |
Group-Object IdentityReference

ForEach($Line in $Data){
    [PSCustomObject]@{
        Identity = $Line.Name
        Rights = $Line.Group.ActiveDirectoryRights | Select-Object -Unique
    }
}