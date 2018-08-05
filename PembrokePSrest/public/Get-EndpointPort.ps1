function Get-EndpointPort {
    <#
	.DESCRIPTION
		This function will gather Status information from PembrokePS web/rest.
    .PARAMETER EndpointPortID
        An ID is required.
    .PARAMETER RestServer
        A Rest Server is required.
	.EXAMPLE
        Get-EndpointPort -RestServer localhost -EndpointPortID 1
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)][int]$EndpointPortID,
        [Parameter(Mandatory=$true)][string]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-Output "Getting Component Endpoint Port data for Id: $EndpointPortID."
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/endpoint_ports?filter=ID,eq,$EndpointPortID&transform=1"
            Write-Output "$URL"
            $EndpointPortData = Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "Get-EndpointPort: $ErrorMessage $FailedItem"
        }
        $EndpointPortData
    } else {
        Throw "Get-EndpointPort: Unable to reach Rest server: $RestServer."
    }
}