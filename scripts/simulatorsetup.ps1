param(
[string] $simulatorUrl = "$1",
[string] $sqlservername = "$2"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($simulatorUrl,"C:\SimulatorSetup.msi")
$client.DownloadFile("https://projectiot.blob.core.windows.net/iotp2/DataServiceSetup.msi","C:\DataServiceAppSetup.msi")
C:\SimulatorSetup.msi /qn
$piserverconfig = "C:\Program Files (x86)\Default Company Name\SimulatorSetup\PiServerSimulator.exe.config"
$doc = (Get-Content $piserverconfig) -as [Xml]
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiConnectionString'}
$obj.value = 'Data Source=sqlvm; Initial Catalog=iottestdb; Persist Security Info=True; User ID=sqluser; Password=Sysgain@1234'
$doc.Save($piserverconfig)
Start-Process -FilePath " C:\Program Files (x86)\Default Company Name\SimulatorSetup\PiServerSimulator.exe "
