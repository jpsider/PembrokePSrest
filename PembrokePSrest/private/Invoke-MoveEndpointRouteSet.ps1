function Invoke-MoveEndpointRouteSet
{
    <#
	.DESCRIPTION
		Create Endpoint Route Directories to house Powershell scripts.
    .PARAMETER InstallDirectory
        A valid Directory is required.
    .PARAMETER SourceAvailableRoutesDirectory
        A valid Directory is required.
	.EXAMPLE
        Invoke-MoveEndpointRouteSet -InstallDirectory C:\PembrokePS\Rest -SourceAvailableRoutesDirectory C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [Parameter(Mandatory = $true)][String]$InstallDirectory,
        [Parameter(Mandatory = $true)][String]$SourceAvailableRoutesDirectory
    )
    try
    {
        if (!(Test-Path -Path $SourceAvailableRoutesDirectory))
        {
            Write-LogLevel -Message "Source Directory path: $SourceAvailableRoutesDirectory does not exist." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel DEBUG
            Throw "Invoke-MoveEndpointRouteSet: Source Directory path: $SourceAvailableRoutesDirectory does not exist."
        }
        else
        {
            Write-LogLevel -Message "Creating Rest Directories." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel INFO
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\Data\DELETE")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\Data\DELETE" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\Data\GET")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\Data\GET" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\Data\POST")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\Data\POST" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\Data\PUT")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\Data\PUT" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-MoveEndpointRouteSet: $ErrorMessage $FailedItem"
    }
}