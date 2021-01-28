#!/bin/bash

# Install Apache and PHP
sudo apt-get update

sleep 15

sudo apt-get -y install apache2

# Enable Apache and start it
sudo systemctl enable apache2

sudo systemctl start apache2

# Adjust Firewall
sudo ufw allow in "Apache Full"

# Update permissions for
sudo chmod -R 0755 /var/www/html/

# Install PHP
sudo apt install php libapache2-mod-php php-mysql -y
sudo sed -i "s/DirectoryIndex.*;/DirectoryIndex index.php index.html;/" /etc/apache2/mods-enabled/dir.conf

#Update Prefork


# Install MySQL
sudo apt install mysql-server -y
sudo mysql SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password'); FLUSH PRIVILEGES;
sudo mysql -uroot -ppassword -e "CREATE DATABASE authors;"
wget -O /opt/authors.sql https://github.com/kendubu1/apache2/raw/main/authors.sql
sudo mysql -uroot -ppassword authors < /opt/authors.sql