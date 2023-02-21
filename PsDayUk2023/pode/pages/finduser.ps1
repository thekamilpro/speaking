Add-PodeWebPage -Name 'FindUser' -DisplayName "Find User" -Icon "account-search" -ScriptBlock {

    New-PodeWebForm -Name "Find user" -Content @(
        New-PodeWebTextbox -Name "usr" -DisplayName "Username"
    ) -ScriptBlock {
        $user = Get-User -Username $WebEvent.Data['usr']

        if ($WebEvent.Data['usr'].Length -eq 0) 
        {
            Out-PodeWebValidation -Name 'usr' -Message 'Cannot be empty'
            return
        }

        if ($user)
        {
            Move-PodeWebPage -Name 'FindUser' -DataValue $user.Username
        }
        else
        {
            Show-PodeWebToast -Message "User not found" -Title "Error" -Duration 5000
        }
    }

    if ($WebEvent.Query['Value'])
    {
        $user = Get-User -Username $WebEvent.Query['value']

        New-PodeWebTextbox -Name "Username" -Value $user.Username -ReadOnly
        New-PodeWebTextbox -Name "First Name" -Value $user.FirstName -ReadOnly
        New-PodeWebTextbox -Name "Surname" -Value $user.Surname -ReadOnly
        New-PodeWebTextbox -Name "Display Name" -Value $user.DisplayName -ReadOnly
        New-PodeWebTextbox -Name "Id" -Value $user.Id -ReadOnly
    }

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}