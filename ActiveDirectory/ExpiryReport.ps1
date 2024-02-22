
# Enter your script to process requests.
#$ReportType = 'Users'
#$ReportType | Out-Null
Switch ($ReportType) {
    'Vendors' {
        $ADParams = @{
            Filter     = { Enabled -eq $true -and accountexpires -ne '9223372036854775807' -and accountexpires -ne '0' }
            SearchBase = 'ou=vendors,ou=facilities,dc=phsi,dc=primehealthcare,dc=com'
            Properties = 'Manager', 'accountExpires', 'Company', 'logonCount', 'lastLogonTimestamp', 'title', 'department', 'extensionattribute15', 'employeeREFID'
        }
        $WhereFilter = {
            $_.employeeREFID -ne $null
        } 
    }
    'Users' {
        $ADParams = @{
            Filter     = {
                Enabled -eq $true -and 
                accountexpires -ne '9223372036854775807' -and 
                accountexpires -ne '0' -and
                Manager -ne 'CN=No Manager in Lawson,OU=ServiceAccounts,OU=EnterpriseObjects,DC=phsi,DC=primehealthcare,DC=com'
            }
            SearchBase = 'ou=facilities,dc=phsi,dc=primehealthcare,dc=com'
            Properties = 'Manager', 'accountExpires', 'Company', 'logonCount', 'lastLogonTimestamp', 'title', 'department', 'extensionattribute15'
        }
        
        $WhereFilter = {
            $_.DistinguishedName -notmatch 'OU=Vendors|OU=.CatchAll' -and
            $_.Manager -ne $null
        }
    }
    
}
#region Running
If ($ReportType -eq 'Users') {
    $Object = Get-ADUser @ADParams | Where-Object $WhereFilter
    $CustomTable = $Object.ForEach{
   
        [PSCustomObject]@{
            'FirstName'             = $_.GivenName
            'SurName'               = $_.SurName
            'UserPrincipalName'     = $_.UserPrincipalName
            'SamAccountName'        = $_.SamAccountName
            'AccountExpirationDate' = ([Datetime]::FromFileTime($_.accountExpires))
            'AccountExpiresIn'      = (New-TimeSpan -Start (Get-Date) -End ([Datetime]::FromFileTime($_.accountExpires))).Days
            'Company'               = $_.Company
            'Manager'               = ((Get-ADUser -Identity $_.Manager -Properties DisplayName).UserPrincipalName)
            'Title'                 = $_.title
            'Department'            = $_.department
            'Hospital'              = $_.extensionattribute15
        }
    
    }
    $CustomTable | Sort-Object AccountExpiresIn -Descending | 
        Group-Object -Property Manager |
        Select-Object Name, Group
}

If ($ReportType -eq 'Vendors') {
    $Object = Get-ADUser @ADParams | Where-Object $WhereFilter 
    $CustomTable = $Object.ForEach{
        $Mgr = Try {
            (Get-ADUser -Identity $_.employeeREFID -ErrorAction Stop).UserPrincipalName 
        } Catch {
            #$_
        }
   
        [PSCustomObject]@{
            'FirstName'             = $_.GivenName
            'SurName'               = $_.SurName
            'UserPrincipalName'     = $_.UserPrincipalName
            'SamAccountName'        = $_.SamAccountName
            'AccountExpirationDate' = ([Datetime]::FromFileTime($_.accountExpires))
            'AccountExpiresIn'      = (New-TimeSpan -Start (Get-Date) -End ([Datetime]::FromFileTime($_.accountExpires))).Days
            'Company'               = $_.Company
            'Manager'               = $Mgr
            'Title'                 = $_.title
            'Department'            = $_.department
            'Hospital'              = $_.extensionattribute15
        }
        
    }
    $CustomTable | Sort-Object AccountExpiresIn -Descending | 
        Group-Object -Property Manager |
        Select-Object Name, Group
}
#endregion
