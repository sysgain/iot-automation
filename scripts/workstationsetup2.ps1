param(
[string] $adminusername = "$1",
[string] $adminPassword = "$2",
[string] $ChefServerFqdn = "$3",
[string] $organizationName= "$4",
[string] $PIAFSQLIP= "$5",
[string] $PIDAIP= "$6",
[string] $PIBAIP= "$7",
[string] $adIP= "$8",
[string] $bastionFQDN= "$9",
[string] $workstationFQDN= "$10"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
cd C:\opscode\chefdk\bin
chef generate app c:\Users\chef-repo
echo c:\Users\chef-repo\.chef\knife.rb | knife configure --server-url https://$chefServerfqdn/organizations/$organizationName --validation-client-name $organizationName-validator --validation-key c:/Users/chef-repo/.chef/$organizationName-validator.pem --user $adminUsername --repository c:/Users/chef-repo
echo n | & "C:\Program Files\PuTTY\pscp.exe"  -scp -pw $adminPassword ${adminUsername}@${chefServerfqdn}:/etc/opscode/$adminUsername".pem" C:\Users\chef-repo\.chef\$adminUsername".pem"
echo n | & "C:\Program Files\PuTTY\pscp.exe"  -scp -pw $adminPassword ${adminUsername}@${chefServerfqdn}:/etc/opscode/$organizationName-validator.pem C:\Users\chef-repo\.chef\$organizationName-validator.pem
knife ssl  fetch --config c:\Users\chef-repo\.chef\knife.rb  --server-url https://$chefServerfqdn/organizations/$organizationName
git clone https://github.com/sysgain/IOT-ChefCookbooks.git C:/Users/cookbookstore
cp -r C:\Users\cookbookstore\* C:\Users\chef-repo\cookbooks
knife cookbook upload --config c:\Users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ splunk-uf-install DynatraceOneAgent compat_resource audit ohai windows
knife cookbook upload --config c:\Users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ yum-epel dmg seven_zip mingw build-essential  git
knife bootstrap windows winrm localhost --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $workstationFQDN 
knife bootstrap windows winrm  $PIAFSQLIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $PIAFSQLIP
knife bootstrap windows winrm  $PIDAIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $PIDAIP
knife bootstrap windows winrm  $PIBAIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $PIBAIP
knife bootstrap windows winrm  $adIP --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $adIP
knife bootstrap windows winrm  $bastionFQDN --config c:\Users\chef-repo\.chef\knife.rb -x $adminusername  -P $adminPassword -N $bastionFQDN
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $workstationFQDN recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIAFSQLIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIAFSQLIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIDAIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIDAIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIBAIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $PIBAIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $adIP recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $adIP recipe[audit]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $bastionFQDN recipe[git]
knife node run_list add --config c:\users\chef-repo\.chef\knife.rb --server-url https://$ChefServerFqdn/organizations/$organizationName/ $bastionFQDN recipe[audit]
chef-client
knife winrm name:$PIAFSQLIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$PIDAIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$PIBAIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$adIP -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client
knife winrm name:$bastionFQDN -a ipaddress -x ${adminUsername}  -P $adminPassword --config c:\users\chef-repo\.chef\knife.rb chef-client