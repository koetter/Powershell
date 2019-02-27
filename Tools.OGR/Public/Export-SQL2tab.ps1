Function Export-SQL2tab {
    Param(
        [parameter(position=0, Mandatory=$true)][String] $table
        ,[parameter(position=1, Mandatory=$false)][String] $path = "."
        ,[parameter(position=2, Mandatory = $false)][String] $database = "Staging"
    )

    If ($path.substring($path.length - 1) -ne "\") {
        $path= "$path\"
        }
    Write-Output "$path$table.tab"

    $conn = Get-OGRConnectionString $database

    ogr2ogr.exe -f "MapInfo File" "$path$table.tab" $conn -a_srs "EPSG:25832" -progress -skipfailures
}