$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-PpsPropertySet function for $moduleName" {
    function Write-Output{}
    function Test-Connection{}
    It "Should not be null if information is returned correctly." {
        $RawReturn = @{
            properties = @{
                ID            = '1'
                Prop_Name     = 'FakeProperty'
                Prop_Value  = 'FakeValue'
            }               
        }
        $ReturnJson = $RawReturn | ConvertTo-Json
        $ReturnData = $ReturnJson | convertfrom-json
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            $ReturnData
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        Get-PpsPropertySet -RestServer dummyServer | Should -BeOfType System.Management.Automation.PSCustomObject
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server is not reachable." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-PpsPropertySet -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Restcall fails." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-PpsPropertySet -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
    }
}