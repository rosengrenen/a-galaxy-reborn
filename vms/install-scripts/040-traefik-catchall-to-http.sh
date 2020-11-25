sudo docker stop nginx-traefik-catchall-to-http
sudo docker rm nginx-traefik-catchall-to-http
sudo docker run \
  --name nginx-traefik-catchall-to-http \
  --network traefik \
  --restart unless-stopped \
  --detach \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.forward-to-http.rule=hostregexp(\`{host:.+}\`)" \
  --label "traefik.http.routers.forward-to-http.entrypoints=http" \
  --label "traefik.http.routers.forward-to-http.priority=1" \
  nginx:1.19.0
sudo docker cp \
  /galaxy/a-galaxy-reborn/vms/config-files/nginx/nginx.conf:/etc/nginx/nginx.conf \
  nginx-traefik-catchall-to-http:/etc/nginx/nginx.conf
sudo docker restart nginx-traefik-catchall-to-http

