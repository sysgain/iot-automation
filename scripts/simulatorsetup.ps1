param(
[string] $simulatorUrl = "$1",
[string] $dataserviceUrl = "$2",
[string] $PIWebApisimulatorUrl = "$3"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($simulatorUrl,"C:\SimulatorSetup.msi")
Start-Sleep -s 12
$client.DownloadFile($dataserviceUrl,"C:\DataServiceAppSetup.msi")
Start-Sleep -s 12
$client.DownloadFile($PIWebApisimulatorUrl,"C:\PIWebApiSimulatorSetup.msi")