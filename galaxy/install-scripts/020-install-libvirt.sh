sudo apt install -y libvirt-clients libvirt-daemon-system virtinst
sudo usermod -aG libvirt rosen
sudo usermod -aG libvirt-qemu rosen
virsh net-start default
virsh net-autostart default
exit
