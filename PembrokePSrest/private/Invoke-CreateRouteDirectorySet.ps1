function Invoke-CreateRouteDirectorySet
{
    <#
	.DESCRIPTION
		Create Endpoint Route Directories to house Powershell scripts.
    .PARAMETER InstallDirectory
        A valid Directory is required.
	.EXAMPLE
        Invoke-CreateRouteDirectorySet -InstallDirectory C:\PembrokePS\Rest
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [Parameter(Mandatory = $true)][String]$InstallDirectory
    )
    try
    {
        if (Test-Path -Path $InstallDirectory)
        {
            Throw "Install Directory path: $InstallDirectory already exists."
        }
        else
        {
            New-Item -Path $InstallDirectory -ItemType Directory
            New-Item -Path "$InstallDirectory\DELETE" -ItemType Directory
            New-Item -Path "$InstallDirectory\GET" -ItemType Directory
            New-Item -Path "$InstallDirectory\POST" -ItemType Directory
            New-Item -Path "$InstallDirectory\PUT" -ItemType Directory
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