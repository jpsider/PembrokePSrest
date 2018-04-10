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
            Write-Output "Getting StatusID by Status Name: $StatusName."
            $StatusName = $StatusName.ToLower()
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/status?filter=STATUS_NAME,eq,$StatusName&transform=1"
            Write-Output "$URL" -Logfile "$LOG_FILE"
            $StatusID = ((Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing).status).ID
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-StatusIdByName: $ErrorMessage $FailedItem"
        }
        $StatusID
    } else {
        Throw "Get-StatusIdByName: Unable to reach Rest server: $RestServer."
    }
    
}