#! /bin/bash
sudo apt-get update
sudo apt-get -y install httpd4
sudo service nginx stop
sudo apt-get -y install git
sudo git clone https://github.com/Wilkins089/urban-site.git /var/www/urban-site
sudo mv /var/www/urban-site/nginx.conf /etc/nginx/sites-available/
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/default
sudo service nginx restart
