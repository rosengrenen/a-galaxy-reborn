sudo apt install -y libvirt-clients libvirt-daemon-system virtinst
sudo virsh net-start default
sudo virsh net-autostart default

sudo apt install -y libnss-libvirt
sudo sed -i 's/hosts.*/hosts:\t\tfiles libvirt libvirt_guest dns mymachines/g' /etc/nsswitch.conf
