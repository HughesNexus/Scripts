$CsvList = Get-ChildItem -Path '\\ont-corpfile01\corporatepayroll$\ACA Java Compile\Java Files' -Filter '*.csv'
Switch -Wildcard ($CsvList.FullName)
{
    '*EMBEN_*' {Import-Csv -Path $_ | Export-Csv -Path D:\Share\EMBEN_Payroll.csv -Append}
    '*DEPBEN_*' {Import-Csv -Path $_ | Export-Csv -Path D:\Share\DEPBEN_Payroll.csv -Append}
    '*EMP_*' {Import-Csv -Path $_ | Export-Csv -Path D:\Share\EMP_Payroll.csv -Append}
    '*PAY_*' {Import-Csv -Path $_ | Export-Csv -Path D:\Share\PAY_Payroll.csv -Append}
    '*LOA_*' {Import-Csv -Path $_ | Export-Csv -Path D:\Share\LOA_Payroll.csv -Append}
}

