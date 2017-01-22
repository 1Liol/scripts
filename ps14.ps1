<#
13.	You have text file. You need to find all lines in it that contain word “QA” and write them to a file “QA.txt”
#>
function Get-QA
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                  Position=0)]
                  $Source
    )

    Begin
    {
    Get-Content $Source | Select-String -Pattern "QA" > StrContQA.txt
    }
}