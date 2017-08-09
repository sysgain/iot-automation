param
(
[string] $domainName = "$1",

[string] $username = "$2",

[string] $password = "$3"
)
$PIdataArchiveUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-Data-Archive_2017-SP1_.exe"
$PIIntegratorBAUrl = "https://projectiot.blob.core.windows.net/iotp2/OSIsoft.PIIntegratorBA_DW_5000_1.2.0.104_.exe"
$client = new-object System.Net.WebClient
$client.DownloadFile($PIdataArchiveUrl,"C:\PI-Data-Archive_2017-SP1_.exe")
$client.DownloadFile($PIIntegratorBAUrl,"C:\OSIsoft.PIIntegratorBA_DW_5000_1.2.0.104_.exe")
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