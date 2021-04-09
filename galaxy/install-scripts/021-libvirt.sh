# Install libvirt, which is used to manage virtual machines for multiple backends
# In this installation "kvm" will be used as the backend
# See: https://linuxhint.com/libvirt_qemu_kvm_debian/
sudo apt install -y libvirt-clients libvirt-daemon-system virtinst
sudo virsh net-start default
sudo virsh net-autostart default

# Install nameserver service for libvirt, so that vms can be accessed via their name,
# each vms needs to set their nameserver to the roots nameserver if they also want to
# access the other vms by name
# See: https://libvirt.org/nss.html
sudo apt install -y libnss-libvirt
sudo sed -i 's/hosts.*/hosts:\t\tfiles libvirt libvirt_guest dns mymachines/g' /etc/nsswitch.conf
