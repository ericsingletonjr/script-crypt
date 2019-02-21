# Parameters to determine the amount of headers and
# number of entries to be recorded. Defaults are set to
# 3 column and 10 entries
param (
    [int32]$Count = 10
)
$ColNum = 3

# Used to find the current directory of the script when running
function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}
$path = (Get-ScriptDirectory)

# A check to see if the names file exists or not
# Will create the file or load the file depending on
# result
$FileExist = (Test-Path -Path $path'\headers.csv')
if(!$FileExist)
{
    Write-Host 'File doesn''t exist...creating header file'
    $headerNames = @(
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
    $headerNames | Export-Csv -Path $path'\headers.csv' -NoTypeInformation
    
}
else 
{
    Write-Host 'Already exists...'
    $headerNames = Import-Csv -Path $path'\headers.csv'
}

# Create an array a well as changing our headerNames variable to
# an arrayList for easier removal with our random
$headerArray = @(0..($ColNum-1))
$headerNames = New-Object System.Collections.ArrayList(,$headerNames)

# Randomly select header names for our customObjects KVP for the 
# csv generation
foreach($col in $headerArray)
{
    $randNum = (Get-Random -Minimum 0 -Maximum $headerNames.Count)
    $headerArray[$col] = $headerNames[$randNum].Name
    $headerNames.RemoveAt($randNum)
}

# We create our array of custom objects and then iterate through
# each object, filling out the KVPs
$seedData = @(0..($Count-1))
foreach ($col in $seedData)
{
    $seedData[$col] = [PSCustomObject]@{
        $headerArray[0] = 'Value1'
        $headerArray[1] = 'Value2'
        $headerArray[2] = 3
    }
}

# Finally export our seed data into a csv
$seedData | Export-Csv -Path $path'\seed.csv' -NoTypeInformation