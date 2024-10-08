. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-CustomObject.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display Apache Logs`n"
$Prompt += "2 - Display last failed logins`n"
$Prompt += "3 - Display At-Risk Users`n"
$Prompt += "4 - Open Champlain Site`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $logs = ApacheLogs1
        $toPrint = $logs[-10..-1]

        $toPrint
    }

    elseif($choice -eq 2){
        $failedLogins = getFailedLogins 90
        $toPrint = $failedLogins[-10..-1]

        Write-Host ($toPrint | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 3){ 

        $riskyUsers = getAtRiskUsers 90
        Write-Host ($riskyUsers | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 4){

        $chrome = Get-Process -Name chrome
        if($chrome)
        {} else
        {
        Start-Process "title" "C:\Program Files\Google\Chrome\Application\chrome.exe" --start-fullscreen "https://www.champlain.edu/"
        }
    }

    else{
        Write-Host "Invalid option, please try again."
    }
}