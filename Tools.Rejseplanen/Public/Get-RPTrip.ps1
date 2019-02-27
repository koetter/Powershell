
Function Get-RPTrip {
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
    [parameter(position=0, Mandatory=$true)][String] $OrigCoordName
    ,[parameter(position=1, Mandatory=$true)][String] $OrigCoordX
    ,[parameter(position=2, Mandatory=$true)][String] $OrigCoordY
    ,[parameter(position=3, Mandatory=$true)][String] $DestCoordName
    ,[parameter(position=4, Mandatory=$true)][String] $DestCoordX
    ,[parameter(position=5, Mandatory=$true)][String] $DestCoordY
    ,[parameter(position=6, Mandatory=$true)][String] $Datetime
    ,[parameter(position=6, Mandatory=$False)][Bool] $UseBicycle=$False
    ,[parameter(position=6, Mandatory=$False)][int] $MaxWalkingDistanceDep=2000
    ,[parameter(position=6, Mandatory=$False)][int] $MaxWalkingDistanceDest=2000
    ,[parameter(position=6, Mandatory=$False)][int] $MaxCyclingDistanceDep=5000
    ,[parameter(position=6, Mandatory=$False)][int] $MaxCyclingDistanceDest=5000
    )
    
    $url = $rpurl + "/trip?"
    $url = $url + "originCoordName=" + $origCoordName + "&originCoordX=" + $origCoordX + "&originCoordY=" + $origCoordY
    $url = $url + "&destCoordName=" + $destCoordName + "&destCoordX=" + $destCoordX + "&destCoordY=" + $destCoordY
    if ($UseBicycle) {
        $url = $url + "&maxCyclingDistanceDep =" + $MaxCyclingDistanceDep + "&maxCyclingDistanceDest=" + $MaxCyclingDistanceDest
    } else {
        $url = $url + "&maxCyclingDistanceDep =" + $MaxWalkingDistanceDep + "&maxCyclingDistanceDest=" + $MaxWalkingDistanceDest
    }
    $url = $url + "&date=" + (Get-Date($datetime) -Format "dd.MM.yy")
    $url = $url + "&time=" + (Get-Date($datetime) -Format "HH:mm")
    #Write-Host $url
    $data = Invoke-RestMethod -Uri $url
    return $data
}
