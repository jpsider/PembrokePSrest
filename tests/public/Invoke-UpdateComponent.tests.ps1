$script:ModuleName = 'PembrokePSutilities'

Describe "Invoke-UpdateComponent function for $moduleName" {
    It "Should not be 1" {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            1
        }
        Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager | Should be 1
        Assert-MockCalled -CommandName 'Test-Connection' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly
    }
    It "Should Throw if the Rest Server cannot be reached.." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $false
        }
        {Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 2 -Exactly
    }
    It "Should Throw if the ID is not valid." {
        Mock -CommandName 'Test-Connection' -MockWith {
            $true
        }
        Mock -CommandName 'Invoke-RestMethod' -MockWith { 
            Throw "(404) Not Found"
        }
        {Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Connection' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 2 -Exactly
    }
}