function Invoke-AWSEjerlav {
    [CmdletBinding()]
    Param(
        [parameter(position=0, Mandatory=$false)][String] $regionskode = "1084"
        ,[parameter(position=1, Mandatory=$false)][String] $kommunekode = ""
        ,[parameter(position=2, Mandatory=$false)][String] $kommune = ""
        ,[parameter(position=3, Mandatory=$false)][String] $ejerlavskode = ""
        ,[parameter(position=4, Mandatory=$false)][String] $ejerlavsnavn = ""
        ,[parameter(position=6, Mandatory=$false)][String] $x = ""
        ,[parameter(position=7, Mandatory=$false)][String] $y = ""
        ,[parameter(position=8, Mandatory=$false)][String] $radius = ""
        ,[parameter(position=9, Mandatory=$false)][String] $polygon = ""
        ,[parameter(position=10, Mandatory=$false)][String] $srid = "25832"
        ,[parameter(position=11, Mandatory=$false)][String] $format = "geojson"
    )

    $url = "https://dawa.aws.dk/ejerlav?regionskode=" + $regionskode

    If (!($kommunekode -eq "")) {$url = $url + "&kommunekode=" + $kommunekode}
    If (!($kommune -eq "")) {$url = $url + "&kommune=" + $kommune}
    If (!($ejerlavskode -eq "")) {$url = $url + "&kode=" + $ejerlavskode}
    If (!($ejerlavsnavn -eq "")) {$url = $url + "&navn=" + $ejerlavsnavn}
    If (!($x -eq "") -and !($y -eq "") -and ($radius -eq "")) {$url = $url + "&x=" + $x + "&y=" + $y}
    If (!($x -eq "") -and !($y -eq "") -and !($radius -eq "")) {$url = $url + "&cirkel=" + $x + "," + $y + "," + $radius}
    If (!($polygon -eq "")) {$url = $url + "&polygon=" + $polygon}

    $url = $url + "&srid=" + $srid + "&format=" + $format

    Write-Host $url
    $data = Invoke-RestMethod -Uri $url
    return $data.features
}