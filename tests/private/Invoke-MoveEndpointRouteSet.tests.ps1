$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-MoveEndpointRouteSet function for $moduleName" {
    function Write-Output{}
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-MoveEndpointRouteSet -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data"} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 1 -Exactly
    }
    It "Should Return true if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Copy-Item' -MockWith {
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-MoveEndpointRouteSet -InstallDirectory "C:\PembrokePS\Rest" -SourceAvailableRoutesDirectory "C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 6 -Exactly
        Assert-MockCalled -CommandName 'Copy-Item' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly

    }
}