$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-TaskSet function for $moduleName" {
    function Write-Output{}
    function Get-StatusIdByName {}
    function Test-Connection{}
    It "Should not be null" {
        $RawReturn = @{
            tasks = @{
                ID            = '1'
                STATUS_ID     = '1'
                TASK_TYPE_ID  = '1'
            }               
        }
        $ReturnJson = $RawReturn | ConvertTo-Json
        $ReturnData = $ReturnJson | convertfrom-json
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Get-StatusIdByName' -MockWith {
            return 1
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            $ReturnData
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        Get-TaskSet -TaskStatus Running -RestServer dummyServer | Should -BeOfType System.Management.Automation.PSCustomObject
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Get-StatusIdByName' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Status_ID check fails." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Get-StatusIdByName' -MockWith {
            Throw "Could not get Satus_ID"
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-TaskSet -TableName tasks -TaskStatus Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-TaskSet -TableName tasks -TaskStatus Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the TaskStatus is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-TaskSet -TableName tasks -TaskStatus Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 3 -Exactly
    }
}