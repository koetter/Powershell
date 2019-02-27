
Function Import-WFS2SQL {
    <#  
    .SYNOPSIS
        Import-WFS2SQL $file [$db] [$table] 
    .DESCRIPTION
        Indlæsning af WFS data til en SQL server tabel vha. ogr2ogr. Eksisterende tabel
        overskrives, hvis den findes.
    .PARAMETER feature
        fuld eller relativ sti til GIS-filen
    .PARAMETER database
        Anvend "KMI eller "KMI_test". Undlades argumentet anvendes KMI_test
    .PARAMETER table
        tabelnavn i databasen. Undlades argumentet anvendes filnavnet
    .PARAMETER append
        Default sat til 0, som overskriver tabellen. Hvis parameteren sættes til 1, tilføjes data i tabellen
    .NOTES
        Author         : Allan Køtter
        Prerequisite   : PowerShell V4 and OGR2OGR
    .LINK  
        Script not posted on the internet
    .EXAMPLE
        -     
    .EXAMPLE    
        -
    #>
    [CmdletBinding()]
    Param(
    [parameter(position=0, Mandatory=$true)][String] $feature,
    [parameter(position=1, Mandatory=$false)][String] $database="Staging",
    [parameter(position=2, Mandatory=$false)][String] $table,
    [parameter(position=3, Mandatory=$false)][String] $append = 0
    )
    
    $conn = Get-OGRConnectionString $database
    
    $baseurl = "http://wfs2-miljoegis.mim.dk/dai/ows?service=WFS&request=GetFeature&typename=" + $feature
    $bbox = "&bbox=670000,6161000,740000,6230000"
    $url = $baseurl + $bbox

    if (!$table) {
        $table = "ak$($feature)"
        }

    $table = $table.ToLower()

    $env:OCI_FID = "idx"
    Write-Output "Importerer filen " $feature " til tabellen " $table " i databasen " $database
    Write-Output $env:OCI_FID

    If ($append -eq 1) {
        ogr2ogr.exe -append -f MSSQLSpatial $conn $url -lco "GEOM_NAME=geom" -nln $table -a_srs "EPSG:25832" -progress -skipfailures
    } Else {
        ogr2ogr.exe -overwrite -f MSSQLSpatial $conn $url -lco "GEOM_NAME=geom" -nln $table -a_srs "EPSG:25832" -progress -skipfailures

    }

}