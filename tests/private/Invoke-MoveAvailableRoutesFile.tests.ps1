$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-MoveAvailableRoutesFile function for $moduleName" {
    function Write-Output{}
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-MoveAvailableRoutesFile -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
    }
    It "Should Return true if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Copy-Item' -MockWith {
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-MoveAvailableRoutesFile -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 1 -Exactly

    }
}