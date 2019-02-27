Function Import-GIS2SQL {
    <#  
        .SYNOPSIS
            Import-GIS2SQL $file [$database] [$table] [$append]
        .DESCRIPTION
            Indlæsning af GIS-fil ind i en SQL server tabel vha. OGR2OGR. Eksisterende tabel
            overskrives, hvis den findes.
        .PARAMETER file
            fuld eller relativ sti til GIS-filen
        .PARAMETER conn
            Anvend "KMI eller "KMI_test". Undlades argumentet anvendes KMI_test
        .PARAMETER table
            tabelnavn i databasen. Undlades argumentet anvendes filnavnet
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
        [parameter(position = 0, Mandatory = $true)][String] $file,
        [parameter(position = 1, Mandatory = $false)][String] $database = "Staging",
        [parameter(position = 2, Mandatory = $false)][String] $table,
        [parameter(position = 3, Mandatory = $false)][String] $append = 0
    )
        
    if (Test-Path $file) {
        $fileitem = Get-Item -Path $file
        # Write-Host "Filen" $fileitem.fullname "eksisterer."
    }
    else {
        Write-Output  "Kunne ikke finde filen " $file
        Write-Output  "Kontroller om filen eksistere"
        return
    }
    
    if ($fileitem.Extension.ToLower() -ne ".shp" -and $fileitem.Extension.ToLower() -ne ".tab") {
        Write-Output "Filformatet er ikke understøttet"
        Write-Output "Afslutter programmet"
        return
    }
    
    $conn = Get-OGRConnectionString $database
    
    if (!$table) {
        $table = $fileitem.BaseName
    }
    
    $env:OCI_FID = "idx"
    Write-Output ""
    Write-Output "Importerer filen $($fileitem.Name) til tabellen $($table) i databasen $($database)"
    Write-Output $env:OCI_FID
    
    If ($append -eq 1) {
        ogr2ogr.exe -append -f MSSQLSpatial $conn $fileitem.FullName -nln $table -lco "GEOM_NAME=geom" -a_srs "EPSG:25832" -progress -skipfailures
    }
    Else {
        ogr2ogr.exe -overwrite -f MSSQLSpatial $conn $fileitem.FullName -nln $table -lco "GEOM_NAME=geom" -a_srs "EPSG:25832" -progress -skipfailures
    }
    
}