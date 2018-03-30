function Invoke-MoveAvailableRoutesFile 
{
    <#
	.DESCRIPTION
		Copy Available Endpoint Routes file to specified directory.
    .PARAMETER InstallDirectory
        A valid Directory is required.
    .PARAMETER SourceAvailableRoutesFile
        A valid File is required.
	.EXAMPLE
        Invoke-MoveAvailableRoutesFile -InstallDirectory C:\PembrokePS\Rest -SourceAvailableRoutesFile C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1
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
            Write-LogLevel -Message "Source Directory path: $SourceAvailableRoutesFile does not exist." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            Throw "Invoke-MoveAvailableRoutesFile: Source Directory path: $SourceAvailableRoutesFile does not exist."
        }
        else
        {
            Write-LogLevel -Message "Copying Available Routes file to: $InstallDirectory." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel INFO
            Copy-Item -Path "$SourceAvailableRoutesFile" -Destination $InstallDirectory -Force -Confirm:$false
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-MoveAvailableRoutesFile: $ErrorMessage $FailedItem"
    }
}