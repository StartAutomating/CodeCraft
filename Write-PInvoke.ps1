function Write-PInvoke
{
    <#
    .Synopsis
        Creates C# code to access a C function
    .Description
        Creates P/Invoke C# code to access a C function
    .Example
        Write-PInvoke -Library User32.dll -Signature GetSystemMetrics(uint Metric)
    .Link
        http://www.pinvoke.net/
    #>
    param(
    # The C Library Containing the Function, i.e. User32
    [Parameter(Mandatory=$true, 
        HelpMessage="The C Library Containing the Function, i.e. User32",
        ValueFromPipelineByPropertyName=$true)]
    [String]
    $Library,
    
    # The Signature of the Method, i.e. int GetSystemMetrics(int Metric
    [Parameter(Mandatory=$true,
        HelpMessage="The Signature of the Method, i.e. int GetSystemMetrics(int Metric",
        ValueFromPipelineByPropertyName=$true)]
    [String]
    $Signature        
    )
    
    process {
        if ($Library -notlike "*.dll*") {
            $Library+=".dll"
        }
        if ($signature -notlike "*;") {
            $Signature+=";"
        }
        if ($signature -notlike "public static extern*") {
            $signature = "public static extern $signature"
        }
        
"[DllImport(`"$Library`")]
$Signature"                        
    }
}