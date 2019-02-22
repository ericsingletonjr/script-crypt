# ------ SCRIPT PARAMETERS ------ #
# Parameters to determine the amount of headers and
# number of entries to be recorded. Defaults are set to
# 3 column and 10 entries
param (
    [int32]$Count = 10
)
$ColNum = 3
# TODO: make it more fluid and responsive to configurations

# ----- DEFINED FUNCTIONS ------ #
# Used to find the current directory of the script when running
function Get-ScriptDirectory
{   
    Split-Path $script:MyInvocation.MyCommand.Path
}
# Used to create a random number percentage value for customObjects
function Get-RandomNumberValuePercent
{
    Get-Random -Minimum 00.00 -Maximum 100.00
}
# Used to create padded random numbers
function Get-RandomNumberPadded
{
    Get-Random -Minimum 00000 -Maximum 99999
}
# Used to create a random string value for customObjects
# Has a parameter to change the amount of characters if
# desired
function Get-RandomStringValue
{
    Param(
        [int] $amt = 10
    )
    -join ((65..90) + (97..122) | Get-Random -Count $amt | % {[char]$_})
}
# Used to create strings with number combinations for varied
# data
function Get-RandomStringNumberCombo
{
     "$(Get-RandomStringValue(5))-$(Get-RandomNumberPadded)-$(Get-RandomStringValue(5))"
}

# ------ GLOBAL VARIABLES ------ #
# Grabs current directoy of the script
$path = (Get-ScriptDirectory)

# A check to see if the names file exists or not
$FileExist = (Test-Path -Path $path'\headers.csv')

# ------ EXECUTION ------ #
# Create the file or load the file depending on
# result
if(!$FileExist)
{
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
        $headerArray[0] = (Get-RandomStringValue)
        $headerArray[1] = (Get-RandomStringNumberCombo)
        $headerArray[2] = (Get-RandomNumberValuePercent)
    }
}

# Finally export our seed data into a csv
$seedData | Export-Csv -Path $path'\seed.csv' -NoTypeInformation