---
external help file: PembrokePSrest-help.xml
Module Name: PembrokePSrest
online version:
schema: 2.0.0
---

# Invoke-UpdateTaskTable

## SYNOPSIS

## SYNTAX

```
Invoke-UpdateTaskTable [-TableName] <String> [-RestServer] <String> [-Body] <Hashtable> [-TaskID] <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
This function will update a column and field for a Queue_Manager

## EXAMPLES

### EXAMPLE 1
```
Invoke-UpdateTaskTable -RestServer localhost -TableName tasks -TaskID 1 -Body "@{STATUS_ID = '2'}"
```

## PARAMETERS

### -TableName
An TableName is required.

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
A Rest Server is required.

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

### -Body
A Column/Field is required.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TaskID
An TaskID is required.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
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
