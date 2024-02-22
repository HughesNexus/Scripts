

Try{
    $Users = Get-MgUser -Filter 'accountEnabled eq false' -Property AccountEnabled,DisplayName,UserPrincipalName,OnPremisesSyncEnabled,LastSigninDateTime -ErrorAction Stop}
Catch{
    Connect-Graph -Scopes "User.ReadWrite.All"
}

ForEach ($User in $Users) {

    $Groups = Get-MgUserMemberGroup -UserId $User.UserPrincipalName -SecurityEnabledOnly:$false |
        ForEach-Object { Get-MgGroup -GroupId $_ | Where-Object -Not OnPremisesSyncEnabled }

    [PSCustomObject]@{
        Enabled = $User.AccountEnabled
        UserPrincipalname = $User.UserPrincipalName
        AzureGroupsID       = ($Groups | Select-Object ID).ID -join ','
        AzureGroupsName       = ($Groups | Select-Object DisplayName).DisplayName -join ','
        OnPremisesSyncEnabled = $User.OnPremisesSyncEnabled
        LastSigninDateTime = $User.SignInActivity.LastSignInDateTime
    } | Export-Excel -path D:\temp\InActiveUserGroupReport.xlsx -Append
}