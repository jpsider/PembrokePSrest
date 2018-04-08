function Invoke-StartPPSEndpoint
{
    <#
	.DESCRIPTION
		Start a PembrokePS ReST endpoint.
    .PARAMETER Port
        A valid Port is required.
    .PARAMETER SourceAvailableRoutesFile
        A valid File is required.
	.EXAMPLE
        Invoke-StartPPSEndpoint -Port 8999 -SourceAvailableRoutesFile $SourceAvailableRoutesFile
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [Parameter(Mandatory = $true)][Int]$Port,
        [Parameter(Mandatory = $true)][String]$SourceAvailableRoutesFile
    )
    try
    {
        if (!(Test-Path -Path $SourceAvailableRoutesFile))
        {
            Throw "Invoke-StartPPSEndpoint: Source Directory path: $SourceAvailableRoutesFile does not exist."
        }
        else
        {
            $ExecutionPath = ((Split-Path -Path (Get-Module -ListAvailable PembrokePSrest).path) + "\bin\Invoke-NewEndpoint.ps1")
            Write-LogLevel -Message "Starting Endpoint." -Logfile "$LOG_FILE" -RunLogLevel $RunLogLevel -MsgLevel INFO
            Start-Process -WindowStyle Normal powershell.exe -ArgumentList "-file $ExecutionPath", "-SourceAvailableRoutesFile $SourceAvailableRoutesFile -Port $Port"
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-StartPPSEndpoint: $ErrorMessage $FailedItem"
    }
}