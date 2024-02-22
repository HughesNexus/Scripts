#Connect-Graph -Scopes "User.ReadWrite.All"

ForEach ($User in (Get-ADUser -Filter { Enabled -eq $true } -Properties extensionattribute15 -SearchBase 'ou=ahmc,ou=facilities,dc=phsi,dc=primehealthcare,dc=com')) {
    
    $User.UserPrincipalName
    #Update-MgUser -UserId $User.UserPrincipalName -AccountEnabled:$false
}

