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
            Throw "Source Directory path: $SourceAvailableRoutesFile does not exist."
        }
        else
        {
            Copy-Item -Path "$SourceAvailableRoutesFile" -Destination $InstallDirectory -Force -Confirm:$false
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