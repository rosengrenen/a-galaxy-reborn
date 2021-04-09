# Setup firewall accordingly
# The most basic setup is to allow only ssh, http, and https
# Open more ports as needed
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
