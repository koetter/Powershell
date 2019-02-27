function Invoke-AWSRegionOpslag {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $regionskode
    ,[parameter(position=1, Mandatory=$false)][String] $format="geojson"
    ,[parameter(position=2, Mandatory=$false)][String] $srid="25832"

    )

    $url = "http://dawa.aws.dk/regioner/" + $regionskode
    $url = $url + "?format=" + $format
    $url = $url + "&srid=" + $srid
    $data = Invoke-RestMethod -Uri $url
    return $data
}
