---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Get-TaskInfo

## SYNOPSIS

## SYNTAX

```
Get-TaskInfo [-TaskId] <String> [[-TableName] <String>] [-RestServer] <String> [<CommonParameters>]
```

## DESCRIPTION
This function will gather Tasks based on a requested Status

## EXAMPLES

### EXAMPLE 1
```
Get-TaskInfo -TaskId 1 -TableName Tasks -RestServer localhost
```

## PARAMETERS

### -TaskId
A Status is required.

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

### -TableName
A TableName is optional, default is tasks.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Tasks
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestServer
A RestServer is Required.

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
