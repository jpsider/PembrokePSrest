function Get-ComponentStatus {
    <#
	.DESCRIPTION
		This function will gather Status information from PembrokePS web/rest.
    .PARAMETER ComponentType
        A Component type is required.
    .PARAMETER ComponentId
        An ID is required.
    .PARAMETER RestServer
        A Rest Server is required.
	.EXAMPLE
        Get-ComponentStatus -ComponentType Queue_Manager -ComponentId 1 -RestServer localhost
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [ValidateSet("Queue_Manager","Workflow_Manager")]
        [string]$ComponentType,
        [int]$ComponentId,
        [string]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-LogLevel -Message "Getting Component: $ComponentId, Type: $ComponentType Status." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            $ComponentType = $ComponentType.ToLower()
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/$ComponentType/$ComponentId"
            Write-LogLevel -Message "$URL" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel TRACE
            $ComponentStatusData = Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-ComponentStatus: $ErrorMessage $FailedItem"
        }
        $ComponentStatusData
    } else {
        Throw "Get-ComponentStatus: Unable to reach Rest server: $RestServer."
    }
    
}