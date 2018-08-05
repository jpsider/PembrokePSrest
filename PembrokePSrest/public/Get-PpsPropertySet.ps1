function Get-PpsPropertySet {
    <#
	.DESCRIPTION
		This function will gather Tasks based on a requested Status
    .PARAMETER RestServer
        A RestServer is Required.
	.EXAMPLE
        Get-PpsPropertySet -RestServer localhost
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)][String]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-Output "Gathering Property data from: $RestServer."
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/properties?transform=1"
            Write-Output "$URL"
            $PropertyData = Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "Get-PpsPropertySet: $ErrorMessage $FailedItem"
        }
        $PropertyData
    } else {
        Throw "Get-PpsPropertySet: Unable to reach Rest server: $RestServer."
    }
}