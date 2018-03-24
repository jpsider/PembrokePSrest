$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-DeployPPSRest function for $moduleName" {
    function Write-Log{}
    It "Should not Throw if the sub tasks complete correctly.." {
        Mock -CommandName 'Invoke-CreateRouteDirectorySet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveEndpointRouteSet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveAvailableRoutesFile' -MockWith {
            return $true
        }
        Mock -CommandName 'Write-Log' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveAvailableRoutesFile' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Log' -Times 3 -Exactly

    }
    It "Should Throw an exception if a subtask fails." {
        Mock -CommandName 'Invoke-CreateRouteDirectorySet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveEndpointRouteSet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveAvailableRoutesFile' -MockWith {
            Throw 'This should have thrown an error.'
        }
        Mock -CommandName 'Write-Log' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Write-Log' -Times 5 -Exactly
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveAvailableRoutesFile' -Times 2 -Exactly
    }
}