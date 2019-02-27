function Invoke-AWSVejnavneOpslag {
    Param(
        [parameter(position=0, Mandatory=$true)][String] $vejnavn
    )

    $url = "http://dawa.aws.dk/vejnavne/" + $vejnavn
    $data = Invoke-RestMethod -Uri $url
    return $data
}