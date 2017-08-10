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
C:\PBIDesktop_x64.msi /qn /norestart ACCEPT_EULA=1