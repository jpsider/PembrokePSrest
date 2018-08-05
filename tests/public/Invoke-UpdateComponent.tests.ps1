$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-UpdateComponent function for $moduleName" {
    function Write-Output{}
    function Test-Connection{}
    It "Should not be 1" {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            1
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager | Should be 1
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the ID is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
    }
}