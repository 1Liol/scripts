<#
5.	Create a file that will re-deploy (update) web application.
Web project is ready to go, only thing you need is to copy new files over old and
restart iis.
#>

$webfold = "C:\webapp"
$webapp = "C:\Users\v-dmvero\Documents\WebApplication1\WebApplication1\*"

Set-ExecutionPolicy -ExecutionPolicy Unrestricted

if (-not(Test-Path $webfold.trim())) {

New-Item -Path $webfold -ItemType Directory

}

Stop-Service W3SVC
 
Copy-Item -Path $webapp -Destination $webfold -Recurse -ErrorAction SilentlyContinue

New-WebApplication -name "WebTets" -PhysicalPath $webfold -Site 'Default Web Site' -Force

Start-Service W3SVC


