function Write-CommandOverload
{
    <#
    .Synopsis
        Writes a command overload.          
    .Description
        This creates a command that runs another command.  It can optionally drop some parameters, or create new ones. 
    .Example
    
    #>
    param(
    [Parameter(Mandatory=$true,ParameterSetName='CommandMetaData')]
    [Management.Automation.CommandMetaData]
    $Command,
    
    #|Options Get-Command | ForEach-Object { ($_.ModuleName + $_.PSSnapinName + "\" + $_.Name).TrimStart("\") } 
    [Parameter(Mandatory=$true,
        Position=0,
        ValueFromPipelineByPropertyName=$true,
        ParameterSetName='CommandName')]
    [string]
    $CommandName,
    
    # The module the loaded command is in
    [Parameter(Position=1,
        ValueFromPipelineByPropertyName=$true,
        ParameterSetName='CommandName')]
    [Alias('ModuleName', 'PSSnapinName')]
    [string]
    $Module,
    
    # Any additional parameters to add to the command.
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Management.Automation.ParameterMetaData[]]
    $AdditionalParameter,
    
    # Any parameters to remove from the command.
    [Parameter(ValueFromPipelineByPropertyName=$true)]    
    [string[]]
    $RemoveParameter,

    # The new type name
    [string]
    $NewTypeName,
    
    # The script to be run when each item is processed
    [ScriptBlock]
    $ProcessEachItem,
    
    # The name of the item
    [string]
    $Name,
    
    # The default value
    [Hashtable]
    $DefaultValue   
    )
    
    process {
        if ($psCmdlet.ParameterSetName -eq 'CommandName') {
            $nestedParams = @{} + $psBoundParameters
            $psBoundParameters.Name = $psBoundParameters.CommandName
            $null = $nestedParams.Remove('Module'),
                $nestedParams.Remove('CommandName'),
                $psBoundParameters.Remove('CommandName'),
                $psBoundParameters.Remove('DefaultValue'),
                $psBoundParameters.Remove('ProcessEachItem')
            $resolvedCommand = Get-Command @psboundParameters
            
            if (-not $resolvedCommand) { 
                return
            }
            & $myInvocation.MyCommand -Command $resolvedCommand @nestedParams 
        } elseif ($psCmdlet.ParameterSetName -eq 'CommandMetaData') {     
            $MetaData = New-Object Management.Automation.CommandMetaData $Command
            foreach ($rp in $removeParameter) {
                if (-not $rp) { continue }
                $null = $MetaData.Parameters.Remove($rp)
            }
            foreach ($ap in $additionalParameter) {
                if (-not $ap) { continue }
                $null = $MetaData.Parameters.Add($ap.Name, $ap)
            }
            
            
            $beginBlock  = if ($NewTypeName -or $ProcessEachItem){
                [Management.Automation.ProxyCommand]::GetBegin($metaData) -replace '\.Begin\(\$PSCmdlet\)', '.Begin($false)'                
            } else {
                [Management.Automation.ProxyCommand]::GetBegin($metaData)
            }
            
            if (-not $Name) {
                $Name = $command.Name
            }
            
            
            if ($DefaultValue) {
                $defaultValueText = Write-Hashtable $DefaultValue
                $beginBlock  = $beginBlock -replace '\$outBuffer = \$null', ('$outBuffer = $null
                
                
' + $defaultValueText)
            }
            
            # Indent the block of code.  Yes, this is neurotic.
            $beginBlock = $beginBlock -split ([Environment]::NewLine) -ne "" |
                ForEach-Object { " " * 4 + $_  + [Environment]::NewLine}                             
            
            $endBlock = [Management.Automation.ProxyCommand]::GetEnd($metaData) -split ([Environment]::NewLine) -ne "" |
                ForEach-Object { " " * 4 + $_  + [Environment]::NewLine} 
                
                
            $paramBlock = "$([Management.Automation.ProxyCommand]::GetParamBlock($metaData))" -replace '(\$)\{(\w.+)\}', '$1$2'
            
            
            
            $ProcessBlock  = if ($ProcessEachItem){                
                "
    try {
        `$steppablePipeline.Process(`$_) | 
            ForEach-Object {
$ProcessEachItem
            }
    } catch {
        throw
    }
                "
            } elseif ($NewTypeName) {
                "
    try {
        `$steppablePipeline.Process(`$_) | 
            ForEach-Object {
                `$_.pstypenames.clear()
                `$_.pstypenames.add('$NewTypeName')
                `$_
            }
    } catch {
        throw
    }
                "
            } else {
                [Management.Automation.ProxyCommand]::GetProcess($metaData)
            }
            
            
            $ProcessBlock = $ProcessBlock -split ([Environment]::NewLine) -ne "" |
                ForEach-Object { " " * 4 + $_  + [Environment]::NewLine}

        
"function ${Name} {
    $([Management.Automation.ProxyCommand]::GetCmdletBindingAttribute($MetaData))    
    param(
        $paramBlock
    )
    
    begin {
$BeginBlock
    }
    
    process {
$ProcessBlock
    }
    
    end {
$EndBlock
    }
}
"


        }
    }
} 
