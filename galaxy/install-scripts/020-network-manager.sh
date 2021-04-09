# Install NetworkManager and configure for cockpit 
sudo apt install -y network-manager

# Needed for networks to be managed by NetworkManager, so that they can be managed in Cockpit
# See: https://github.com/cockpit-project/cockpit/issues/8477#issuecomment-630124971
# If 50-cloud-init.yaml doesn't exist, put this in the 00-...yaml file instead
sudo sed -i 's/version: 2/version: 2\n    renderer: NetworkManager/g' /etc/netplan/50-cloud-init.yaml
sudo netplan apply
