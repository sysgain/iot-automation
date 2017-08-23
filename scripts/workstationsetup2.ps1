param(
[string] $adminUsername = "$1",
[string] $adminPassword = "$2",
[string] $ChefServerFqdn = "$3",
[string] $organizationName= "$4",
[string] $PIAFSQLIP= "$5",
[string] $PIBAIP= "$6",
[string] $bastionFQDN= "$7",
[string] $workstationFQDN= "$8",
[string] $splunkIP= "$9"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
cd C:\opscode\chefdk\bin
chef generate app c:\Users\chef-repo
echo c:\Users\chef-repo\.chef\knife.rb | knife configure --server-url https://$ChefServerFqdn/organizations/$organizationName --validation-client-name $organizationName-validator --validation-key c:/Users/chef-repo/.chef/$organizationName-validator.pem --user $adminUsername --repository c:/Users/chef-repo
echo n | & "C:\Program Files\PuTTY\pscp.exe" -scp -pw $adminPassword ${adminUsername}@${ChefServerFqdn}:/etc/opscode/$adminUsername".pem" C:\Users\chef-repo\.chef\$adminUsername".pem"
echo n | & "C:\Program Files\PuTTY\pscp.exe" -scp -pw $adminPassword ${adminUsername}@${ChefServerFqdn}:/etc/opscode/$organizationName-validator.pem C:\Users\chef-repo\.chef\$organizationName-validator.pem
knife ssl  fetch --config c:\Users\chef-repo\.chef\knife.rb  --server-url https://$ChefServerFqdn/organizations/$organizationName
git clone https://github.com/sysgain/IOT-ChefCookbooks.git C:/Users/cookbookstore
cp -r C:\Users\cookbookstore\* C:\Users\chef-repo\cookbooks
(Get-Content C:\Users\chef-repo\cookbooks\splunk-uf-install/recipes/default.rb) ` | %{ $_ -replace 'localhost',$splunkIP} ` | Set-Content C:\Users\chef-repo\cookbooks\splunk-uf-install/recipes/default.rb
knife cookbook upload --config c:\Users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ splunk-uf-install DynatraceOneAgent compat_resource audit ohai windows
knife cookbook upload --config c:\Users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ yum-epel dmg seven_zip mingw build-essential  git
knife bootstrap windows winrm localhost --config c:\Users\chef-repo\.chef\knife.rb -x $adminUsername  -P $adminPassword -N $workstationFQDN 
knife bootstrap windows winrm  $PIAFSQLIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminUsername  -P $adminPassword -N $PIAFSQLIP
knife bootstrap windows winrm  $PIBAIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminUsername  -P $adminPassword -N $PIBAIP
knife bootstrap windows winrm  $bastionFQDN --config c:\Users\chef-repo\.chef\knife.rb -x $adminUsername  -P $adminPassword -N $bastionFQDN
knife bootstrap $splunkIP --sudo -x $adminUsername -P $adminPassword -N $splunkIP
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $workstationFQDN recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIAFSQLIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIAFSQLIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIBAIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIBAIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $bastionFQDN recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $bastionFQDN recipe[audit]
knife node run_list add --server-url https://$ChefServerFqdn/organizations/$organizationName/ $splunkIP recipe[splunk-uf-install]
knife node run_list add --server-url https://$ChefServerFqdn/organizations/$organizationName/ $splunkIP recipe[audit]
chef-client
knife winrm name:$PIAFSQLIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$PIBAIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$bastionFQDN -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife ssh name:$splunkIP -a ipaddress -x ${adminUsername} -P $adminPassword sudo chef-client 