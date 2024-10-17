. "C:\Users\champuser\SYS320-01\week6\Event-Logs.ps1"
. "C:\Users\champuser\SYS320-01\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320-01\week7\Scheduler.ps1"
. "C:\Users\champuser\SYS320-01\week7\Email.ps1"

$configuration = readConfiguration
$Failed = getAtRiskUsers $configuration.Days
SendAlertEmail ($Failed | Format-Table | Out-String)
ChooseTimeToRun($configuration.Time)