function Invoke-AWSAdgangsadresserQuery {
    [CmdletBinding()]
    Param(
        [parameter(position=0, Mandatory=$true)][String] $q
        ,[parameter(position=17, Mandatory=$false)][String] $srid = "25832"
        ,[parameter(position=18, Mandatory=$false)][String] $format = "geojson"
    )

    $url = "http://dawa.aws.dk/adgangsadresser?q=" + $q + "*"

    $url = $url + "&srid=" + $srid + "&format=" + $format

    Write-Host $url
    $data = Invoke-RestMethod -Uri $url
    return $data.features
}