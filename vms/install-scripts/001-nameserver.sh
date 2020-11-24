sudo rm /etc/resolv.conf
echo 'nameserver 192.168.122.1' | sudo dd of=/etc/resolv.conf status=none
