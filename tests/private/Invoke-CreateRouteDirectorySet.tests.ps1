$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-CreateRouteDirectorySet function for $moduleName" {
    It "Should Throw an exception if the source directory does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {
            return $true
        }
        Mock -CommandName 'Write-Error' -MockWith {}
        {Invoke-CreateRouteDirectorySet -InstallDirectory "C:\PembrokePS\Rest"} | Should -Throw
        Assert-MockCalled -CommandName 'Write-Error' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
    }
    It "Should Return true if the Source exists and the copies succeed." {
        Mock -CommandName 'Test-Path' -MockWith {
        }
        Mock -CommandName 'New-Item' -MockWith {
        }
        {Invoke-CreateRouteDirectorySet -InstallDirectory "C:\PembrokePS\Rest"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'New-Item' -Times 5 -Exactly
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly

    }
}