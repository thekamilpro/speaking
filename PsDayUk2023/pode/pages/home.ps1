Set-PodeWebHomePage -Layouts @(
    New-PodeWebHero -Title 'Welcome to PowerShell Days Uk 2023!' -Message 'Everything you see here is driven by PowerShell...' -Content @(
    )

    New-PodeWebContainer -Content @(
        New-PodeWebImage -Source "/static/logo.jpg" -Alignment Center
    )

)