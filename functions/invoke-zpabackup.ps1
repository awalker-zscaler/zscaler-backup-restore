$global:zscaler = [PSCustomObject]@{
    Modules = [PSCustomObject]@{
        ZPA = [PSCustomObject]@{
            isloaded = $false
            Authentication = $false 
            Swagger = ""
            Backups = @()
        }
    }
    ZPAEnvironment = [PSCustomObject]@{
        ZPAhost = "https://config.zpagov.net"
        client_id = "NzIwNTgwMzMxOTgzMzM5NjQtMjE5NDc5YjAtZDg0Zi00NjVkLTg3YmEtOTg2N2ZmMTk1MDdm"
        client_secret = '?p#!,KMy4$X2#wcEk5`K$r08.3~kvl~?'
        customer_id = '72058033198333952'
        token = ""
        authenticated = $false
    }
}

# Load ZPA Authentication Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/Authentication.ps1"
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Authentication = $true
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