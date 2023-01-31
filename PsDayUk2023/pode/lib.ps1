function Get-User
{
    param(
        [int]$Id,

        [string]$Username
    )
    $output = Get-Content -Path (Join-Path $PSScriptRoot "users.json") | ConvertFrom-Json

    if ($PSBoundParameters.Count -eq 0)
    {
        return $output
    }

    if ($PSBoundParameters.ContainsKey('Username'))
    {
        $output = $output | Where-Object {$_.Username -eq $Username}
    }

    return $output
}