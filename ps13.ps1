<#
 # 12.	You have two folders. You need to compare files in them and write files names that for the files that are identical to “files.txt” file
#>


Param(
[parameter(Mandatory=$true)]
[string]$Source

)
New-Item -Path . -Name Files.txt
Get-ChildItem -Path $Source -Recurse | Select-Object Name | Out-File Files.txt 