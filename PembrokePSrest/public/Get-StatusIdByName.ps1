function Get-StatusIdByName {
    <#
	.DESCRIPTION
		This function will get the Status_ID from a Status_NAme
    .PARAMETER StatusName
        A StatusName is required.
    .PARAMETER RestServer
        A RestServer is required.
	.EXAMPLE
        Get-StatusIdByName -StatusName Running -RestServer localhost
	.NOTES
        This will return an integer.
    #>
    [CmdletBinding()]
    [OutputType([Int])]
    param(
        [ValidateSet("Submitted","Queued","Assigned","Running","Cancelled","Staged")]
        [Parameter(Mandatory=$true)][String]$StatusName,
        [Parameter(Mandatory=$true)][string]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            $StatusName = $StatusName.ToLower()
            $StatusID = ((Invoke-RestMethod -Method Get -Uri "http://$RestServer/PembrokePS/public/api/api.php/status?filter=STATUS_NAME,eq,$StatusName&transform=1" -UseBasicParsing).status).ID
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Error: $ErrorMessage $FailedItem"
        }
        $StatusID
    } else {
        Throw "Unable to reach web server."
    }
    
}