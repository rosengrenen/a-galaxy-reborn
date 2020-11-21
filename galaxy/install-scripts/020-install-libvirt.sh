sudo apt install -y libvirt-clients libvirt-daemon-system virtinst
sudo usermod -aG libvirt rosen
sudo usermod -aG libvirt-qemu rosen
sudo virsh net-start default
sudo virsh net-autostart default
