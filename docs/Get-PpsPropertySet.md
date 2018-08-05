---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Get-PpsPropertySet

## SYNOPSIS

## SYNTAX

```
Get-PpsPropertySet [-RestServer] <String> [<CommonParameters>]
```

## DESCRIPTION
This function will gather Tasks based on a requested Status

## EXAMPLES

### EXAMPLE 1
```
Get-PpsPropertySet -RestServer localhost
```

## PARAMETERS

### -RestServer
A RestServer is Required.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Hashtable

## NOTES
This will return a hashtable of data from the PPS database.

## RELATED LINKS
