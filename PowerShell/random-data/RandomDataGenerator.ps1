function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}

$path = (Get-ScriptDirectory)

$FileExist = (Test-Path -Path $path'\headers.csv')

if(!$FileExist)
{
    $headerCreate = @(
        [PSCustomObject]@{
            Name = 'Error'
        }
        [PSCustomObject]@{
            Name = 'MachineName'
        }
        [PSCustomObject]@{
            Name = 'ID'
        }
        [PSCustomObject]@{
            Name = 'Memory'
        }
        [PSCustomObject]@{
            Name = 'Space'
        }
        [PSCustomObject]@{
            Name = 'Event'
        }
        [PSCustomObject]@{
            Name = 'Message'
        }
        [PSCustomObject]@{
            Name = 'Level'
        }
    )
    $headerCreate | Export-Csv -Path $path'\headers.csv' -NoTypeInformation
}
else 
{
    Write-Host 'Already exists...'
    $headerNames = Import-Csv -Path $path'\headers.csv'
}
$headerNames
$seedData = @(
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

$seedData | Export-Csv -Path $path'\seed.csv' -NoTypeInformation