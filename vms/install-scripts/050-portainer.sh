# Creates a portainer container, a docker web gui

sudo docker stop portainer
sudo docker rm portainer

sudo docker volume create portainer-data
sudo docker run \
  --name portainer \
  --detach \
  --restart unless-stopped \
  --publish 80:9000 \
  --volume portainer-data:/data \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  portainer/portainer-ce:2.0.0
