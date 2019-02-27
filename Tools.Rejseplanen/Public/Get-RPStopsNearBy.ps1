
function Get-RPStopsNearBy {
    <#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.
    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.
    .NOTES
        File Name      : xxxx.ps1
        Author         : J.P. Blanc (jean-paul_blanc@silogix-fr.com)
        Prerequisite   : PowerShell V2 over Vista and upper.
        Copyright 2011 - Jean Paul Blanc/Silogix
    .LINK
        Script posted over:
        http://silogix.fr
    .EXAMPLE
        Example 1
    .EXAMPLE
        Example 2
    #>
    [CmdletBinding()]
    Param(
    [parameter(position=0, Mandatory=$true)][String] $x
    ,[parameter(position=1, Mandatory=$true)][String] $y
    ,[parameter(position=2, Mandatory=$true)][String] $radius
    )

    $url = $rpurl + "/stopsNearby?format=json&maxNumber=1&coordX=" + $x + "&coordY=" + $y + "&maxRadius=" + $radius
    $data = Invoke-RestMethod -Uri $url
    return $data

}