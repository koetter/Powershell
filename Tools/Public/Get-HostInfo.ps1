
function Get-Hostinfo {
    Get-WmiObject -Class Win32_ComputerSystem |
        Format-List Domaine, Name, Username, Manufacturer, Model, SystemType,
            Description, NumberOfProcessors, NumberOfLogicalProcessors,
            @{Name="RAM"; Expression={[math]::round($($_.TotalPhysicalMemory/1GB), 0)}}
    
    Write-Host "Drive info:"
    Get-DriveInfo
    
    Write-Host "Operatingsystem:"
    Get-WmiObject -Class Win32_OperatingSystem

    Write-Host ""
    }

