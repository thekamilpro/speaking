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

    New-PodeWebCard -Name "Mobile friendly" -Content @(
        New-PodeWebText -Value "Just resize your window!"
    )

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}