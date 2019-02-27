
function Get-Clipboard {
    Set-StrictMode -Version 3
    Add-Type -AssemblyName PresentationCore
    [Windows.Clipboard]::GetText()
    }