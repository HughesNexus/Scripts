function NormalizeString($val)
{
    if($val -and $val.GetType().Name -eq "String")
    {
        return $val.Replace("'", "''")
    }
    return $val
}

$date = Get-Date -format "yyyyMMdd"
$StopWatch = [system.diagnostics.stopwatch]::startnew()
$connStringIAM = "Data Source=#;Initial Catalog=#;Integrated Security=True;Encrypt=false"
$sqlQueryIAM = "select * from # where relation_ship_status = 'Active'"
$users =  Invoke-Sqlcmd -Query $sqlQueryIAM -ConnectionString $connStringIAM


$connString = "Data Source=#;Initial Catalog=IAMSync;Integrated Security=True;Encrypt=false"
foreach($usr in $users)
{
$usr.GivenName = NormalizeString($usr.GivenName)
$usr.SurName = NormalizeString($usr.SurName)
$usr.DisplayName = NormalizeString($usr.DisplayName)
$usr.Job_Title = NormalizeString($usr.job_Title)
$usr.Company = NormalizeString($usr.COmpany)
$usr.StreetAddress = NormalizeString($usr.StreetAddress)
$usr.Office = NormalizeString($usr.Office)
$usr.City = NormalizeString($usr.City)


    $sqlQuery = "EXEC [dbo].[AddOrUpdateIAMUser] '{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', '{11}', '{12}', '{13}', '{14}', '{15}', '{16}', '{17}', '{18}', '{19}', '{20}', '{21}', '{22}', '{23}' " -f 
            $usr.iam_user_id,
            $usr.SamAccountName,
			$usr.GivenName, 
			$usr.SurName, 
			$usr.DisplayName, 
			$usr.Job_Title, 
			$usr.Department, 
			$usr.Company, 
			$usr.StreetAddress, 
			$usr.City, 
			$usr.State,  
			$usr.PostalCode, 
			$usr.country, 
			$usr.office, 
			$usr.job,
			$usr.employeeNumber, 
			$usr.employeeID, 
			$usr.EmployeeType,  
			$usr.relation_ship_status,
			$usr.UserPrincipalName,
			$usr.manager,
			$usr.division,
			$usr.facility_short_name,
            $Usr.region

    
    Try{
    Invoke-Sqlcmd -Query $sqlQuery -ConnectionString $connString -ErrorAction Stop
    }
    Catch{
    Write-Host $sqlQuery -ForegroundColor Yellow
    Write-Error $Error[0]
    }
}

$StopWatch.Stop()
$StopWatch.Elapsed.Minutes

$Time = "$($date) $($StopWatch.Elapsed.Minutes) Minutes to run" | Out-File E:\IAMSync\IAMObjTimeLog.txt -Append