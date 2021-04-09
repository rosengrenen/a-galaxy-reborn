# Creates a catch-all traefik rule that forwards traffic to the http vm using nginx

sudo docker stop nginx-traefik-catchall-to-http
sudo docker rm nginx-traefik-catchall-to-http
sudo docker run \
  --name nginx-traefik-catchall-to-http \
  --network traefik \
  --restart unless-stopped \
  --detach \
  --volume /galaxy/a-galaxy-reborn/vms/conf-files/nginx/nginx.conf:/etc/nginx/nginx.conf \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.forward-to-http.rule=hostregexp(\`{host:.+}\`)" \
  --label "traefik.http.routers.forward-to-http.entrypoints=http" \
  --label "traefik.http.routers.forward-to-http.priority=1" \
  nginx:1.19.0
