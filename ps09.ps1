<#9.Create a file that will open specified document in notepad and then close dos command window.#>

param(
[string]$path
)
$a = Get-Process powershell 
notepad.exe $path 
kill $a


