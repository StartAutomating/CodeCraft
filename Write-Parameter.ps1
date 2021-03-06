function Write-Parameter {
    <#
    .Synopsis
        Writes a parameter attribute.
    .Description
        Writes a PowerShell parameter attribute.
    .Example
        Write-Parameter 'MyParameter' -Mandatory
    #>
    param(
    #The name of the parameter
    [Parameter(ValueFromPipelineByPropertyName=$true,Position=0)]		
    [string]$Name,
    # If set, will add a ParameterSetName ot the parameter attribute
    [Parameter(ValueFromPipelineByPropertyName=$true)]		
	[String]$ParameterSet,
    # If set, will add a HelpMessage to the parameter attribute
	[Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$HelpMessage,
    # If Set, the parameter attribute will be marked as mandatory
	[Parameter(ValueFromPipelineByPropertyName=$true)]
    [Switch]$Mandatory,
    # If Set, the parameter attribute will be marked to accept pipeline input
	[Parameter(ValueFromPipelineByPropertyName=$true)]
    [Switch]$FromPipeline,
    # If set, the parameter attribute will be marked to accept input from
    # the pipeline by property name
	[Parameter(ValueFromPipelineByPropertyName=$true)]
    [Switch]$FromPipelineByPropertyName,
    # IF set, the parameter attribut will use this position
	[Parameter(ValueFromPipelineByPropertyName=$true)]
	[int]$Position,		
	# If set, will add aliases to the parameter
	[Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Aliases')]
	[String[]]$Alias
    ) 
	
	process {
	   
	    $parameterText = "[Parameter("
	    #region Parameter Inner Attributes
        if ($ParameterSet) {
	        $ParameterText += "ParameterSetName='$ParameterSet',"
	    }
	    if ($Mandatory) {
	        $ParameterText += 'Mandatory=$true,'
	    }
	    if ($FromPipeline) { 
	        $ParameterText += 'ValueFromPipeline=$true,'
	    }
	    if ($FromPipelineByPropertyName) { 
	        $ParameterText += 'ValueFromPipelineByPropertyName=$true,'
	    }    
	    if ($HelpMessage) {
	        $ParameterText += "HelpMessage='$HelpMessage',"
			$parameterText = "
<#
$HelpMessage
#>
$ParameterText"
	    }
		if ($psBoundParameters.Position) {
			$ParameterText += "Position='$Position',"
		}
        #endregion

		$ParameterText = $ParameterText.TrimEnd(",") + ")]"
		if ($Alias) {
			$OFS = "','"
			$parameterText+=@"
[Alias('$Alias')]
"@
		}
	
            if ($Name) {
                "$ParameterText
`$$name
                "
            } else {
                "$ParameterText
                "
            }
		
	}
}