sh script that sets up web servers for the deployment of web_static
# Install Nginx if it not already installed
apt update -y
apt install -y nginx

# Create the folder /data/, /data/web_static/, /data/web_static/releases/, 
# /data/web_static/shared/, and /data/web_static/releases/test/ if it doest already exist
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

# Create a fake HTML file /data/web_static/releases/test/index.html
# (with simple content, to test your Nginx configuration)
echo "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Holberton School</p>
  </body>
</html>" | tee /data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the
# /data/web_static/releases/test/ folder. If the symbolic link already exists,
# it should be deleted and recreated every time the script is ran.
ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND
# group (you can assume this user and group exist)
chown -R ubuntu:ubuntu /data

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
sudo sed -i '39 i\ \tlocation /hbnb_static {\n\t\talias /data/web_static/current;\n\t}\n' /etc/nginx/sites-enabled/default

# Restart Nginx after updating the configuration
sudo service nginx restart
