echo "
# proxmox repositories for non-subscribers, can be unstable
deb http://download.proxmox.com/debian buster pve-no-subscription
" > /etc/apt/sources.list

sed -i 's/^deb/# deb/' /etc/apt/sources.list.d/pve-enterprise.list
