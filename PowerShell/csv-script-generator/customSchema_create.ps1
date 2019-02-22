# Method used to take in user inputted string and split header names
# to create the keys for our custom object
function Set-ColNames
{
    Param (
        [String]$text
    )
    $text.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries)
}

function Set-ColTypes
{
    Param (
        [String]$text
    )
    $text.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries)
}

# Interactive section for the User for setting
# column names
Write-Host 'Please enter the names of your columns delimited with commas'
Write-Host 'example: ID,Name,Age,Country.....'
$ColNames = (Set-ColNames(Read-Host))
Write-Host '-------------------------------------'
Write-Host 'Please enter the types for each column in the same order as'
Write-Host 'you inputted the column names.'
Write-Host 'Accepted types are as follows: (* means not implemented yet)'
Write-Host '-------------------------------------'
Write-Host 'string  | int  | decimal | dateTime*|'
Write-Host 'char    | long*| single* | percent  |'
Write-Host 'byte*   | bool | double* |          |'
Write-Host '-------------------------------------'
Write-Host 'example: int,string,int,string.....'
$ColTypes = (Set-ColTypes(Read-Host))

# Here we create our empty customObject and then 
# iterate through the ColNames and ColTypes to create our
# schema object
$CustomSchema = [PSCustomObject]@{ }

for($i=0; $i -lt $ColNames.Count; $i++)
{
    $CustomSchema | Add-Member -MemberType NoteProperty -Name $ColNames[$i] -Value $ColTypes[$i]
}
$CustomSchema