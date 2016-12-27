param (
[string]$SourcePath,
[string]$DistPath
)
gci . -File | Select-Object -Property Name | Out-File .\file.txt
$a = Get-Content .\file.txt | where {$_.name}a

Write-Output .\file.txt

