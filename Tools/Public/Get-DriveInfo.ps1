
function Get-DriveInfo{
    Param($comp)
    # Get disk sizes
    $logicalDisk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
    foreach($disk in $logicalDisk){
        $diskObj = "" | Select-Object Disk,Size,FreeSpace
        $diskObj.Disk = $disk.DeviceID
        $diskObj.Size = "{0:n0} GB" -f (($disk | Measure-Object -Property Size -Sum).sum/1gb)
        $diskObj.FreeSpace = "{0:n0} GB" -f (($disk | Measure-Object -Property FreeSpace -Sum).sum/1gb)

        $text = "{0}  {1}  Free: {2}" -f $diskObj.Disk,$diskObj.size,$diskObj.Freespace
        $msg += $text + [char]13 + [char]10 
        }
    $msg
    }
