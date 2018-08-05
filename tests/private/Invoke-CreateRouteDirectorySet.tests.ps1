$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-CreateRouteDirectorySet function for $moduleName" {
    function Write-Output{}
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-CreateRouteDirectorySet -InstallDirectory "C:\PembrokePS\Rest"} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 1 -Exactly
    }
    It "Should Return true if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        Mock -CommandName 'New-Item' -MockWith {
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-CreateRouteDirectorySet -InstallDirectory "C:\PembrokePS\Rest"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'New-Item' -Times 5 -Exactly
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly

    }
}