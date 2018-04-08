$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-StartPPSEndpoint function for $moduleName" {
    function Write-LogLevel{}
    function Test-Path{}
    function Start-Process{}
    function Get-Module{}
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
            $false
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-StartPPSEndpoint -Port 1234 -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 0 -Exactly
    }
    It "Should not throw if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        Mock -CommandName 'Start-Process' -MockWith {}
        Mock -CommandName 'Get-Module' -MockWith {
            $RawReturn4 = @(
                @{
                    path            = 'c:\someModulePath'
                    Name            = 'c:\PembrokePSrest'
                }               
            )
            $ReturnJson4 = $RawReturn4 | ConvertTo-Json
            $ReturnData4 = $ReturnJson4 | convertfrom-json
            return $ReturnData4
        }
        {Invoke-StartPPSEndpoint -Port 1234 -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 1 -Exactly
    }
}