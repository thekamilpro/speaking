Add-PodeWebPage -Name "zzExtraInfo" -DisplayName "Extra Info" -ScriptBlock {

    New-PodeWebCard -Name "Discover Pode" -Content @(

        New-PodeWebList -Items @(
            New-PodeWebListItem -Content @(New-PodeWebLink -Source "https://discord.gg/fRqeGcbF6h" -Value "Discord" -NewTab)
            New-PodeWebListItem -Content @(New-PodeWebLink -Source "https://github.com/Badgerati/Pode" -Value "GitHub" -NewTab)
            New-PodeWebListItem -Content @(New-PodeWebLink -Source "https://badgerati.github.io/Pode/" -Value "Documentation" -NewTab)
        )        
    )

    New-PodeWebCard -Name "Authentication" -Content @(
        New-PodeWebList -Values @("API Key","Azure AD","Basic","Bearer","Client Certificate","Digest","Form","JWT (Done using Bearer or API Key)","OAuth2", "Windows AD")

        New-PodeWebLink -Source "https://badgerati.github.io/Pode/Tutorials/Authentication/Overview/" -Value "Link to documentation" -NewTab
    )

    New-PodeWebCard -Name "Docker" -Content @(
        New-PodeWebCodeBlock -Language Docker -Value 'from mcr.microsoft.com/powershell:lts-7.2-ubuntu-22.04
        copy . /app
        expose 8080
        CMD [ "pwsh", "-c", "cd /app; ./02docker.ps1" ]'
    )

    New-PodeWebCard -Name "Mobile friendly" -Content @(
        New-PodeWebText -Value "Just resize your window!"
    )

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )

    
}