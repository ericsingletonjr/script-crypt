param (
    [System.Collections.ArrayList]$CustomSchema = @(),
    [Int]$Count = 10
)

# ------ DEFINED FUNCTIONS ------ #
# Used to create a random number percentage value for customObjects
function Get-RandomNumberValuePercent
{
    Get-Random -Minimum 00.00 -Maximum 100.00
}
# Used to create a random number for int values
function Get-RandomNumberValueInt
{
    Get-Random -Minimum -10000000 -Maximum 10000000
}
# Used to create a random number for int values
function Get-RandomNumberValueDecimal
{
    Get-Random -Minimum -10000.0000 -Maximum 10000.0000
}
# Used to create a random true/false for boolean values
function Get-RandomNumberValueBool
{
    $check = Get-Random -Minimum 0 -Maximum 2
    switch($check)
    {
        0 {return $false}
        1 {return $true}
    }
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
# Used to create a random  char for customObjects
function Get-RandomStringValueChar
{
    -join ((65..90) + (97..122) | Get-Random -Count 1 | % {[char]$_})
}
# Function used to take in the headers and assign types to the values
# in the customObjects. 
function Get-HeaderType
{
    Param(
        [string] $type
    )
    switch($type.ToLower())
    {
        'int' {return Get-RandomNumberValueInt}
        'percent' {return Get-RandomNumberValuePercent}
        'bool' {return Get-RandomNumberValueBool}
        'decimal' {return Get-RandomNumberValueDecimal}
        'string' {return Get-RandomStringValue}
        'char' {return Get-RandomStringValueChar}  
    }
}

$Template = @(0..($Count-1))
# TODO Clean up hashtable values so csv isn't cluttered
# with extra garbage
for($i=0;$i -lt $Count; $i++)
{
    $Temp = [PSCustomObject]@{ }
    for($j=0; $j -lt $CustomSchema[0].Count; $j++)
    {
        $Temp | Add-Member -MemberType NoteProperty -Name $CustomSchema[0].Header[$j] -Value (Get-HeaderType($CustomSchema[1].Type[$j]))
    }
    $Template[$i] = $Temp
}

return $Template