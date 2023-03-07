Write-Progress -Activity "Getting list of all server endpoints" -Status "Connecting..." -PercentComplete 0
$token = $global:zscaler.ZPAEnvironment.token
$response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/server?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
$percentage = ((1/$response.totalPages)*100)
Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -PercentComplete $percentage
$list = $response.list
IF($response.totalPages -gt 1){
    2..$response.totalPages | ForEach-Object {
        $percentage = $(($($_)/$response.totalPages)*100)
        Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -PercentComplete $percentage
        $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/server?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
        $list += $response.list
    }
}
Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -Completed
$list