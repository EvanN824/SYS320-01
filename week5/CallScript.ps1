. (Join-Path $PSScriptRoot ClassScanner.ps1)

$printable = gatherClasses
$ITSInstructors = $printable | Where-Object {($_."Class Code" -clike "SYS*") -or `
($_."Class Code" -clike "NET*") -or ($_."Class Code" -clike "SEC*") -or ($_."Class Code" -clike "FOR*") -or `
($_."Class Code" -clike "CSI*") -or ($_."Class Code" -clike "DAT*") } | Sort-Object "Instructor" `
| Select-Object "Instructor" -Unique

$printable | foreach {$_.Instructor -in $ITSInstructors.Instructor} | Select-Object "Instructor" | Group-Object Count,Name | Sort-Object Count -Descending                                          