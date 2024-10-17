function GetAddresses ($page, $httpcode, $browser){

$notfounds = Get-Content C:\xampp\apache\logs\access2.log | select-string -Pattern $page | select-string -Pattern $httpcode | Select-String -Pattern $browser
    
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for ($i = 0; $i -lt $ipsUnorganized.Count; $i++)
{
    $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].Value;}
}
$ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
return $ipsoftens
}