param(
[string] $simulatorUrl = "$1",
[string] $dataserviceUrl = "$2",
[string] $PIWebApisimulatorUrl = "$3",
[string] $adminuser = "$4",
[string] $adminPassword = "$5",
[string] $sqlservername = "$6"
)
$PIAFservicesUrl = "https://projectiot.blob.core.windows.net/iotp2/PI-AF-Services_2017-SP1a_.exe"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($PIAFservicesUrl,"C:\PI-AF-Services_2017-SP1a_.exe")
$client.DownloadFile($simulatorUrl,"C:\SimulatorSetup.msi")
Start-Sleep -s 12
$client.DownloadFile($dataserviceUrl,"C:\DataServiceAppSetup.msi")
Start-Sleep -s 12
$client.DownloadFile($PIWebApisimulatorUrl,"C:\PIWebApiSimulatorSetup.msi")
C:\PI-AF-Services_2017-SP1a_.exe ADDLOCAL=ALL AFSERVICEACCOUNT=adminuser AFSERVICEPASSWORD=Password@1234 FDSQLDBSERVER=PIAFSQLSERVER /quiet