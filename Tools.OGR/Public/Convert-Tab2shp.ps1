
Function Convert-Tab2shp {
    Param(
    [parameter(position=0, Mandatory=$true)][String] $tabfile
    )

    if (Test-Path $tabfile){
        $fileitem = Get-Item -Path $tabfile
        $targetdir =  $fileitem.DirectoryName + "\tab2shp\"
        If (!(Test-Path $targetdir)) {
            New-Item -ItemType Directory -Force -Path $targetdir
            }
        } else {
        Write-Output "Kunne ikke finde filen " $tabfile
        Write-Output "Kontroller om filen eksistere"
        return 0
        }

    if ($fileitem.Extension -eq ".tab") {
        $shpfile = $targetdir +  $fileitem.BaseName.ToLower() + ".shp"
        Write-Output "konverterer $tabfile til $shpfile"
        ogr2ogr.exe -f "ESRI Shapefile" $shpfile $tabfile -a_srs "EPSG:25832" -progress -skipfailures
        return 1
    } else {
        Write-Output "Filen er ikke en tab-fil"
        Write-Output "Afslutter programmet"
        return 0
        }

}