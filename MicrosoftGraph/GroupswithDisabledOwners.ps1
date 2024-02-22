Try {
    $Groups = Get-MgGroup -Filter "groupTypes/any(c:c eq 'Unified')" -All
    ForEach ($Group in $Groups) {
        $Group.DisplayName
        Get-MgGroupOwner -GroupId $Group.Id |
            ForEach-Object { Get-MgUser -UserId $_.Id -Property AccountEnabled, DisplayName, UserPrincipalName | Select-Object @{n='GroupID';e={$Group.Id}},@{n='GroupDisplayName';e={$Group.Id}},AccountEnabled, DisplayName, UserPrincipalName | Export-Csv -Path D:\temp\UnifiedGroupCleanup.csv -IncludeTypeInformation -Append}
    }
} Catch {
    Connect-Graph -Scopes 'GroupMember.Read.All', 'User.Read.All', 'Group.Read.All'
}
