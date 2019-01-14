
######################################### Puppet CLIENT #########################################

#Stop resolvconf
sudo systemctl stop service.resolvconf

#Install Puppet agent
    curl -O https://apt.puppetlabs.com/puppet5-release-xenial.deb 
    sudo dpkg -i puppet5-release-xenial.deb
    sudo apt-get update
	sudo apt install -y puppet-agent
	
#IP + HOSTNAME dans /etc/hosts
echo "$(ip -o -4 a|sed -n 's#.*inet\s*\([^ ]*\)/.*brd.*$#\1#p') $(hostname)" >> /etc/hosts


#Puppet conf clients with echo
echo -e "[agent] \n default_schedules = false \n report = true \n pluginsync = true \n masterport = 8140 \n environment = production \n certname = $(hostname) \n server = $1 \n listen = false \n splay = false \n splaylimit = 1800 \n runinterval = 1800 \n noop = false \n usecacheonfailure = true" > /etc/puppetlabs/puppet/puppet.conf

#Run and Enable puppet-agent
sudo systemctl start puppet.service
sudo systemctl enable puppet.service