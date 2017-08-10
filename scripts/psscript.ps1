param
(
[string] $domainName = "$1",

[string] $username = "$2",

[string] $password = "$3"
)
$PIdataArchiveUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-Data-Archive_2017-SP1_.exe"
$PIIntegratorBAUrl = "https://projectiot.blob.core.windows.net/iotp2/OSIsoft.PIIntegratorBA_DW_5000_1.2.0.104_.exe"
$PIlicenseUrl = "https://projectiot.blob.core.windows.net/iotp2/pilicense.dat"
$client = new-object System.Net.WebClient
$client.DownloadFile($PIdataArchiveUrl,"C:\PI-Data-Archive_2017-SP1_.exe")
$client.DownloadFile($PIIntegratorBAUrl,"C:\OSIsoft.PIIntegratorBA_DW_5000_1.2.0.104_.exe")
$client.DownloadFile($PIlicenseUrl,"C:\pilicense.dat")
$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
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