$global:zscaler = [PSCustomObject]@{
    Modules = [PSCustomObject]@{
        ZPA = [PSCustomObject]@{
            isloaded = $false
            Authentication = $false 
            Swagger = ""
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

[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$global:zscaler.ZPAEnvironment.backups = ""
# Load ZPA Authentication Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/Authentication.ps1"
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.Authentication = $true
    Invoke-Expression $response.content
}ELSE{Write-Error -Message "Unable to load ZPA Authentication Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}

Write-Host "Authenticating against the Zscaler ZPA API " -NoNewline
# Log in to Zscaler ZPA API
IF(Invoke-ZPAAPILOGIN){
    Write-Host "SUCCESS " -ForegroundColor Green
    $global:zscaler.ZPAEnvironment.authenticated = $true
}ELSE{
    Write-Host "FAILURE " -ForegroundColor Red
}

# Grab functions from the ZPA Swagger API
IF($global:zscaler.ZPAEnvironment.authenticated){
    Write-Host "Grabbing ZPA SWAGGER 2.0 Functions" -NoNewline
    Invoke-Expression(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/invoke-zpa-swagger.ps1")
    IF($null -ne $global:zscaler.Modules.ZPA.Swagger){
        Write-Host " SUCCESS" -ForegroundColor Green
    }ELSE{
        Write-Host " FAILURE" -ForegroundColor Red
        Write-Host " Unable to get API calls.  This is a critical error. "
    }
}

$global:zscaler.Modules.ZPA.Swagger | Where-Object {$_.method -like "*get*"} | ForEach-Object { #Filter to include only GET requests
    $path = $_.path.replace("{customerId}",$global:zscaler.ZPAEnvironment.customer_id) #Insert Customer ID
    IF($path -match "^[^{]+$"){ #Filter to include only top level queries
        $token = $global:zscaler.ZPAEnvironment.token
        $uri = "$($global:zscaler.ZPAEnvironment.ZPAhost)$($path)"
        try{$response = Invoke-RestMethod -URI "$($uri)?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}}catch{}
        IF($response.totalPages -eq 0 -or $null -eq $reponse){
            $list = ""
        }ELSE{
            $list = $response.list
            IF($response.totalPages -gt 1){
                2..$response.totalPages | ForEach-Object {
                    $response = Invoke-RestMethod -URI "$uri&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
                    $list += $response.list
                }
            }
        }        
        $global:zscaler.ZPAEnvironment.backups += [PSCustomObject]@{
            Name = $_.tags
            Path = "$($global:zscaler.ZPAEnvironment.ZPAhost)$($path)"
            Method = $_.method
            Description = $_.summary
            Data = $list
            CollectionTime = $(Get-Date -format 'u')
        }
    }
}

Write-Host "Logging out of the Zscaler ZPA API " -NoNewline
# Log in to Zscaler ZPA API
IF(Invoke-ZPAAPILOGOUT){
    Write-Host "SUCCESS " -ForegroundColor Green
    $global:zscaler.ZPAEnvironment.authenticated = $false
}ELSE{
    Write-Host "FAILURE " -ForegroundColor Red
}

function Save-File([string] $initialDirectory){

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null

    return $OpenFileDialog.filename
}
$savefile = Save-File "%userprofile%\Downloads"
[PSCustomObject]@{
    ZPAhost = "https://config.zpagov.net"
    client_id = "NzIwNTgwMzMxOTgzMzM5NjQtMjE5NDc5YjAtZDg0Zi00NjVkLTg3YmEtOTg2N2ZmMTk1MDdm"
    customer_id = '72058033198333952'
    backups = $global:zscaler.ZPAEnvironment.backups
}
if ($SaveFile -ne "") {
    [PSCustomObject]@{
        ZPAhost = $global:zscaler.ZPAEnvironment.zpahost
        client_id = $global:zscaler.ZPAEnvironment.client_id
        customer_id = $global:zscaler.ZPAEnvironment.customer_id
        backups = $global:zscaler.ZPAEnvironment.backups
    } | Export-CLIXML -depth 10 -path $savefile
    
} else {
    echo "No File was chosen"
}