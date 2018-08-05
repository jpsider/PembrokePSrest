---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Get-ComponentStatus

## SYNOPSIS

## SYNTAX

```
Get-ComponentStatus [[-ComponentType] <String>] [-ComponentId] <Int32> [-RestServer] <String>
 [<CommonParameters>]
```

## DESCRIPTION
This function will gather Status information from PembrokePS web/rest.

## EXAMPLES

### EXAMPLE 1
```
Get-ComponentStatus -ComponentType Queue_Manager -ComponentId 1 -RestServer localhost
```

## PARAMETERS

### -ComponentType
A Component type is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComponentId
An ID is required.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestServer
A Rest Server is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
