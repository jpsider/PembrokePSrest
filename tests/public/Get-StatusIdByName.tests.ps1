$script:ModuleName = 'PembrokePSrest'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-StatusIdByName function for $moduleName" {
    function Write-Output{}
    function Test-Connection{}
    $RawReturn = @{
        status = @{
            ID            = '1'
            STATUS_ID     = '1'
            TASK_TYPE_ID  = '1'
        }               
    }
    $ReturnJson = $RawReturn | ConvertTo-Json
    $ReturnData = $ReturnJson | convertfrom-json
    It "Should not be null" {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            $ReturnData
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        Get-StatusIdByName -StatusName Running -RestServer dummyServer | Should -Be 1
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-StatusIdByName -StatusName Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the StatusName is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-StatusIdByName -StatusName Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
    }
}