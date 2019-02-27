function Invoke-AWSAdgangsadresseOpslag {
    Param(
        [parameter(position=0, Mandatory=$true)][String] $id
    )

    $url = "http://dawa.aws.dk/adgangsadresser/" + $id
    $data = Invoke-RestMethod -Uri $url
    return $data
}