
Function Get-Logout{
    param(
    [parameter(position=0, Mandatory=$false)][String] $strDate
    )
    If ($strDate) {
        $dt = Get-Date $strDate
    } else {
        $dt = Get-Date (Get-date).AddDays(-1).ToShortDateString()
    }
    Get-EventLog -LogName System -after $dt -before $dt.AddDays(1) |
        Where-Object {$_.eventid -eq "6006"}| 
        Select-Object -first 1 -expand TimeGenerated
}