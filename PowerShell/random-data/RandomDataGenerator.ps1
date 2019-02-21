function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}

$path = (Get-ScriptDirectory)

$employees = @(
    [PSCustomObject]@{
        FristName = 'Adam'
        LastName = 'Bertram'
        Department = 'Executive Office'
    }
    [PSCustomObject]@{
        FristName = 'Don'
        LastName = 'Jones'
        Department = 'Janitorial Services'
    }
)

$employees | Export-Csv -Path $path'\seed.csv' -NoTypeInformation