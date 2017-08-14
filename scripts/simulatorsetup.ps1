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
C:\DataServiceAppSetup.msi /qn
$dataserviceconfig = "C:\Program Files (x86)\Default Company Name\DataServiceSetup\DataService.exe.config"
$doc = (Get-Content $dataserviceconfig) -as [Xml]
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'AzureConnectionString'}
$obj.value = Server=tcp:$azuresqlservername,1433;Initial Catalog=$azuresqlserverdbname;Persist Security Info=False;User ID=$sqlusername;Password=$sqlpassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=301
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'StorageConnectionString'}
$obj.value = DefaultEndpointsProtocol=https;AccountName=$storageaccountname;AccountKey=${storageaccountkey}update;EndpointSuffix=core.windows.net
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiServerConnectionString'}
$obj.value = data source=$sqlservername;initial catalog=PIFD;persist security info=True;user id=$sqlusername;password=$sqlpassword
$doc.Save($dataserviceconfig)
Start-Service -SERVICENAME DataServiceEM
Start-Sleep -s 30
$client.DownloadFile($PIWebApisimulatorUrl,"C:\Deploy\PIWebApiSimulatorSetup.msi")
C:\PIWebApiSimulatorSetup.msi /qn
Start-Sleep -s 12 
$client.DownloadFile($PIAFInstallationFile,"C:\Deploy\piafinstallation.ps1")
Start-Sleep -s 12
$client.DownloadFile($PITemplates,"C:\Deploy\PITemplates.zip") 
#C:\PI-AF-Services_2017-SP1a_.exe ADDLOCAL=ALL AFSERVICEACCOUNT=PIAFSQLSERVER\adminuser AFSERVICEPASSWORD=Password@1234 FDSQLDBSERVER=PIAFSQLSERVER /quiet