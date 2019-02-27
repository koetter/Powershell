function Invoke-AWSAdgangsadresseDatavask {
    Param(
        [parameter(position=0, Mandatory=$true)][String] $betegnelse
    )

    $url = "http://dawa.aws.dk/datavask/adgangsadresser?betegnelse=" + $betegnelse
    $data = Invoke-RestMethod -Uri $url
    return $data
}