#!/usr/bin/env bash
# Bash script that sets up web servers for the deployment of web_static
# Install Nginx if it not already installed
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# Create the folder /data/, /data/web_static/, /data/web_static/releases/, 
# /data/web_static/shared/, and /data/web_static/releases/test/ if it doest already exist
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Create a fake HTML file /data/web_static/releases/test/index.html
# (with simple content, to test your Nginx configuration)
sudo touch /data/web_static/releases/test/index.html
sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the
# /data/web_static/releases/test/ folder. If the symbolic link already exists,
# it should be deleted and recreated every time the script is ran.
sudo ln -s -f /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND
# group (you can assume this user and group exist)
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

# Restart Nginx after updating the configuration
sudo service nginx restart
