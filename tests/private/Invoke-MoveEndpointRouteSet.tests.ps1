$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-MoveEndpointRouteSet function for $moduleName" {
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        Mock -CommandName 'Write-Error' -MockWith {}
        {Invoke-MoveEndpointRouteSet -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data"} | Should -Throw
        Assert-MockCalled -CommandName 'Write-Error' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
    }
    It "Should Return true if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Copy-Item' -MockWith {
        }
        {Invoke-MoveEndpointRouteSet -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 6 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 4 -Exactly

    }
}