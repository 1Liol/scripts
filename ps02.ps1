<#
4.Create a file that will deploy windows service.
Assumed that this service already installed and running. 
You need to stop this service, copy new service files from specified folder to service
installation folder and restarts the service. Service installation folder and folder to
copy files from are assumed to be known constants.
#>

$Spool = "C:\Windows\System32\spool","C:\Windows\System32\spoolsv.exe","C:\Windows\System32\spoolss.dll"

Stop-Service Spooler
$Folder = "C:\spool"

if (-not(Test-Path $Folder.trim())) {

New-Item -Path $Folder -ItemType Directory

}

Write-Host "OK" 
Copy-Item  -Path  $Spool -Recurse -Destination $Folder -ErrorAction SilentlyContinue
pushd $Folder
sc.exe config Spooler binPath=.\spoolsv.exe 
net start Spooler
popd