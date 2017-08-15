param(
[string] $simulatorUrl = "$1",
[string] $dataserviceUrl = "$2",
[string] $PIWebApisimulatorUrl = "$3",
[string] $adminuser = "$4",
[string] $adminPassword = "$5",
[string] $sqlservername = "$6",
[string] $azuresqlservername = "$7",
[string] $azuresqlserverdbname = "$8",
[string] $sqlusername = "$9",
[string] $sqlpassword = "$10",
[string] $storageaccountname = "$11",
[string] $storageaccountkey = "$12"
)
$PIAFservicesUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-AF-Services_2017-SP1a_.exe"
$PIAFInstallationFile = "https://projectiot.blob.core.windows.net/iotp2/piafinstallation.ps1"
$PITemplates = "https://projectiot.blob.core.windows.net/iotp2/PITemplates.zip"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
New-Item C:\Deploy -type directory
$client.DownloadFile($PIAFservicesUrl,"C:\Deploy\PI-AF-Services_2017-SP1a_.exe")
$client.DownloadFile($simulatorUrl,"C:\Deploy\SimulatorSetup.msi")
Start-Sleep -s 12
$client.DownloadFile($dataserviceUrl,"C:\Deploy\DataServiceAppSetup.msi")
C:\Deploy\DataServiceAppSetup.msi /qn
Start-Sleep -s 30
$client.DownloadFile($PIWebApisimulatorUrl,"C:\Deploy\PIWebApiSimulatorSetup.msi")
C:\Deploy\PIWebApiSimulatorSetup.msi /qn
Start-Sleep -s 12 
$client.DownloadFile($PIAFInstallationFile,"C:\Deploy\piafinstallation.ps1")
Start-Sleep -s 12
$client.DownloadFile($PITemplates,"C:\Deploy\PITemplates.zip") 
#C:\PI-AF-Services_2017-SP1a_.exe ADDLOCAL=ALL AFSERVICEACCOUNT=PIAFSQLSERVER\adminuser AFSERVICEPASSWORD=Password@1234 FDSQLDBSERVER=PIAFSQLSERVER /quiet