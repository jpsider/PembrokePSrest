function Invoke-StartPPSEndpoint
{
    <#
	.DESCRIPTION
		Start a PembrokePS ReST endpoint.
    .PARAMETER InstallDirectory
        A valid Directory is required.
    .PARAMETER SourceAvailableRoutesFile
        A valid File is required.
	.EXAMPLE
        Invoke-StartPPSEndpoint -TBD
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [Parameter(Mandatory = $true)][String]$InstallDirectory,
        [Parameter(Mandatory = $true)][String]$SourceAvailableRoutesFile
    )
    try
    {
        if (!(Test-Path -Path $SourceAvailableRoutesFile))
        {
            Write-LogLevel -Message "lamp" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            Throw "Invoke-StartPPSEndpoint: Source Directory path: $SourceAvailableRoutesFile does not exist."
        }
        else
        {
            Write-LogLevel -Message "lamp" -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel INFO
            Copy-Item -Path "$SourceAvailableRoutesFile" -Destination $InstallDirectory -Force -Confirm:$false
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-StartPPSEndpoint: $ErrorMessage $FailedItem"
    }
}