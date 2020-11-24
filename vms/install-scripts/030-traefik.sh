read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

cd /galaxy/a-galaxy-reborn/vms/conf-files/traefik
export DOMAIN=$domain
export TRAEFIK_STORAGE_PATH=/data/traefik
sudo docker-compose up -d
