Add-PodeWebPage -Name "Chart - Line" -Icon "chart-line" -ScriptBlock {

    New-PodeWebChart -Name 'Example Chart' -Type Line -ScriptBlock {
        return (1..10 | ForEach-Object {
            @{
                Key = $_ # x-axis value
                Values = @(
                    @{
                        Key = 'Group1'
                        Value = (Get-Random -Maximum 10) # y-axis value
                    }
                    @{
                        Key = 'Group2'
                        Value = (Get-Random -Maximum 10) # y-axis value
                    }
                )
            }
        })
    }

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}