Function Get-OGRConnectionString {
    <#  
        .SYNOPSIS
            Get-OGRConnectionString $database 
        .DESCRIPTION
            Return a connectionstring for a database to be used by OGR
        .PARAMETER Database
            Name for the database
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
    
        # List of OGR connectionstrings in use, that can be identified by a
        # short name
        Param(
            [parameter(position=0, Mandatory=$false)][String] $database="Staging"
            )
    
        if ($database -eq "Staging"){
            return "MSSQL:server=localhost;database=Staging;trusted_connection=yes;"
        } elseif ($database -eq "MyDB"){
            return "MSSQL:server=MYSQLSERVER;database=MyDB;trusted_connection=yes;"
        } elseif ($database -eq "MyOtherDB"){
            return "MSSQL:server=MYSQLSERVER2;database=MyOtherDB;trusted_connection=yes;"
        } else {
            Write-Output "Could not recognize the database name"
            Write-Output "Leave database blank to import to Staging on localhost"
            return ""
        }
    }