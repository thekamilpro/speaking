Add-PodeWebPage -Name "Survey Advanced" -ScriptBlock {

    $computers = @{
        machine1 = @(
            [pscustomobject]@{id = 1; software = "Firefox 23"; reviewed = $true; action = "upgrade"},
            [pscustomobject]@{id = 2; software = "Java 3"; reviewed = $false; action = "uninstall"},
            [pscustomobject]@{id = 3; software ="Internet Explorer 7"; reviewed = $false; action = "uninstall"}
        )

        machine2 = @(
            [pscustomobject]@{id = 1; software = "Winzip 3"; reviewed = $false; action = "uninstall"},
            [pscustomobject]@{id = 2; software = "Java 5"; reviewed = $false; action = "uninstall"}
        )
    }

    foreach ($c in $computers.Keys)
    {
       New-PodeWebCard -Name $c -Content @(
            New-PodeWebTable -Name "Software $c" -ArgumentList (,$computers[$c]) -ScriptBlock {
                param (
                    $software
                )

                foreach ($s in $software)
                {
                    if ($s.reviewed) {$colour = "green"; $text = "Yes"} else {$colour = "red"; $text = "No"}

                    [ordered]@{
                        ID = $s.id
                        Software = $s.software
                        Reviewed = New-PodeWebBadge -Colour $colour -Value $text
                        Action = $s.action
                        Edit = New-PodeWebButton -Name "Edit" -ScriptBlock {}
                    }
                }
            }
       )
    }

}