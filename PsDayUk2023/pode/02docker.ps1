Import-Module -Name (Join-Path $PSScriptRoot "lib.ps1") -ErrorAction Stop
Import-Module -Name (Join-Path $PSScriptRoot "pode/Pode/2.8.0/Pode.psd1") -ErrorAction Stop -Verbose
Import-Module -Name (Join-Path $PSScriptRoot "pode/Pode.Web/0.8.2/Pode.Web.psd1") -ErrorAction Stop -Verbose

Start-PodeServer {
    Add-PodeEndpoint -Address * -Port 8080 -Protocol Http

    New-PodeLoggingMethod -file -Name "errors" |  Enable-PodeErrorLogging
    New-PodeLoggingMethod -File -Name "requests" | Enable-PodeRequestLogging

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

    Add-PodeRoute -Method Get -Path '/users/:userId' -ScriptBlock {

       Write-PodeJsonResponse -Value (Get-User -Id $WebEvent.Parameters['userId'])
    }

    Add-PodeStaticRoute -Path '/static' -Source './static'
    Add-PodeStaticRoute -Path '/logstream' -Source './logs'

    # Frontend - Pode.Web
    Use-PodeWebTemplates -Title 'PsDayUk 2023' -Theme Light

    $navDiv = New-PodeWebNavDivider
    $navPode = New-PodeWebNavLink -Name 'Pode' -Url 'https://badgerati.github.io/Pode/' -Icon 'server' -NewTab
    $navPodeWeb = New-PodeWebNavLink -Name 'PodeWeb' -Url 'https://badgerati.github.io/Pode.Web/' -Icon 'web-check' -NewTab
    $navYT = New-PodeWebNavLink -Name 'YouTube' -Url 'https://www.youtube.com/c/KamilPro' -Icon 'youtube' -NewTab
    $navGH = New-PodeWebNavLink -name 'GitHub' -Url 'https://github.com/kprocyszyn/About-PowerShell' -Icon 'github' -NewTab
    $navPwpush = New-PodeWebNavLink -name 'PwPush' -Url 'https://pwpush.com/' -Icon 'lock-check' -NewTab
    Set-PodeWebNavDefault -Items $navPode, $navDiv, $navPodeWeb, $navDiv, $navYT, $navDiv, $navGH, $navDiv, $navPwpush

    Use-PodeWebPages

    $PID | Out-Default
}