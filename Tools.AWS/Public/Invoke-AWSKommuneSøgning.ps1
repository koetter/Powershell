function Invoke-AWSKommuneSøgning {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $q
    )

    $url = "http://dawa.aws.dk/kommuner?q=" + $q + "*"
    $data = Invoke-RestMethod -Uri $url
    return $data
}