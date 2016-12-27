<#
8.	Create a file that will move files in specified folder on one level up (to root folder).#>

param(

[string]$path

)
$dist = (Get-Item $path).Parent.FullName
Copy-Item -Path $path/** -Destination $dist 
Write-Host "Copied to $dist" 