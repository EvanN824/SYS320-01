. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-CustomObject.ps1)

$page = 'index.html'
$http = ' 404 '
$browser = 'Chrome'

$ipsoftens = GetAddresses $page $http $browser
$counts = $ipsoftens | Group-Object -Property Count
$counts | Select-Object Count, Name

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap