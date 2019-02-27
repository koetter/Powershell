

function Set-FileEncoding([string]$Pattern, [string]$Path, [string]$Encoding='UTF8') {
    <#
    .SYNOPSIS
    Converts files to the given encoding.
    Matches the include pattern recursively under the given path.
    .EXAMPLE
    Convert-FileEncoding -Include *.js -Path scripts -Encoding UTF8
    #>

  $count = 0
  Get-ChildItem -Include $Pattern -Recurse -Path $Path `
  | select FullName, @{n='Encoding';e={Get-FileEncoding $_.FullName}} `
  | where {$_.Encoding -ne $Encoding} `
  | % { (Get-Content $_.FullName) `
        | Out-File $_.FullName -Encoding $Encoding; $count++; }
  
  Write-Host "$count $Pattern file(s) converted to $Encoding in $Path."
}
