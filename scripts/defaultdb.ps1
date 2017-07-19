$client = new-object System.Net.WebClient
$client.DownloadFile("https://raw.githubusercontent.com/sysgain/iot-automation/master/scripts/SQLQuery2.sql","C:\test.sql")
sqlcmd.exe -S sqlvm -U sqluser -P Sysgain@1234 -i C:\test.sql -o "c:\Testoutput.txt"