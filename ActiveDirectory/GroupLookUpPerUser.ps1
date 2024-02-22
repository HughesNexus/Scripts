$Users = Get-ADGroupMember -Identity sgCitrix-Access-FulcrumSQLDesktop | Select-Object SamAccountName
$Users += Get-ADGroupMember -Identity sgCitrix-Access-DeveloperDesktop | Select-Object SamAccountName

$Data = ForEach($User in $Users){
    $ADInfo = Get-ADUser -Identity $User.SamAccountName -Properties manager,memberof
     
    If($ADInfo.MemberOf -match 'sgPHSIVDI-'){
        [PSCUstomObject]@{
            DistinguishedName = $ADInfo.DistinguishedName
            SamAccountName = $ADInfo.SamAccountName
            Groups = ($ADInfo.MemberOf -join ', ').Replace(',DC=phsi,DC=primehealthcare.com','')
            Manager = $ADInfo.Manager
        }
    }
} 
$Data | Export-Excel -path D:\temp\JDReport.xlsx 


