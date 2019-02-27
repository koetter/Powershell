# Implement your module commands in this script.

# From https://github.com/RamblingCookieMonster/PSStackExchange
# Get public and private function definition files.
$public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the files
Foreach($import in @($public + $private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}


# Exporting public module members only
Export-ModuleMember -Function $public.Basename
Write-Host "$($MyInvocation.MyCommand.Name) was imported"
