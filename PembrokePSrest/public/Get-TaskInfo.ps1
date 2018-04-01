function Get-TaskInfo {
    <#
	.DESCRIPTION
		This function will gather Tasks based on a requested Status
    .PARAMETER TaskStatus
        A Status is required.
    .PARAMETER TableName
        A TableName is optional, default is tasks.
    .PARAMETER RestServer
        A RestServer is Required.
	.EXAMPLE
        Get-TaskInfo -TaskId 1 -TableName Tasks -RestServer localhost
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)][String]$TaskId,
        [String]$TableName="tasks",
        [Parameter(Mandatory=$true)][String]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-LogLevel -Message "Gathering Task data from: $TableName TaskId: $TaskId." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/" + $TableName + "?include=task_types,targets&filter=id,eq," + $TaskId + '&transform=1'
            Write-LogLevel -Message "$URL" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel TRACE
            $TaskData = (Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing).$TableName
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-TaskInfo: $ErrorMessage $FailedItem"
        }
        $TaskData
    } else {
        Throw "Get-TaskInfo: Unable to reach Rest server: $RestServer."
    }
    
}