$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-DeployPPSRest function for $moduleName" {
    function Write-LogLevel{}
    function Get-Module{}
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
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveAvailableRoutesFile' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 3 -Exactly
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
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveAvailableRoutesFile' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 5 -Exactly
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
        Mock -CommandName 'Write-LogLevel' -MockWith {}
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
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" } | Should -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveAvailableRoutesFile' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 7 -Exactly
    }
}