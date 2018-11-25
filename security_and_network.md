File/Host network manager
add one
IPv4 Address 192.168.57.1
IPv4 Network Mask 255.255.255.252
enable server unchecked

settings
network
adapter 1 Host-only select the one we just added in Name
adapter 2 Nat cable connected

/etc/network/interfaces
auto enp0s3
iface enp0s3 inet static
address 192.168.57.2
netmask 255.255.255.252
network 192.168.57.0
broadcast 192.168.57.3
dns-nameservers 8.8.8.8

wired connected
server 8.8.8.8

# create a non root user
sudo useradd username
# install sudo
su - 
apt-get install sudo -y
# add sudo right to a user
adduser username sudo

http://coding4streetcred.com/blog/post/VirtualBox-Configuring-Static-IPs-for-VMs

# set a static IP
https://www.itzgeek.com/how-tos/linux/debian/how-to-configure-static-ip-address-in-ubuntu-debian.html

# desactivate DHCP
https://www.aelius.com/njh/subnet_sheet.html

# ssh
/etc/init.d/ssh start
broadcast adapter in virtualbox

# with publickeys https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
ssh-keygen -t rsa
ssh-copy-id demo@198.51.100.0

# change ssh port
in root: vi /etc/ssh/sshd_config
supprimer le # # Port 22 et modifier le 22 pour mettre le port desire
puis: service sshd restart
https://adayinthelifeof.nl/2012/03/12/why-putting-ssh-on-another-port-than-22-is-bad-idea/
ssh leo@ip -p 42

# firewall configuration https://wiki.debian.org/iptables
sudo iptables -L //show configuration (default configuration with no filtering)

create a file /etc/iptables.test.rules
*filter

:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT DROP [0:0]


-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# http, https
-A INPUT -p tcp --dport 80 -j ACCEPT
-A OUTPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 443 -j ACCEPT
-A OUTPUT -p tcp --dport 443 -j ACCEPT
#-A INPUT -p udp --dport 53 -j ACCEPT
-A OUTPUT -p udp --dport 53 -j ACCEPT

# ssh
-A INPUT -p tcp -m state --state NEW --dport 42 -j ACCEPT
#-A OUTPUT -p tcp -m state --state NEW --dport 42 -j ACCEPT

COMMIT

iptables-restore < /etc/iptables.test.rules
Once you are happy with your ruleset, save the new rules to the master iptables file:
 iptables-save > /etc/iptables.test.rules
To make sure the iptables rules are started on a reboot we'll create a new file:
 editor /etc/network/if-pre-up.d/iptables
Add these lines to it:
 #!/bin/sh
 /sbin/iptables-restore < /etc/iptables.test.rules
The file needs to be executable so change the permissions:


 chmod +x /etc/network/if-pre-up.d/iptables
#protect from DOS attack
https://sharadchhetri.com/2013/06/15/how-to-protect-from-port-scanning-and-smurf-attack-in-linux-server-by-iptables/


# list of service started
sudo service --status-all

# script
#!/bin/sh
sudo apt-get update >> /var/log/update_script.log

vim /etc/crontab
@reboot         root   	sh /root/update.sh
0  4    * * 1   root   	sh /root/update.sh


#!/bin/sh
MD5FILE=/home/leo/md5test
FILE_TO_CHECK=/home/leo/test

if [ ! -f $FILE_TO_CHECK ]
then
	echo "ERROR Couldnt locate file to check:$FILE_TO_CHECK"
	exit 1
fi

echo "Taking a print on $FILE_TO_CHECK with md5sum"
MD5PRINT=`md5sum $FILE_TO_CHECK | cut -d " " -f1`

echo "MD5: $MD5PRINT, $FILE_TO_CHECK"

if [ -z $MD5PRINT ]
then
	echo "ERROR Recived an empty MD5PRINT thats not valid, aborting"
	exit 1
else
	echo "MD5PRINT we got was:$MD5PRINT"
fi

if [ -f $MD5FILE ]
then
	echo "Found an old savefile:$MD5FILE we trying to match prints"
	OLDMD5PRINT=`cat $MD5FILE`

	if [ -z $OLDMD5PRINT ]
	then
		echo "Got an empty string from the oldfile, aborting"
		exit 1
	fi

	if [ "$OLDMD5PRINT" = "$MD5PRINT" ]
			then
				echo "New and old md5print are identical, the file hasnt been changed"
			else
				echo "WARNING the old and new md5print doesnt match, the file has been changed"
			fi


		echo "Saving to new md5print in logfile:$MD5FILE for later checks"
		echo $MD5PRINT > $MD5FILE

		if [ $? = 0 ]
		then
			echo "Wrote to file OK"
		else
			echo "Writing to file failed...why??"
			exit 1
		fi
	fi






CLEANED FILE
#!/bin/sh
MD5FILE=/root/.md5cron
FILE_TO_CHECK=/etc/crontab

MD5PRINT=`md5sum $FILE_TO_CHECK | cut -d " " -f1`
if [ -f $MD5FILE ]
then
	OLDMD5PRINT=`cat $MD5FILE`
	if [ "$OLDMD5PRINT" != "$MD5PRINT" ]
	then
		echo "The cron file has been changed" | mail -s "the file has been changed" root
	fi
	echo $MD5PRINT > $MD5FILE
fi


SEND AN EMAIL TO ROOT
apt-get update mailutils
echo "Test" | mail -s "Test " root


# SIGNED CERTIFICATE https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-debian-9
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt


Output
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:New York
Locality Name (eg, city) []:New York City
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Bouncy Castles, Inc.
Organizational Unit Name (eg, section) []:Ministry of Water Slides
Common Name (e.g. server FQDN or YOUR name) []:server_IP_address
Email Address []:admin@your_domain.com