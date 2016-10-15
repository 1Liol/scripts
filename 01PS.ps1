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
