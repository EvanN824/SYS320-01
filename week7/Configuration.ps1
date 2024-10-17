function readConfiguration(){
$configFile = (Join-Path $PSScriptRoot "configuration.txt")
$info = Get-Content $configFile
$printable = @()
$printable += [pscustomobject]@{"Days" = $info[0]; "Time" = $info[1];}
return $printable
}

function changeConfiguration($days, $time){
$configFile = (Join-Path $PSScriptRoot "configuration.txt")
$days | Out-File $configFile 
$time | Out-File $configFile -Append
}

function configurationMenu(){

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Show configuration`n"
$Prompt += "2 - Change configuration`n"
$Prompt += "3 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $toPrint = readConfiguration 
        Write-Host ($toPrint | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        Write-Host "Input New Days" | Out-String
        $days = Read-Host

        if ($days -match "[0-9]{1,3}"){

        Write-Host "Input New Time" | Out-String
        $time = Read-Host

        if ($time -clike "[1-9]:[0-5][0-9] [AP]M"){

        changeConfiguration $days $time
        Write-Host "Config changed" | Out-String

        }else{
        Write-Host "Invalid Input, format is digit:digitdigit AM/PM" | Out-String
        }

        }
        else {
        Write-Host "Invalid Input, digits between 0-999 only" | Out-String
        }

        #Write-Host ($toPrint | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    else{
        Write-Host "Invalid option, please try again."
    }
}
}