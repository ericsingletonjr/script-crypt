param (
    [string]$TableName = "table",
    [Int]$Count = 10
)
# Used to find the current directory of the script when running
function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}
$path = (Get-ScriptDirectory)

# Runs our schema creation script so we have a templated
# object to use to create our setup
$CustomSchema = & '.\customSchema_create.ps1'

# Creates our dummy data based off of the CustomObj
$TemplateFromSchema = & '.\typeMethods.ps1' -CustomSchema ($CustomSchema) -Count $Count

$TemplateFromSchema | Export-Csv -Path $path'\'$TableName'.csv' -NoTypeInformation