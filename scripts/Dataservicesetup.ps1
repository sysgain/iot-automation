param(
[string] $dataserviceUrl = "$1",
[string] $sqlservername = "$2"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($dataserviceUrl,"C:\DataServiceAppSetup.msi")
C:\DataServiceAppSetup.msi /qn
$piserverconfig = "C:\Program Files (x86)\Default Company Name\DataServiceSetup\DataService.exe.config"
$doc = (Get-Content $piserverconfig) -as [Xml]