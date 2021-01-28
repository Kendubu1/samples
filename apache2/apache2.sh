#!bin/sh

#Startlogging"
# exec 3>&1 4>&2
# trap 'exec 2>&4 1>&3' 0 1 2 3
# exec 1>scriptlog.out 2>&1

#Install Apache"
sudo apt-get update

sleep 15

sudo apt-get install apache2 -y

sleep 15

#Enable Apache"
#sudo systemctl enable apache2
#sudo systemctl start apache2

#Adjust Firewall"
sudo ufw allow in "Apache Full"

#Update permissions & install app
sudo rm -rf /var/www/html/
sudo mkdir /var/www/html/
sudo cd /var/www/html/ 
sudo git clone https://github.com/Kendubu1/commtest.git .
sudo chmod -R 0755 /var/www/html/

sleep 15

# Install MySQL & DB
sudo apt install mysql-server -y
sudo mysql ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;
sudo mysql -uroot -ppassword -e "CREATE DATABASE authors;"
wget -O /opt/authors.sql https://raw.githubusercontent.com/Kendubu1/samples/main/apache2/authors.sql
sudo mysql -uroot -ppassword authors < /opt/authors.sql

sleep 15

# Install PHP & Update Index
sudo apt install php libapache2-mod-php php-mysql -y
sudo sed -i "s/DirectoryIndex.*/DirectoryIndex index.php index.html/" /etc/apache2/mods-enabled/dir.conf

#Update Update/disable Prefork
# sudo a2dismod php7.2
# sudo a2dismod mpm_prefork
# sudo a2dismod mpm_worker
# sudo a2enmod php7.2

# #note:have sed skip first occurrance 
# sudo sed -i "s/StartServers.*/StartServers 1/" /etc/apache2/mods-available/mpm_prefork.conf 
# sudo sed -i "s/MinSpareServers.*/MinSpareServers 1/" /etc/apache2/mods-available/mpm_prefork.conf
# sudo sed -i "s/MaxSpareServers.*/MaxSpareServers 1/" /etc/apache2/mods-available/mpm_prefork.conf
# sudo sed -i "s/MaxRequestWorkers.*/MaxRequestWorkers 1/" /etc/apache2/mods-available/mpm_prefork.conf
# sudo sed -i "s/MaxConnectionsPerChild.*/MaxConnectionsPerChild 1/" /etc/apache2/mods-available/mpm_prefork.conf

# sudo sed -i "s/StartServers.*/StartServers 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/MinSpareThreads.*/MinSpareThreads 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/MaxSpareThreads.*/MaxSpareThreads 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/ThreadLimit.*/ThreadLimit 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/ThreadsPerChild.*/ThreadsPerChild 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/MaxRequestWorkers.*/MaxRequestWorkers 1/" /etc/apache2/mods-available/mpm_worker.conf
# sudo sed -i "s/MaxConnectionsPerChild.*/MaxConnectionsPerChild 1/" /etc/apache2/mods-available/mpm_worker.conf

# sudo systemctl restart apache2