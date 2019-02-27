function Invoke-AWSVejnavneSøgning {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $q
    )

    $url = "http://dawa.aws.dk/vejnavne?q=" + $q + "*"
    $data = Invoke-RestMethod -Uri $url
    return $data
}