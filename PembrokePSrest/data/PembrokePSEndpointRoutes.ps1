function PembrokePSEndpointRoutes
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", '')]
    $script:Routes = @(
        @{
            'RequestType'    = 'GET'
            'RequestURL'     = '/status'
            'RequestCommand' = 'return 0'
        }
        @{
            'RequestType'    = 'GET'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "endpoints\GET\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'PUT'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "endpoints\PUT\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'POST'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "endpoints\POST\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'DELETE'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "endpoints\DELETE\Invoke-SelfTest.ps1"
        }            
    )
}