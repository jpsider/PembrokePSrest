$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-StartPPSEndpoint function for $moduleName" {
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        {Invoke-StartPPSEndpoint -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
    }
    It "Should not throw if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Copy-Item' -MockWith {
        }
        {Invoke-StartPPSEndpoint -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 1 -Exactly

    }
}