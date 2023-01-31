Import-Module -Name (Join-Path $PSScriptRoot "lib.ps1") -ErrorAction Stop

Start-PodeServer {
    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http

    New-PodeLoggingMethod -Terminal |  Enable-PodeErrorLogging

    Add-PodeRoute -Method Get -Path '/hello' -ScriptBlock {
        Write-PodeJsonResponse -Value @{ 'message' = 'Hello World!' }
    }

    Add-PodeRoute -Method Get -Path '/users' -ScriptBlock {

        $params = @{}

        if ($WebEvent.Query.ContainsKey('username'))
        {
            $params.Add("username", $WebEvent.Query['username'])
        }

       Write-PodeJsonResponse -Value (Get-User @params)
    }
}