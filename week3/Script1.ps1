function PrintPreviousLogs($days){

$loginouts = Get-EventLog System -Source Microsoft-Windows-WinLogOn -After (Get-Date).AddDays($days)

$logTable = @()
for($i = 0; $i -lt $loginouts.Count; $i++)
{
    $events = ""
    if ($loginouts[$i].InstanceId -eq 7001) {$events = "LogOn"}
    if ($loginouts[$i].InstanceId -eq 7002) {$events = "LogOff"}

    $user = $loginouts[$i].ReplacementStrings[1]

    #So this is how you make objects? Cool.
    $userTranslate = New-Object -TypeName System.Security.Principal.SecurityIdentifier -ArgumentList $user
    $user = $userTranslate.Translate([System.Security.Principal.NTAccount]).Value


    $logTable += [pscustomobject]@{`
    "Time" = $loginouts[$i].TimeGenerated;`
    "Id" = $loginouts[$i].InstanceId;`
    "Event" = $events;`
    "User" = $user;
    }
                  
}

return $logTable 
}

function PrintShutDownLogs($days){

$turnoffs = Get-EventLog System -After (Get-Date).AddDays($days) | Where-Object {$_.EventID -eq 6006}
$turnons = Get-EventLog System -After (Get-Date).AddDays($days) | Where-Object {$_.EventID -eq 6005}

$logTable = @()
for($i = 0; $i -lt $turnoffs.Count; $i++)
{
    $events = "LogOn"

    $user = "System"


    $logTable += [pscustomobject]@{`
    "Time" = $turnoffs[$i].TimeGenerated;`
    "Id" = $turnoffs[$i].InstanceId;`
    "Event" = $events;`
    "User" = $user;
    }

    $events = "LogOff"

    $logTable += [pscustomobject]@{`
    "Time" = $turnons[$i].TimeGenerated;`
    "Id" = $turnons[$i].InstanceId;`
    "Event" = $events;`
    "User" = $user;
    }
                  
}



return $logTable 
}