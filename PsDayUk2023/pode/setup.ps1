class User
{
    [string]$FirstName
    [string]$Surname
    [string]$DisplayName
    [bool]$Enabled
    [int]$Id
    [string]$Username
}

$users = @(
    [user]@{id = 1;FirstName = "Kamil"; Username = 'kamilpro'}
    [user]@{id = 2;FirstName = "Robert"; Username = 'bob'}
)

$users | ConvertTo-Json | Out-File (Join-Path $PSScriptRoot "users.json")