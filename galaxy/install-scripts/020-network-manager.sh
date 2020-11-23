sudo apt install -y network-manager
sudo sed -i 's/version: 2/version: 2\n    renderer: NetworkManager/g' /etc/netplan/50-cloud-init.yaml
sudo netplan apply
