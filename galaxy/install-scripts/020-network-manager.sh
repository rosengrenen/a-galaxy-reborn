sudo apt install -y network-manager
sudo sed -i 's/version: 2/version: 2\n    renderer: NetworkManager/g' /etc/netplan/50-cloud-init.yaml
sudo netplan apply

sudo rm /usr/lib/NetworkManager/conf.d/10-dns-resolved.conf
sudo cp /galaxy/a-galaxy-reborn/galaxy/conf-files/NetworkManager/00-dns-dnsmasq.conf /usr/lib/NetworkManager/conf.d/
sudo cp /galaxy/a-galaxy-reborn/galaxy/conf-files/dnsmasq/00-nameservers.conf /etc/NetworkManager/dnsmasq.d/
sudo cp /galaxy/a-galaxy-reborn/galaxy/conf-files/dnsmasq/10-addn-hosts.conf /etc/NetworkManager/dnsmasq.d/
sudo cp /galaxy/a-galaxy-reborn/galaxy/conf-files/dnsmasq/hosts.dnsmasq /etc/
sudo systemctl restart NetworkManager
