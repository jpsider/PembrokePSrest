function Get-PembrokePSproperties {
    <#
	.DESCRIPTION
		This function will gather Tasks based on a requested Status
    .PARAMETER RestServer
        A RestServer is Required.
	.EXAMPLE
        Get-PembrokePSproperties -RestServer localhost
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
            Write-LogLevel -Message "Gathering Property data from: $RestServer." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/properties?transform=1"
            Write-LogLevel -Message "$URL" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel TRACE
            $PropertyData = Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-PembrokePSproperties: $ErrorMessage $FailedItem"
        }
        $PropertyData
    } else {
        Throw "Get-PembrokePSproperties: Unable to reach Rest server: $RestServer."
    }
    
}