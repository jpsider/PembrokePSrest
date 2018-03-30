function Invoke-UpdateComponent {
    <#
	.DESCRIPTION
		This function will update a column and field for a Queue_Manager
    .PARAMETER ComponentId
        An ID is required.
    .PARAMETER RestServer
        A Rest Server is required.
    .PARAMETER Column
        A Column/Field is required.
    .PARAMETER ComponentType
        A ComponentType is required.
    .PARAMETER Value
        A Value is required.
	.EXAMPLE
        Invoke-UpdateComponent -ComponentId 1 -RestServer localhost -Column STATUS_ID -Value 2 -ComponentType queue_manager
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)][int]$ComponentId,
        [Parameter(Mandatory=$true)][string]$RestServer,
        [Parameter(Mandatory=$true)][string]$Column,
        [Parameter(Mandatory=$true)][string]$Value,
        [Parameter(Mandatory=$true)][string]$ComponentType
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            Write-LogLevel -Message "Updating Component $ComponentId, Type: $ComponentType, Column: $Column, Value: $value." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            $ComponentType = $ComponentType.ToLower()
            $body = @{$Column = "$Value"} | convertto-json
            $URL = "http://$RestServer/PembrokePS/public/api/api.php/$ComponentType/$ComponentId"
            Write-LogLevel -Message "$URL" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel TRACE
            $RawRestReturn = Invoke-RestMethod -Method Put -Uri "$URL" -body $body
            $RestReturn = ConvertFrom-Json $RawRestReturn
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Invoke-UpdateComponent: $ErrorMessage $FailedItem"
        }
        $RestReturn
    } else {
        Throw "Invoke-UpdateComponent: Unable to reach Rest server: $RestServer."
    }
    
}