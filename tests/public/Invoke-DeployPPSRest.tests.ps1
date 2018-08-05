$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-DeployPPSRest function for $moduleName" {
    function Write-Output{}
    function Get-Module{}
    function Copy-Item{}
    function Invoke-CreateRouteDirectorySet{}
    It "Should not Throw if the sub tasks complete correctly.." {
        Mock -CommandName 'Invoke-CreateRouteDirectorySet' -MockWith {
            return $true
        }
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
        Mock -CommandName 'Invoke-MoveEndpointRouteSet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveAvailableRoutesFile' -MockWith {
            return $true
        }
        Mock -CommandName 'Copy-Item' -MockWith {
            return $true
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 1 -Exactly
    }
    It "Should Throw an exception if a subtask fails." {
        Mock -CommandName 'Invoke-CreateRouteDirectorySet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveEndpointRouteSet' -MockWith {
            Throw 'This should have thrown an error.'
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-DeployPPSRest -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data" -SourceAvailableRoutesFile "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1"} | Should -Throw
        Assert-MockCalled -CommandName 'Invoke-CreateRouteDirectorySet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Invoke-MoveEndpointRouteSet' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 1 -Exactly
    }
    It "Should Throw an exception if a subtask fails." {
        Mock -CommandName 'Invoke-CreateRouteDirectorySet' -MockWith {
            return $true
        }
        Mock -CommandName 'Invoke-MoveEndpointRouteSet' -MockWith {
            Throw 'This should have thrown an error.'
        }
        Mock -CommandName 'Write-Output' -MockWith {}
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
        Assert-MockCalled -CommandName 'Write-Output' -Times 5 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 1 -Exactly
    }
}