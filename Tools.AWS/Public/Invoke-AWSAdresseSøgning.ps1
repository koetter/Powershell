﻿function Invoke-AWSAdresseSøgning {
    Param(
        [parameter(position=0, Mandatory=$true)][String] $q
    )

    $url = "http://dawa.aws.dk/adresser?q=" + $q + "*"
    $data = Invoke-RestMethod -Uri $url
    return $data
}