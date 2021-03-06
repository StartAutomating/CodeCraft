@{
    WebCommand = @{
        "Get-ReferencedCommand" = @{
            FriendlyName = "Unroll References"
        }
        "Get-Type" = @{
            FriendlyName = "Find A Type"
            HideParameter  = "Assembly", "Enum", "Type", "All"
            OutputProperty = "Name", "FullName"
        }
        "Write-PInvoke" = @{
            RunOnline = $true
            FriendlyName = "Pump out PInvoke"
            ContentType = 'text/plain'

        }
        "Write-Parameter" = @{
            RunOnline = $true
            FriendlyName = "Write a Parameter"
            ContentType = 'text/plain'
        }
        "Write-CommandOverload" = @{
            RunOnline=$true
            FriendlyName = "Overload a Command"
            ContentType = 'text/plain'
        }
        "Write-RemoteDataCollector" = @{
            RunOnline = $true
            FriendlyName = "Fan Out"
            PlainOutput = $true
            ContentType = 'text/plain'
        }        
        "Write-Interface" = @{
            RunOnline = $true
            HideParameter = @("Compile", "InputObject")
            FriendlyName = "Implement an Interface"
            ContentType = 'text/plain'
        }

        "Write-Program" = @{
            RunOnline = $true
            HideParameter = @("Command", "OutputCSharp", "OutputScript", "OutputPath", "Embed")
            FriendlyName = "Pop out Programs"
            DefaultParameter = @{
                OutputCSharp = $true
            }
            PlainOutput = $true
            ContentType = 'text/plain'
        }
                 

        "Write-Enum" = @{
            FriendlyName = "Easy Enums Here"
            ContentType = 'text/plain'

        }
        "Write-MarkupWriter" = @{
            FriendlyName = "Make Markup Generators"
            ContentType = 'text/plain'
        }
    }
    CommandOrder = 'Write-Enum', 'Write-Interface', 'Write-PInvoke', 'Get-Type', 'Get-ReferencedCommand', 'Write-Parameter', 'Write-Program', 'Write-RemoteDataCollector', 'Write-CommandOverload', "Write-MarkupWriter"
    Logo = '/CodeCraft_125x125.png'
    JQueryUITheme ='Custom'
    Style = @{
        Body = @{
            'color' = "#4D8F0B"
            'background-color' = "#FAFAFA"
        }
    }
    UseJQueryUI = $true
    AnalyticsId = 'UA-24591838-6'
    TwitterId = 'jamesbru'
    DomainSchematics = @{
        "codecraft.start-automating.com | codecraft.startautomating.com" = "Default"
    }
    AllowDownload = $true

    AdSense = @{
        Id = '7086915862223923'
        BottomAdSlot = '6352908833'
    }


    PubCenter = @{
        ApplicationId = "dc8163b7-4be4-4a7d-b208-5b165e4032c8"
        BottomAdUnit = "10049242"
    }


    Win8 = @{
        Identity = @{
            Name="Start-Automating.CodeCraft"
            Publisher="CN=3B09501A-BEC0-4A17-8A3D-3DAACB2346F3"
            Version="1.0.0.0"
        }
        Assets = @{
            "splash.png" = "/Codecraft_Splash.png"
            "smallTile.png" = "/Codecraft_Small.png"
            "wideTile.png" = "/Codecraft_Wide.png"
            "storeLogo.png" = "/Codecraft_Store.png"
            "squaretile.png" = "/Codecraft_Tile.png"
        }
        ServiceUrl = "http://codecraft.start-automating.com"

        Name = "CodeCraft"

    }


    Technet = @{
        Category="Using the Internet"
        Subcategory="Internet Explorer"
        OperatingSystem="Windows 7", "Windows Server 2008", "Windows Server 2008 R2", "Windows Vista", "Windows XP", "Windows Server 2012", "Windows 8"
        Tag='Code generation', 'Start-Automating'
        MSLPL=$true
        Summary="
CodeCraft is a module to help you churn out the code.  It's a collection of handy autocoders you can use to take the tedium out of writing code.
"
        Url = 'http://gallery.technet.microsoft.com/CodeCraft-81d4f1c0'
    }


    GitHub = @{
        Owner = "StartAutomating"
        Project = "CodeCraft"
        Url = "https://github.com/StartAutomating/CodeCraft"
    }
}
