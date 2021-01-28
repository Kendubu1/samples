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
sudo chmod -R 0755 /var/www/html/
cd /var/www/html/
sudo git clone https://github.com/Kendubu1/commtest.git .

sleep 15

# Install MySQL & DB
sudo apt install mysql-server -y
sudo mysql ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;
sudo mysql -uroot -ppassword -e "CREATE DATABASE authors;"
wget -O /opt/authors.sql https://raw.githubusercontent.com/Kendubu1/samples/main/apache2/authors.sql
sudo mysql -uroot -ppassword authors < /opt/authors.sql

sleep 15

# Install PHP
sudo apt install php libapache2-mod-php php-mysql -y
sudo sed -i "s/DirectoryIndex.*/DirectoryIndex index.php index.html/" /etc/apache2/mods-enabled/dir.conf

#Update Update/disable Prefork
