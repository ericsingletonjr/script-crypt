# Used to find the current directory of the script when running
function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}
$path = (Get-ScriptDirectory)

# Runs our schema creation script so we have a templated
# object to use to create our setup
$CustomSchema = & '.\customSchema_create.ps1'
$CustomSchema