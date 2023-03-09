$token = $global:zscaler.ZPAEnvironment.token
$response_raw = (Invoke-WebRequest -Uri "$($global:zscaler.ZPAEnvironment.ZPAhost)/v2/customSwagger?tag=mgmtconfig" -Method GET -Headers @{ Authorization = "Bearer $token"} )
$response = $response_raw.content | ConvertFrom-Json -AsHashtable
$global:zscaler.Modules.ZPA.Swagger = 0..$($response.paths.count -1) | ForEach-Object {
    [PSCustomObject]@{
        path = $response.paths.keys[$_]
        method = $response.paths.values[$_].keys
        tags = $response.paths.values[$_].values.values[0]
        summary = $response.paths.values[$_].values.values[1]
        operationId = $response.paths.values[$_].values.values[2]
        produces = $response.paths.values[$_].values.values[3]
        responses = $response.paths.values[$_].values.values[4]
        deprecated = $response.paths.values[$_].values.values[5]
    }
}