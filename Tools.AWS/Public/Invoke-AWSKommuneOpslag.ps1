function Invoke-AWSKommuneOpslag {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $kommunekode
    )

    $url = "http://dawa.aws.dk/kommuner/" + $kommunekode
    $data = Invoke-RestMethod -Uri $url
    return $data
}
