function Get-Computers {
    return @{
        machine1 = @(
            [pscustomobject]@{id = 1; software = "Firefox 23"; reviewed = $true; action = "upgrade" },
            [pscustomobject]@{id = 2; software = "Java 3"; reviewed = $false; action = "uninstall" },
            [pscustomobject]@{id = 3; software = "Internet Explorer 7"; reviewed = $false; action = "uninstall" }
        )

        machine2 = @(
            [pscustomobject]@{id = 1; software = "Winzip 3"; reviewed = $false; action = "uninstall" },
            [pscustomobject]@{id = 2; software = "Java 5"; reviewed = $false; action = "uninstall" }
        )
    }
}

Add-PodeWebPage -Name "Survey Advanced" -ScriptBlock {

    $computers = Get-Computers

    foreach ($c in $computers.Keys) {
        New-PodeWebCard -Name $c -Content @(
            New-PodeWebTable -Name "Software $c" -ArgumentList ($c, $computers[$c]) -DataColumn "Payload" -ScriptBlock {
                param (
                    $ComputerName,
                    $Software
                )

                foreach ($s in $Software) {
                    if ($s.reviewed) { $colour = "green"; $text = "Yes" } else { $colour = "red"; $text = "No" }

                    [ordered]@{
                        ID       = $s.id
                        Software = $s.software
                        Reviewed = New-PodeWebBadge -Colour $colour -Value $text
                        Action   = $s.action
                        Edit     = New-PodeWebButton -Name "Edit" -ScriptBlock { Move-PodeWebPage -Name "Survey-Advanced-Edit" -DataValue $Webevent.Data['Value'] }
                        Payload  = "$($ComputerName)|$($s.Id)"
                    }
                }
            }
        )
    }

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}

Add-PodeWebPage -Hide -NoSidebar -Name "Survey-Advanced-Edit" -DisplayName "Survey Advanced Edit"  -ScriptBlock {

    if (!$WebEvent.Query['Value']) {
        New-PodeWebHeader -Value "You need to pass in information" -Size 3
        return
    }

    $data = $WebEvent.Query['Value'].split('|')
    $computerName = $data[0].trim()
    $softwareId = $data[1].trim()

    $computers = Get-Computers
    $computer = $computers[$computerName]
    $software = $computer | Where-Object { $_.Id -eq $softwareId }

    if ($null -eq $software) {
        New-PodeWebHeader -Value "Failed to find info $data; $computerName; $softwareId" -Size 3
        return
    }

    New-PodeWebContainer -Content @(
        New-PodeWebForm -Name "Edit" -Content @(
        
            New-PodeWebTextbox -Name id -Value $software.id -ReadOnly
            New-PodeWebTextbox -name software -value $software.software -ReadOnly 
            New-PodeWebTextbox -name reviewed -value $true -ReadOnly
            New-PodeWebRadio -Name "Action" -Options @("Upgrade", "Uninstall")
            New-PodeWebTextbox -Name "comment" -Multiline   
        ) -ScriptBlock {
            Show-PodeWebToast -Title "Success" -Message "Answer saved"
        }
    )

    New-PodeWebCard -Name "Source" -Content @(
        New-PodeWebCodeBlock -Language PowerShell -Value (Get-Content $PSCommandPath -Raw)
    )
}
