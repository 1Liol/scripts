<#
1.	Create a file that will ping remote server and write results to 
<System Disk>:\ping.txt.
#>

$file = 'ping.txt'
$ping = '8.8.8.8'
if (-not(Test-Path $file)){
New-Item -Path $env:SystemDrive$file -ItemType File -Force | ping $ping | Out-File $file
}
else{
ping 8.8.8.8 | Out-File $env:SystemDrive$file
}
