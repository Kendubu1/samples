#!bin/sh

echo "#Startlogging"
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>scriptlog.out 2>&1

echo "#Install Apache"
sudo apt-get update

sleep 15

sudo apt-get -y install apache2

echo "#Enable Apache"
#sudo systemctl enable apache2
#sudo systemctl start apache2

echo "#Adjust Firewall"
sudo ufw allow in "Apache Full"

echo "#Update permissions & install app"
sudo chmod -R 0755 /var/www/html/
cd /var/www/html/
sudo git clone https://github.com/Kendubu1/commtest.git

# Install PHP
sudo apt install php libapache2-mod-php php-mysql -y
sudo sed -i "s/DirectoryIndex.*/DirectoryIndex index.php index.html/" /etc/apache2/mods-enabled/dir.conf

#Update Prefork


# Install MySQL & DB
sudo apt install mysql-server -y
sudo mysql SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password'); FLUSH PRIVILEGES;
sudo mysql -uroot -ppassword -e "CREATE DATABASE authors;"
wget -O /opt/authors.sql https://github.com/kendubu1/apache2/raw/main/authors.sql
sudo mysql -uroot -ppassword authors < /opt/authors.sql