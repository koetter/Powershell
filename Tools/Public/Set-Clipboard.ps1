
function Set-Clipboard([Parameter(ValueFromPipeline = $true)][object[]] $inputobj){
    Set-StrictMode -Version 3
    
    $objects = @()
    $objects += $inputobj

    $clipText = ($objects | Out-String -Stream) -join "`r`n"
    Add-Type -AssemblyName PresentationCore
    [Windows.Clipboard]::SetText($clipText)
    }


