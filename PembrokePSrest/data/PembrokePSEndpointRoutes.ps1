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
            'RequestCommand' = "c:\PembrokePS\rest\GET\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'PUT'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "c:\PembrokePS\rest\PUT\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'POST'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "c:\PembrokePS\rest\POST\Invoke-SelfTest.ps1"
        }
        @{
            'RequestType'    = 'DELETE'
            'RequestURL'     = '/selftest'
            'RequestCommand' = "c:\PembrokePS\rest\DELETE\Invoke-SelfTest.ps1"
        }
    )
}
PembrokePSEndpointRoutes