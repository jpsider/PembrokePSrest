$script:ModuleName = 'PembrokePSutilities'

Describe "Get-StatusIdByName function for $moduleName" {
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
        Get-StatusIdByName -StatusName Running -RestServer dummyServer | Should -Be 1
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        {Get-StatusIdByName -StatusName Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
    }
    It "Should Throw if the StatusName is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        {Get-StatusIdByName -StatusName Running -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
    }
}