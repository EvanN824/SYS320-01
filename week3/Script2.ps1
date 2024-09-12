. (Join-Path $PSScriptRoot Script1.ps1)

clear

$toPrint = PrintShutDownLogs -14
$toPrint

$toWrite = PrintPreviousLogs -14
$toWrite