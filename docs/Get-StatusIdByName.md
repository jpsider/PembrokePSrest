---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Get-StatusIdByName

## SYNOPSIS

## SYNTAX

```
Get-StatusIdByName [-StatusName] <String> [-RestServer] <String> [<CommonParameters>]
```

## DESCRIPTION
This function will get the Status_ID from a Status_NAme

## EXAMPLES

### EXAMPLE 1
```
Get-StatusIdByName -StatusName Running -RestServer localhost
```

## PARAMETERS

### -StatusName
A StatusName is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestServer
A RestServer is required.

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

### System.Int32

## NOTES
This will return an integer.

## RELATED LINKS
