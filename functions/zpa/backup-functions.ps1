Function Invoke-ZPAAPI_Backup_App_Server_Controller {
    Write-Progress -Activity "Getting list of all server endpoints" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "$($global:zscaler.ZPAEnvironment.ZPAhost)/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/server?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "$($global:zscaler.ZPAEnvironment.ZPAhost)/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/server?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all server endpoints" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.app_server_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_Application_Controller {
    Write-Progress -Activity "Getting list of all configured application segments" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/application?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all configured application segments" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all configured application segments" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/application?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all configured application segments" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.application_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_Segment_Group_Controller {
    Write-Progress -Activity "Getting list of all configured Segment Groups" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/segmentGroup?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all configured Segment Groups" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all configured Segment Groups" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/segmentGroup?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all configured Segment Groups" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.segment_group_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_Connector_Controller {
    Write-Progress -Activity "Getting list of all configured Connectors" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/connector?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all configured Connectors" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all configured Connectors" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/connector?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all configured Connectors" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_Connector_Group_Controller {
    Write-Progress -Activity "Getting list of all configured Connector Groups" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/appConnectorGroup?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all configured Connector Groups" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all configured Connector Groups" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/appConnectorGroup?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all configured Connector Groups" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.connector_group_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_BA_Certificate_Controller {
    Write-Progress -Activity "Getting list of all issued certificates" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v2/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/clientlessCertificate/issued?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all issued certificate" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all issued certificate" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v2/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/clientlessCertificate/issued?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all issued certificate" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $list
    }
}
Function Invoke-ZPAAPI_Backup_Customer_Controller {
    Write-Progress -Activity "Getting list of all authentication domains" -Status "Connecting..." -PercentComplete 0
    $token = $global:zscaler.ZPAEnvironment.token
    $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/authdomains?page=1&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
    IF($response.totalPages -eq 0){
        $global:zscaler.Modules.ZPA.Backups.connector_controller = $true
        return $null
    }
    $percentage = ((1/$response.totalPages)*100)
    Write-Progress -Activity "Getting list of all authentication domains" -Status "Downloading..." -PercentComplete $percentage
    $list = $response.list
    IF($response.totalPages -gt 1){
        2..$response.totalPages | ForEach-Object {
            $percentage = $(($($_)/$response.totalPages)*100)
            Write-Progress -Activity "Getting list of all authentication domains" -Status "Downloading..." -PercentComplete $percentage
            $response = Invoke-RestMethod -URI "https://config.zpagov.net/mgmtconfig/v1/admin/customers/$($global:zscaler.ZPAEnvironment.customer_id)/authdomains?page=$($_)&pagesize=500" -Method Get -ContentType '*/*'  -Headers @{ Authorization = "Bearer $token"}
            $list += $response.list
        }
    }
    Write-Progress -Activity "Getting list of all authentication domains" -Status "Downloading..." -Completed
    IF([bool]($response.PSobject.Properties.name -match "list")){
        $global:zscaler.Modules.ZPA.Backups.customer_controller = $true
        return $list
    }
}