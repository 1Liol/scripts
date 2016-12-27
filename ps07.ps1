<#7.	Create a file that will clean specified directory (delete all files from it).
Note: unlike previous tasks 
directory name is not constant and known. 
It is passed to bat file as a parameter.#>

param (
    [string]$path

)

Remove-Item -Recurse $path/**