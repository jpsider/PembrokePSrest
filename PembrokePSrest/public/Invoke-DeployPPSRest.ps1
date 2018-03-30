function Invoke-DeployPPSRest
{
    <#
	.DESCRIPTION
		Deploy Database Schema to web server. This needs to be updated
    .PARAMETER InstallDirectory
        A valid Directory is optional.
    .PARAMETER SourceAvailableRoutesDirectory
        A valid Directory is optional.
    .PARAMETER SourceAvailableRoutesFile
        A valid File is optional.
	.EXAMPLE
        Invoke-DeployPPSRest -InstallDirectory C:\PembrokePS\Rest -SourceAvailableRoutesDirectory C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data -SourceAvailableRoutesFile C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [String]$InstallDirectory = 'C:\PembrokePS\Rest',
        [String]$SourceAvailableRoutesDirectory = 'C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data',
        [String]$SourceAvailableRoutesFile = 'C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1'
    )
    try
    {
        if (Invoke-CreateRouteDirectorySet -InstallDirectory $InstallDirectory)
        {
            Write-LogLevel -Message "Invoke-CreateRouteDirectorySet complete successfully." -Logfile $LOG_FILE -RunLogLevel $RunLogLevel -MsgLevel INFO
        }
        if (Invoke-MoveEndpointRouteSet -InstallDirectory $InstallDirectory -SourceAvailableRoutesDirectory $SourceAvailableRoutesDirectory)
        {
            Write-LogLevel -Message "Invoke-MoveEndpointRouteSet complete successfully." -Logfile $LOG_FILE -RunLogLevel $RunLogLevel -MsgLevel INFO
        }
        if (Invoke-MoveAvailableRoutesFile -InstallDirectory $InstallDirectory -SourceAvailableRoutesFile $SourceAvailableRoutesFile)
        {
            Write-LogLevel -Message "Invoke-MoveAvailableRoutesFile complete successfully." -Logfile $LOG_FILE -RunLogLevel $RunLogLevel -MsgLevel INFO
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-DeployPPSRest: $ErrorMessage $FailedItem"
    }

}