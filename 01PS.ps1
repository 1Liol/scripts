function GetString([String[]]$serviceName) {
   
    foreach ($i in $serviceName)
    
    {Write-Output  $i >> C:\scripts\test.txt}
   
}
