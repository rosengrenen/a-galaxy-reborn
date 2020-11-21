sudo cp ../files/daemon.json /etc/docker/daemon.json
sudo mkdir /etc/systemd/system/docker.service.d
sudo cp ../files/override.conf /etc/systemd/system/docker.service.d/override.conf
sudo systemctl restart docker
