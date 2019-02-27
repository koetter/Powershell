function Invoke-AWSAdgangsadresser {
    [CmdletBinding()]
    Param(
        [parameter(position=0, Mandatory=$false)][String] $regionskode = "1084"
        ,[parameter(position=1, Mandatory=$false)][String] $kommunekode = ""
        ,[parameter(position=2, Mandatory=$false)][String] $kommune = ""
        ,[parameter(position=3, Mandatory=$false)][String] $postnr = ""
        ,[parameter(position=4, Mandatory=$false)][String] $vejnavn = ""
        ,[parameter(position=5, Mandatory=$false)][String] $vejkode = ""
        ,[parameter(position=6, Mandatory=$false)][String] $husnr = ""
        ,[parameter(position=7, Mandatory=$false)][String] $husnrfra = ""
        ,[parameter(position=8, Mandatory=$false)][String] $husnrtil = ""
        ,[parameter(position=9, Mandatory=$false)][String] $ejerlavskode = ""
        ,[parameter(position=10, Mandatory=$false)][String] $ejerlav = ""
        ,[parameter(position=11, Mandatory=$false)][String] $matrikelnr = ""
        ,[parameter(position=12, Mandatory=$false)][String] $esrejendomsnr = ""
        ,[parameter(position=13, Mandatory=$false)][String] $x = ""
        ,[parameter(position=14, Mandatory=$false)][String] $y = ""
        ,[parameter(position=15, Mandatory=$false)][String] $radius = ""
        ,[parameter(position=16, Mandatory=$false)][String] $polygon = ""
        ,[parameter(position=17, Mandatory=$false)][String] $srid = "25832"
        ,[parameter(position=18, Mandatory=$false)][String] $format = "geojson"
    )

    $url = "http://dawa.aws.dk/adgangsadresser?regionskode=" + $regionskode

    If (!($kommunekode -eq "")) {$url = $url + "&kommunekode=" + $kommunekode}
    If (!($kommune -eq "")) {$url = $url + "&kommune=" + $kommune}
    If (!($postnr -eq "")) {$url = $url + "&postnr=" + $postnr}
    If (!($vejnavn -eq "")) {$url = $url + "&vejnavn=" + $vejnavn}
    If (!($vejkode -eq "")) {$url = $url + "&vejkode=" + $vejkode}
    If (!($husnr -eq "")) {$url = $url + "&husnr=" + $husnr}
    If (!($husnrfra -eq "" -or $husnrtil -eq "")) {$url = $url + "&husnrfra=" + $husnrfra + "&husnrtil=" + $husnrtil}
    If (!($ejerlavskode -eq "")) {$url = $url + "&ejerlavskode=" + $ejerlavskode}
    If (!($ejerlav -eq "")) {$url = $url + "&ejerlav=" + $ejerlav}
    If (!($matrikelnr -eq "")) {$url = $url + "&matrikelnr=" + $matrikelnr}
    If (!($esrejendomsnr -eq "")) {$url = $url + "&esrejendomsnr=" + $esrejendomsnr}
    If (!($x -eq "") -and !($y -eq "") -and !($radius -eq "")) {$url = $url + "&cirkel=" + $x + "," + $y + "," + $radius}
    If (!($polygon -eq "")) {$url = $url + "&polygon=" + $polygon}

    $url = $url + "&srid=" + $srid + "&format=" + $format

    Write-Host $url
    $data = Invoke-RestMethod -Uri $url
    return $data.features
}