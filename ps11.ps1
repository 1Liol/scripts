<#
11.	You have file “files.txt” that contains list of required
files (each file name on new line). You need to copy files from
this list from specified folder to another folder.
#>
param(

[Parameter(Mandatory=$true,ValueFromPipeline = $true)]
[string]$file,
[string]$dest
)


foreach($line in Get-Content $file) {
Copy-Item  $line -Destination $dest
}