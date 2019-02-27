
Function Convert-Shp2tab {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $shapefile
    )

    if (Test-Path $shapefile){
        $fileitem = Get-Item -Path $shapefile
        $targetdir =  $fileitem.DirectoryName + "\shp2tab\"
        If (!(Test-Path $targetdir)) {
            New-Item -ItemType Directory -Force -Path $targetdir
            }
        } else {
        Write-Output "Kunne ikke finde filen " $shapefile
        Write-Output "Kontroller om filen eksistere"
        return 0
        }

    if ($fileitem.Extension -eq ".shp") {
        $tabfile = $targetdir +  $fileitem.BaseName.ToLower() + ".tab"
        Write-Output "konverterer $shapefile til $tabfile"
        ogr2ogr.exe -f "MapInfo File" $tabfile $shapefile -a_srs "EPSG:25832" -progress -skipfailures
        return 1
    } else {
        Write-Output "Filen er ikke en shape-fil"
        Write-Output "Afslutter programmet"
        return 0
        }

}