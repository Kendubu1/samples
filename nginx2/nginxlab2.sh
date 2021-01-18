#!bin/sh

echo "#Startlogging"
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>scriptlog.out 2>&1

echo "#Install Nginx"
sudo apt-get update 
sudo apt install nginx -y
systemctl status nginx

echo "#Download Static Content"
sudo mkdir /var/www/azure
cd /var/www/azure
sudo wget https://raw.githubusercontent.com/Kendubu1/nginx-static-docker-vnet/master/index.html
