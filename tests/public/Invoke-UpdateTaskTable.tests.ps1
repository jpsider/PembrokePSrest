$script:ModuleName = 'PembrokePSrest'

Describe "Invoke-UpdateTaskTable function for $moduleName" {
    function Write-LogLevel{}
    function Test-Connection{}
    $body = @{STATUS_ID = '2'}
    It "Should not be null" {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            1
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        Invoke-UpdateTaskTable -RestServer localhost -TableName tasks -TaskID 1 -Body $body | Should be 1
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 2 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-UpdateTaskTable -RestServer localhost -TableName tasks -TaskID 1 -Body $body} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 2 -Exactly
    }
    It "Should Throw if the ID is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-UpdateTaskTable -RestServer localhost -TableName tasks -TaskID 1 -Body $body} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 4 -Exactly
    }
}