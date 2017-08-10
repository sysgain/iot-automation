# https://github.com/sysgain/iot-automation/raw/main/powerBItemplates/PowerBI_Templates.zip
# https://projectiot.blob.core.windows.net/iotp2/PBIDesktop_x64.msi
param(
[string] $powerBItemplates = "$1",
[string] $powerbidesktop = "$2"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($powerBItemplates,"C:\PowerBI_Templates.zip")
$client.DownloadFile($powerbidesktop,"C:\PBIDesktop_x64.msi")
$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
C:\PBIDesktop_x64.msi /qn /norestart ACCEPT_EULA=1