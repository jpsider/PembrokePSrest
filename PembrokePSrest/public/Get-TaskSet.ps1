function Get-TaskSet {
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
        Get-TaskSet -Status Queued -TableName Tasks
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [ValidateSet("Submitted","Queued","Assigned","Running","Cancelled","Staged")]
        [Parameter(Mandatory=$true)][String]$TaskStatus,
        [String]$TableName="tasks",
        [Parameter(Mandatory=$true)][String]$RestServer
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-Output "Gathering Task data from: $TableName with Status: $TaskStatus."
            $Status_ID = Get-StatusIdByName -StatusName $TaskStatus -RestServer $RestServer
            $TableName = $TableName.ToLower()
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/" + $TableName + "?include=status&filter=status_id,eq," + $Status_ID + '&transform=1'
            Write-Output "$URL" -Logfile "$LOG_FILE"
            $TaskData = (Invoke-RestMethod -Method Get -Uri "$URL" -UseBasicParsing).$TableName
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-TaskSet: $ErrorMessage $FailedItem"
        }
        $TaskData
    } else {
        Throw "Get-TaskSet: Unable to reach Rest server: $RestServer."
    }
    
}