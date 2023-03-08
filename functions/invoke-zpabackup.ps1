Write-Progress -Activity "Loading ZPA Backup Functions" -PercentComplete 0
# Load ZPA Authentication Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/Authentication.ps1"
Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Authentication Functions" -PercentComplete 10
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Authentication = $true
    Invoke-Expression $response.content
    Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Authentication Functions" -PercentComplete 20
}ELSE{Write-Error -Message "Unable to load ZPA Authentication Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}
# Load ZPA App Segment Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/backup/AppSegment.ps1"
Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Application Segment Backup Functions" -PercentComplete 30
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Backups.AppSegments = $true
    Invoke-Expression $response.content
    Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Application Segment Backup Functions" -PercentComplete 40
}ELSE{Write-Error -Message "Unable to load ZPA Application Segment Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}
# Load ZPA Segment Group Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/backup/SegmentGroup.ps1"
Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Segment Group Backup Functions" -PercentComplete 50
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Backups.SegmentGroups = $true
    Invoke-Expression $response.content
    Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Segment Group Backup Functions" -PercentComplete 60
}ELSE{Write-Error -Message "Unable to load ZPA Segment Group Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}
# Load ZPA Server Group Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/backup/ServerGroup.ps1"
Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Server Group Backup Functions" -PercentComplete 70
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Backups.ServerGroups = $true
    Invoke-Expression $response.content
    Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Server Group Backup Functions" -PercentComplete 80
}ELSE{Write-Error -Message "Unable to load ZPA Server Group Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}
# Load ZPA Server Functions
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/awalker-zscaler/zscaler-backup-restore/main/functions/zpa/backup/Servers.ps1"
Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Server Backup Functions" -PercentComplete 90
IF($response.StatusCode -eq "200" -and $null -ne $response.Content){
    $Global:zscaler.Modules.ZPA.submodules.Backups.Servers = $true
    Invoke-Expression $response.content
    Write-Progress -Activity "Loading ZPA Backup Functions" -Status "Grabbing Server Backup Functions" -PercentComplete 100
}ELSE{Write-Error -Message "Unable to load ZPA Server Functions." -RecommendedAction "Verify Internet connectivity and ensure there is not an outage on Github."}
# Check to ensure all functions loaded correctly
IF($global:zscaler.modules.ZPA.submodules.Authentication -eq $true -and $global:zscaler.modules.ZPA.submodules.backups.AppSegments -eq $true -and $global:zscaler.modules.ZPA.submodules.backups.SegmentGroups -eq $true -and $global:zscaler.modules.ZPA.submodules.backups.ServerGroups -eq $true -and $global:zscaler.modules.ZPA.submodules.backups.Servers -eq $true){
    $global:zscaler.modules.ZPA.isloaded = $true
    Write-Progress -Activity "Loading ZPA Backup Functions" -Completed
    Write-Host "All ZPA Backup functions were loaded sucessfully." -ForegroundColor Green
}ELSE{
    Write-Host "There were some errors loading modules. This will cause issues going forward in this application. " -ForegroundColor Red
}

Write-Host "Authenticating against the Zscaler ZPA API " -NoNewline
# Log in to Zscaler ZPA API
IF(Invoke-ZPAAPILOGIN){
    Write-Host "SUCCESS " -ForegroundColor Green
}ELSE{
    Write-Host "FAILURE " -ForegroundColor Red
}