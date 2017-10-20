param(
[string] $simulatorUrl = "$1",
[string] $dataserviceUrl = "$2",
[string] $PIWebApisimulatorUrl = "$3"
)
$PIAFservicesUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-AF-Services_2017-SP1a_.exe"
$PIAFInstallationFile = "https://projectiot.blob.core.windows.net/iotp2/piafinstallation.ps1"
$PIdataArchiveUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-Data-Archive_2017-SP1_.exe"
$PITemplates = "https://projectiot.blob.core.windows.net/iotp2/PITemplates.zip"
$UFLConnector = "https://projectiot.blob.core.windows.net/iotp2/UFL%20Connector.zip"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
New-Item C:\Deploy -type directory
$client.DownloadFile($PIAFservicesUrl,"C:\Deploy\PI-AF-Services_2017-SP1a_.exe")
$client.DownloadFile($PIdataArchiveUrl,"C:\Deploy\PI-Data-Archive_2017-SP1_.exe")
$client.DownloadFile($simulatorUrl,"C:\Deploy\SimulatorSetup.msi")
$client.DownloadFile($UFLConnector,"C:\Deploy\UFL%20Connector.zip")
Start-Sleep -s 12
$client.DownloadFile($dataserviceUrl,"C:\Deploy\DataServiceAppSetup.msi")
C:\Deploy\DataServiceAppSetup.msi /qn
Start-Sleep -s 30
$client.DownloadFile($PIWebApisimulatorUrl,"C:\Deploy\PiWebAPISimulatorSetup.msi")
C:\Deploy\PiWebAPISimulatorSetup.msi /qn
Start-Sleep -s 12 
$client.DownloadFile($PIAFInstallationFile,"C:\Deploy\piafinstallation.ps1")
Start-Sleep -s 12
$client.DownloadFile($PITemplates,"C:\Deploy\PITemplates.zip") 
#C:\PI-AF-Services_2017-SP1a_.exe ADDLOCAL=ALL AFSERVICEACCOUNT=PIAFSQLSERVER\adminuser AFSERVICEPASSWORD=Password@1234 FDSQLDBSERVER=PIAFSQLSERVER /quiet