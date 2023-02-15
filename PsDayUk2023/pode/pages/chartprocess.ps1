Add-PodeWebPage -Name "Chart - Processes" -ScriptBlock {

    New-PodeWebContainer -Content @(
        New-PodeWebChart -Name 'Top Processes' -Type Bar -AutoRefresh -ScriptBlock {
            Get-Process |
            Sort-Object -Property CPU -Descending |
            Select-Object -First 10 |
            Select-Object ProcessName, CPU, @{Name = 'MemoryGB'; Expression = { ($_.WorkingSet64 / 1GB) } } |
            ConvertTo-PodeWebChartData -LabelProperty ProcessName -DatasetProperty CPU, MemoryGB
        }
    )

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}