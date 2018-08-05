---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Invoke-DeployPPSRest

## SYNOPSIS

## SYNTAX

```
Invoke-DeployPPSRest [[-InstallDirectory] <String>] [[-SourceAvailableRoutesDirectory] <String>]
 [[-SourceAvailableRoutesFile] <String>] [<CommonParameters>]
```

## DESCRIPTION
Deploy Database Schema to web server.
This needs to be updated

## EXAMPLES

### EXAMPLE 1
```
Invoke-DeployPPSRest -InstallDirectory C:\PembrokePS\Rest -SourceAvailableRoutesDirectory C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data -SourceAvailableRoutesFile C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1
```

## PARAMETERS

### -InstallDirectory
A valid Directory is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: C:\PembrokePS\Rest
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceAvailableRoutesDirectory
A valid Directory is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ((Split-Path -Path (Get-Module -ListAvailable PembrokePSrest).path) + "\Data")
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceAvailableRoutesFile
A valid File is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: \PembrokePS\EndpointRoutes.ps1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES
It will create the directory if it does not exist.

## RELATED LINKS
