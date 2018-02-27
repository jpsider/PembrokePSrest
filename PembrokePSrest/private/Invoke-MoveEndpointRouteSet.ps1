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
            Throw "Source Directory path: $SourceAvailableRoutesDirectory does not exist."
        }
        else
        {
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\DELETE")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\DELETE" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\GET")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\GET" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\POST")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\POST" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
            if (Test-Path -Path "$SourceAvailableRoutesDirectory\PUT")
            {
                Copy-Item -Path "$SourceAvailableRoutesDirectory\PUT" -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false
            }
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Write-Error "Error: $ErrorMessage $FailedItem"
        Throw $_
    }
}