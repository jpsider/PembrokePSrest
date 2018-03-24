function Invoke-UpdateTaskTable {
    <#
	.DESCRIPTION
		This function will update a column and field for a Queue_Manager
    .PARAMETER RestServer
        A Rest Server is required.
    .PARAMETER TableName
        An TableName is required.
    .PARAMETER TaskID
        An TaskID is required.
    .PARAMETER Body
        A Column/Field is required.
	.EXAMPLE
        Invoke-UpdateTaskTable -RestServer localhost -TableName tasks -TaskID 1 -Body "@{STATUS_ID = '2'}"
	.NOTES
        This will return a hashtable of data from the PPS database.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)][string]$TableName,
        [Parameter(Mandatory=$true)][string]$RestServer,
        [Parameter(Mandatory=$true)][hashtable]$Body,
        [Parameter(Mandatory=$true)][int]$TaskID
    )
    if (Test-Connection -Count 1 $RestServer -Quiet) {
        try
        {
            $TableName = $TableName.ToLower()
            $RawRestReturn = Invoke-RestMethod -Method Put -Uri "http://$RestServer/PembrokePS/public/api/api.php/$TableName/$TaskID" -body $body
            $RestReturn = ConvertFrom-Json $RawRestReturn
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Error: $ErrorMessage $FailedItem"
        }
        $RestReturn
    } else {
        Throw "Unable to reach web server."
    }
    
}