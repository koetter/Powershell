
Function Test-EnvPath {
    $env:PATH.split(";") | ForEach-Object {
        If (-Not (Test-Path $_)) {
            Write-Host "FEJL! Findes ikke: $_" 
        }
    }

}

