Add-PodeWebPage -Name "zzTestYourself" -DisplayName "Test Yourself" -Icon "test-tube" -ScriptBlock {

    New-PodeWebContainer -Content @(
        New-PodeWebHeader -Size 3 -Value "Source code of this application:"
        New-PodeWebHeader -Size 1 -Value "https://github.com/thekamilpro/speaking"
    )

    New-PodeWebContainer -Content @(
        New-PodeWebHeader -size 3 -Value "This application as docker:"
        New-PodeWebHeader -Size 1 -Value "https://psdayuk2023-kamilpro.azurewebsites.net"
    )
}