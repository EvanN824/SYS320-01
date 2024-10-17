function gatherIOC(){

$page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.5/IOC.html

$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for($i=1; $i -lt $trs.length; $i++)
{
    $tds = $trs[$i].getElementsByTagName("td")

    $FullTable += [pscustomobject]@{
        "Pattern" = $tds[0].innerText;
        "Explanation" = $tds[1].innerText;
    }
}

return $FullTable
}

function GetLogs(){
$logsNotformatted = Get-Content C:\xampp\apache\logs\access2.log
$tableRecords = @()

for($i = 0; $i -lt $logsNotformatted.Count; $i++){

$words = $logsNotformatted[$i].Split(" ");

$tableRecords += [pscustomobject]@{ 
"IP" = $words[0];
"Time" = $words[3].Trim('[');
"Method" = $words[4].Trim('"');
"Page" = $words[6];
"Protocol" = $words[7];
"Response" = $words[8];
"Referrer" = $words[10];
"Client" = $words[11..($words.Count - 1)];
}

}

return $tableRecords | Where-Object {$_.IP -like "10.*"}

}

function FinalizeLogs($log, $ioc){

$export = @()

for($i = 0; $i -lt $log.length; $i++){
for($j = 0; $j -lt $ioc.length; $j++){
    if ($log[$i].Page -match $ioc[$j].Pattern)
    {
        if ($export.Contains($log[$i])){

        }
        else
        {
            $export += $log[$i]
        }
    }
}
}
Write-Host $log[0].Page | Out-String
return $export
}

$logs = GetLogs
$iocs = gatherIOC
$toPrint = FinalizeLogs $logs $iocs
$toPrint