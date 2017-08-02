param(
[string] $sqlQueryUrl = "$1",
[string] $sqlservername = "$2",
[string] $sqlAuthenticationLogin = "$3",
[string] $sqlAuthenticationPassword = "$4",
[string] $databaseName = "$5"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = New-Object System.Net.WebClient
$client.DownloadFile($sqlQueryUrl,"C:\createdb.sql")
cd C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn
sqlcmd.exe -S $sqlservername -U $sqlAuthenticationLogin -P $sqlAuthenticationPassword -i C:\createdb.sql -o "C:\Testoutput.txt"
