#!bin/sh
#Install Nginx

echo "### Installing Nginx ###"
sudo apt install nginx -y
systemctl status nginx

echo "##### Installing NodeJS and Yarn #####" 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Installing dependencies
sudo apt-get update 
# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
sudo apt-get install -y nodejs 

# Installing yarn
sudo apt install yarn -y

# Install PM2
sudo npm install pm2 -y

#Install/Start Application
export PORT=3000
cd /home/
sudo git clone https://github.com/Kendubu1/covid-19-demo-express-js-app.git
cd covid-19-demo-express-js-app/
sudo npm install 
npm start

## INSTALL W/ PM2

# Configure Nginx 
export PUBLIC_IP=$(curl -s http://checkip.amazonaws.com || printf "0.0.0.0")
echo "Stopping any running instances of NGINX"
sudo sed -i "s/worker_processes.*;/worker_processes 1;/" /etc/nginx/nginx.conf
sudo sed -i "s/worker_connections.*;/worker_connections 3;/" /etc/nginx/nginx.conf
sudo sh -c "printf '%s\n' '' \
    'server {' \
    '    listen 80;' \
    '    listen [::]:80;' \
    '    server_name ${PUBLIC_IP};' \
    'location / {' \
    '    proxy_pass http://localhost:3000/;' \
    '     }' \
    '     }' \  
    '' > test.txt"
sudo nginx -s reload