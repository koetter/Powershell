
Function Export-SQL2shp {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $table
    ,[parameter(position=1, Mandatory=$false)][String] $path = "."
    ,[parameter(position=2, Mandatory = $false)][String] $database = "Staging"
    )

    If ($path.substring($path.length - 1) -ne "\") {
        $path= "$path\"
        }
    Write-Output "$path$table.shp"

    $conn = Get-OGRConnectionString $database

    ogr2ogr.exe -f "ESRI Shapefile" "$path$table.shp" $conn -a_srs "EPSG:25832" -progress -skipfailures
}
