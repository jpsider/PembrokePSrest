---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Invoke-StartPPSEndpoint

## SYNOPSIS

## SYNTAX

```
Invoke-StartPPSEndpoint [-Port] <Int32> [-SourceAvailableRoutesFile] <String> [<CommonParameters>]
```

## DESCRIPTION
Start a PembrokePS ReST endpoint.

## EXAMPLES

### EXAMPLE 1
```
Invoke-StartPPSEndpoint -Port 8999 -SourceAvailableRoutesFile $SourceAvailableRoutesFile
```

## PARAMETERS

### -Port
A valid Port is required.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceAvailableRoutesFile
A valid File is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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
