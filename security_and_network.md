# create a non root user
sudo useradd -m username
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

# firewall configuration https://www.geek17.com/fr/content/debian-9-stretch-securiser-votre-serveur-avec-le-firewall-iptables-32
sudo iptables -L //default configuration wth no filtering
sudo apt-get install iptables-persistent // to save config after reboot