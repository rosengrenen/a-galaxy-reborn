cd /galaxy/a-galaxy-reborn/galaxy
docker-compose -f docker-compose.init.yml run certbot
docker-compose up -d
