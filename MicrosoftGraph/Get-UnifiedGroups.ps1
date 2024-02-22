#Connect-mgGraph -Scopes GroupMember.Read.All
$Call = Invoke-MgGraphRequest -Method Get -Uri "https://graph.microsoft.com/beta/groups?$filter=groupTypes/any(c:c eq 'Unified')"
$Groups = $Call.Value 
$NextLink = $Call.'@odata.nextLink'

do {

    $NextCall = Invoke-MgGraphRequest -Method Get -Uri $NextLink
    $NextLink = $NextCall.'@odata.nextLink'
    $NextLink
    $Groups += $NextCall.Value 
    
} until (
    $NextLink -eq $null 
)
$CloudOnly = $Groups | Where-Object -not onPremisesSyncEnabled