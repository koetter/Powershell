<#
 .Synopsis
  Displays a visual representation of a calendar.

 .Description
  Displays a visual representation of a calendar. This function supports multiple months
  and lets you highlight specific date ranges or days.

 .Parameter Start
  The first month to display.

 .Parameter End
  The last month to display.

 .Parameter FirstDayOfWeek
  The day of the month on which the week begins.

 .Parameter HighlightDay
  Specific days (numbered) to highlight. Used for date ranges like (25..31).
  Date ranges are specified by the Windows PowerShell range syntax. These dates are
  enclosed in square brackets.

 .Parameter HighlightDate
  Specific days (named) to highlight. These dates are surrounded by asterisks.

 .Example
   # Show a default display of this month.
   Show-Calendar

 .Example
   # Display a date range.
   Show-Calendar -Start "March, 2010" -End "May, 2010"

 .Example
   # Highlight a range of days.
   Show-Calendar -HighlightDay (1..10 + 22) -HighlightDate "December 25, 2008"
#>

function Get-DAIDownload {
    [CmdletBinding()]
    param(
    [parameter(position=0, Mandatory=$false)][String] $workdir = "D:\Downloads"
    ,[parameter(position=1, Mandatory=$false)][String] $format = "tab"
    )

    If (!$(Test-Path $workdir)) {
        Write-Output "Workdir does not exist"
        Return
    }

    $formats = "tab", "shp", "gdb"
    If (!($formats.Contains($format))) {
        Write-Output "Formatet er ikke understøttet"
        Write-Output "Brug en af følgende formater:"
        $formats | foreach-Object { Write-Host $_ }
        Return
    }

    If ($format -eq "shp") {$format = 'shape'}

    Write-Output "$(Get-Date -Format HH:mm:ss) - Starter download fra DMP"

    Try {
        $dmp = Invoke-WebRequest -URI "http://www.miljoeportal.dk/myndighed/Arealinformation/Sider/Download-data.aspx"
        $links = $dmp.Links | Where-Object {$_.innerText -eq $format}
    } Catch {
         Write-output "Could not connect to DMP"
         Write-output "Response $($_.Exception.Response.StatusCode.Value__)"
         Return
    }

    $targetdir = Join-Path -Path $workdir -Childpath "DAI"
    If (!$(Test-Path $targetdir)) {
        New-Item $targetdir -type directory
    }

    Remove-Item "$targetdir\*" -recurse

    $links | Foreach-Object {
        $url = $_.href
        $filename = $url.split("/")[-1]
        $filepath = Join-Path -Path $targetdir -Childpath $filename
        Try {
            Invoke-WebRequest $url -OutFile $filepath
            Expand-Archive -Path $filepath -DestinationPath $targetdir
            Write-Output "$($filename) blev hentet"
        } catch {
            Write-Output "Could not download $($filename)"
            Write-Output "Response $($ERROR[0])"
        }

    }

    Remove-Item (Join-Path -Path $targetdir -Childpath "*.zip") -Force
    Get-ChildItem (Join-Path -Path $targetdir -Childpath "zipfolder") | ForEach-Object {
        Move-Item -Path $_.FullName -Destination (Join-Path -Path $targetdir -ChildPath $_.BaseName.Split(".")[0].ToUpper()) -Force
    }
    Remove-Item -Path (Join-Path -Path $targetdir -ChildPath "zipfolder") -Force
    Write-Output "$(Get-Date -Format HH:mm:ss) - Afslutter download fra DMP"
}

