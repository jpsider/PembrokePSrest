$script:ModuleName = 'PembrokePSutilities'

Describe "Get-ComponentStatus function for $moduleName" {
    function Write-Output{}
    It "Should not be null" {
        $RawReturn = @{
            Queue_Manager = @{
                ID            = '1'
                STATUS_ID     = '1'
                WAIT       = '300'
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
        Get-ComponentStatus -ComponentType Queue_Manager -ComponentId 1 -RestServer dummyServer | Should not be $null
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Get-ComponentStatus -ComponentType Queue_Manager -ComponentId 1 -RestServer dummyServer} | Should -Throw
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
        {Get-ComponentStatus -ComponentType Queue_Manager -ComponentId 1 -RestServer dummyServer} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
    }
}