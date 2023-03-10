
Write-Host "`nZSCALER " -ForegroundColor Cyan -NoNewline
Write-Host " - Public Sector Professional Services - " -NoNewline
Write-Host " Backup and Restore Utility`n`n" -ForegroundColor Red

# Set Variables
$global:zscaler = [PSCustomObject]@{
    Modules = [PSCustomObject]@{
        ZPA = [PSCustomObject]@{
            isloaded = $false
            Authentication = $false 
            Swagger = ""
        }
    }
    settings = [PSCustomObject]@{
        Github = [PSCustomObject]@{
            Owner = "awalker-zscaler"
            Repo = "zscaler-backup-restore"
        }
    }
    ZPAEnvironment = [PSCustomObject]@{
        ZPAhost = "https://config.zpagov.net"
        client_id = "NzIwNTgwMzMxOTgzMzM5NjQtMjE5NDc5YjAtZDg0Zi00NjVkLTg3YmEtOTg2N2ZmMTk1MDdm"
        client_secret = '?p#!,KMy4$X2#wcEk5`K$r08.3~kvl~?'
        customer_id = '72058033198333952'
        token = ""
        authenticated = $false
        Backups = @()
    }
}

# Show MIT License
Write-Host (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/$($global:zscaler.settings.Github.owner)/$($global:zscaler.settings.Github.Repo)/main/LICENSE").content -ForegroundColor DarkGray

# Show Script README.md
Write-Host (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/$($global:zscaler.settings.Github.owner)/$($global:zscaler.settings.Github.Repo)/main/README.md").content

# Get Client ID
IF($null -eq $global:zscaler.ZPAEnvironment.client_id){
    Read-Host -Prompt "Please provide your client ID.`n`n Your client ID can be found on this page:`nhttps://admin.zpagov.net/#clientCredentials"
}

# Get Client Secret
IF($null -eq $global:zscaler.ZPAEnvironment.client_secret){
    Read-Host -Prompt "Please provide your client secret.`n`n Your client secret is only presented the first time you create an API key. "
}

# Get Customer ID
IF($null -eq $global:zscaler.ZPAEnvironment.customer_id){
    Read-Host -Prompt "Please provide your Customer ID.`n`n Your customer ID can be found on the API page, just click copy customer ID at the top right of the page. "
}

Function Invoke-Menu {
    $backup = New-Object System.Management.Automation.Host.ChoiceDescription '&Backup', 'Backup: Backup my configurations. '
    $restore = New-Object System.Management.Automation.Host.ChoiceDescription '&Restore', 'Restore: Using an existing backup, restore myconfiguration. '
    $compare = New-Object System.Management.Automation.Host.ChoiceDescription '&Compare', 'Compare: View changes since last backup. '
    $quit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Exit this script. '
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($backup, $restore, $compare, $quit)
    $title = 'Backup or Restore'
    $message = 'Do you want to backup your current confiugration or restore to a previously collected configuration?'
    $result = $host.ui.PromptForChoice($title, $message, $options, 3)
    IF($result -eq 0){
        # Backup Selected
        Invoke-Menu_Backup
    }
    ELSEIF($result -eq 1){
        Invoke-Menu_Restore

    }
    ELSEIF($result -eq 2){
        Invoke-Menu_Compare

    }
    ELSE{
        break
    }
}
Function Invoke-Menu_Backup {
    $ZPA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&PA', 'Backup my ZPA Configurations. '
    $ZIA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&IA', 'Backup my ZIA Configurations. '
    $ALL = New-Object System.Management.Automation.Host.ChoiceDescription '&ALL', 'Backup my ZPA and ZIA configurations.  '
    $quit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Return to main menu '
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($ZPA, $ZIA, $ALL, $quit)
    $title = 'Backup Selection'
    $message = 'What do you want to backup?'
    $result = $host.ui.PromptForChoice($title, $message, $options, 3)
    IF($result -eq 0){
        # ZPA Selected
        Invoke-Expression(Invoke-WebRequest("https://raw.githubusercontent.com/$($global:zscaler.settings.Github.owner)/$($global:zscaler.settings.Github.Repo)/main/functions/invoke-zpabackup.ps1").content)
        
    }
    ELSEIF($result -eq 1){
        # ZIA Selected

    }
    ELSEIF($result -eq 2){
        # ALL Selected

    }
    ELSE{
        Invoke-Menu
    }
}
Function Invoke-Menu_Restore {
    $ZPA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&PA', 'Restore my ZPA Configurations. '
    $ZIA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&IA', 'Restore my ZIA Configurations. '
    $ALL = New-Object System.Management.Automation.Host.ChoiceDescription '&ALL', 'Restore my ZPA and ZIA configurations.  '
    $quit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Return to main menu '
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($ZPA, $ZIA, $ALL, $quit)
    $title = 'Restore Selection'
    $message = 'What do you want to Restore?'
    $result = $host.ui.PromptForChoice($title, $message, $options, 3)
    IF($result -eq 0){
        # ZPA Selected
        
    }
    ELSEIF($result -eq 1){
        # ZIA Selected

    }
    ELSEIF($result -eq 2){
        # ALL Selected

    }
    ELSE{
        Invoke-Menu
    }
}
Function Invoke-Menu_Compare {
    $ZPA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&PA', 'Compare my ZPA Configurations. '
    $ZIA = New-Object System.Management.Automation.Host.ChoiceDescription 'Z&IA', 'Compare my ZIA Configurations. '
    $ALL = New-Object System.Management.Automation.Host.ChoiceDescription '&ALL', 'Compare my ZPA and ZIA configurations.  '
    $quit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Return to main menu '
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($ZPA, $ZIA, $ALL, $quit)
    $title = 'Compare Selection'
    $message = 'What do you want to Compare?'
    $result = $host.ui.PromptForChoice($title, $message, $options, 3)
    IF($result -eq 0){
        # ZPA Selected
        
    }
    ELSEIF($result -eq 1){
        # ZIA Selected

    }
    ELSEIF($result -eq 2){
        # ALL Selected

    }
    ELSE{
        Invoke-Menu
    }
}
Invoke-Menu
