function PutSTR() {

    Param(
    [String[]]$serviceName,
    [String[]]$running
    )
   
    foreach ($i in $serviceName){
    
    Write-Output  $i >> C:\scripts\test.txt

    foreach ($a in Get-Content C:\scripts\test.txt){

    

    if (Get-Service $a -ErrorAction SilentlyContinue ) {
     
     Get-Service -Name $a | Group-Object Status 
    
    }
   }
  }
 }
