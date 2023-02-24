Add-PodeWebPage -Name 'Survey' -DisplayName "Survey" -Icon "form-select" -ScriptBlock {

    New-PodeWebHeader -Size 3 -Value "Hello Bob!"

    New-PodeWebForm -Name "Find user" -Content @(
        New-PodeWebHidden -Name "upn" -Value "bob@company.pri"
        New-PodeWebRadio -Name "attend" -DisplayOptions @("Yes and enjoyed", "No but still enjoyed") -Options @("yes", "no")
        New-PodeWebCheckbox -DisplayName "Ok to Contact?" -Name "contact" -Options @("yes") -AsSwitch
        New-PodeWebTextbox -Name "comments" -Placeholder "Please add any other comments" -MaxLength 20
    ) -ScriptBlock {
        $WebEvent.Data | Out-Default

        Update-PodeWebTextbox -Value $WebEvent.Data.upn -Name "Email"
        Update-PodeWebTextbox -Value $WebEvent.Data.attend -Name "Attended"

        Clear-PodeWebTextbox -Name contact
        if (![String]::IsNullOrEmpty($WebEvent.Data.contact))
        {
            Update-PodeWebTextbox -Value $WebEvent.Data.contact -Name "Contact"
        }
        Clear-PodeWebTextbox -Name Comments
        if (![String]::IsNullOrEmpty($WebEvent.Data.Comments))
        {
            Update-PodeWebTextbox -Value $WebEvent.Data.comments -Name "Comments"
        }

        Update-PodeWebTextbox -Name OutputObject -Value ($WebEvent.Data | Out-String) -Multiline
    }
    
    New-PodeWebTextbox -Name Email -ReadOnly
    New-PodeWebTextbox -Name Attended -ReadOnly
    New-PodeWebTextbox -Name Contact -ReadOnly
    New-PodeWebTextbox -Name Comments -ReadOnly    

    New-PodeWebTextbox -Name OutputObject -Multiline

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}