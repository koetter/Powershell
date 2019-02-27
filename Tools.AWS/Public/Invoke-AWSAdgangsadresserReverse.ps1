function Invoke-AWSAdgangsadresserReverse {
    param(
    [parameter(position=0, Mandatory=$true)][String] $x
    ,[parameter(position=1, Mandatory=$true)][String] $y
    ,[parameter(position=2, Mandatory=$false)][String] $srid="25832"
    ,[parameter(position=3, Mandatory=$false)][String] $format="geojson"
    )
    $url = "http://dawa.aws.dk/adgangsadresser/reverse?x=" + $x + "&y=" + $y
    $url = $url + + "&srid=" + $srid + "&format=" + $format
    $data = Invoke-RestMethod -Uri $url
    return $data.features
}