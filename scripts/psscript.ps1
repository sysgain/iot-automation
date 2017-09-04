param
(
[string] $domainName = "$1",

[string] $username = "$2",

[string] $password = "$3"
)
$PIIntegratorBAUrl = "https://projectiot.blob.core.windows.net/iotp2/OSIsoft.PIIntegratorBA.txt"
$client = new-object System.Net.WebClient
$client.DownloadFile($PIIntegratorBAUrl,"C:\OSIsoft.PIIntegratorBA.txt")
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
$usernamenNew = $domainName+"\"+${username}
Set-DnsClient `
    -InterfaceAlias "Ethernet*" `
    -ConnectionSpecificSuffix $domainName
$securePassword =  ConvertTo-SecureString $password `
    -AsPlainText `
    -Force

$cred = New-Object System.Management.Automation.PSCredential($usernamenNew, $securePassword)
    
Add-Computer -DomainName $domainName -Credential $cred -Restart