<# [Powershell only] Write function that you can pipe newline-delimited list of strings (from file) into. The script returns status of the local service with name equal to the string (for each string). If service with this name doesn’t exist, return nothing. Script has a switch -running that makes it return only running services. Use Param(). Example usage: “get-content 1.txt | myfunction -running” #>
function PutSTR() {

    Param(
    [String[]]$serviceName,
    [Switch]$running,
    [Switch]$clear
    )
    
    
 foreach ($i in $serviceName){
 
  Write-Output  $i >> C:\scripts\test.txt
 
foreach ($a in Get-Content C:\scripts\test.txt){
  if (Get-Service $a -ErrorAction SilentlyContinue ) {
      Get-Service -Name $a | Group-Object Status 
      }
    }
 }
 
foreach ($b in Get-Content C:\scripts\test.txt) {
  if ($running) { Get-Service -Name $b -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq "running"}} 
  }
  if($clear) {Clear-Content C:\scripts\test.txt}

}


