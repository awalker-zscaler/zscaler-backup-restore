function Invoke-ZPAAPILOGIN {
    $parameters = @{
        client_id = $global:zscaler.ZPAEnvironment.client_id
        client_secret = $global:zscaler.ZPAEnvironment.client_secret
    }
    #login
    $global:zscaler.ZPAEnvironment.token = (Invoke-RestMethod -Uri "$($global:zscaler.ZPAEnvironment.ZPAhost)/signin" -Method Post -Form $parameters -ContentType '*/*').access_token
    IF($null -ne $global:zscaler.ZPAEnvironment.token){return $true}else{return $false}
}
function Invoke-ZPAAPILOGOUT {
    $parameters = @{
        client_id = $global:zscaler.ZPAEnvironment.client_id
        client_secret = $global:zscaler.ZPAEnvironment.client_secret
    }
    #logout
    $token = $global:zscaler.ZPAEnvironment.token
    return (Invoke-RestMethod -Uri "$($global:zscaler.ZPAEnvironment.ZPAhost)/signout" -Method Post -Form $parameters -ContentType '*/*' -Headers @{ Authorization = "Bearer $token"})
}
