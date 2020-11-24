read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

cd /galaxy/a-galaxy-reborn/vms/conf-files/traefik
export DOMAIN=$domain
export TRAEFIK_STORAGE_PATH=/data/traefik

sudo docker stop traefik
sudo docker rm traefik
sudo docker run \
  --name traefik \
  --network traefik \
  --publish 80:80 \
  --restart unless-stopped \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume "$TRAEFIK_STORAGE_PATH/logs:/var/log" \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.forward-to-http.rule=hostregexp(`{host:.+}`)" \
  --label "traefik.http.routers.forward-to-http.entrypoints=http" \
  --label "traefik.http.routers.forward-to-http.service=forward-to-http" \
  --label "traefik.http.routers.api.rule=Host(`traefik.$DOMAIN`)" \
  --label "traefik.http.routers.api.service=api@internal" \
  --label "traefik.http.routers.api.entryPoints=http" \
  --label "traefik.http.services.forward-to-http.loadbalancer.server.url=http" \
  traefik:v2.3.3 \
  --api.insecure=false \
  --api.dashboard=true \
  --log.level=INFO \
  --log.filepath=/var/log/traefik.log \
  --log.format=json \
  --accesslog=true \
  --accesslog.filepath=/var/log/access.log \
  --accesslog.bufferingsize=100 \
  --accesslog.format=json \
  --accesslog.fields.defaultmode=keep \
  --accesslog.fields.headers.defaultmode=keep \
  --accesslog.fields.headers.names.Authorization=drop \
  --providers.docker=true \
  --providers.docker.exposedByDefault=false \
  --providers.docker.network=traefik \
  --entrypoints.http.address=:80

      # - traefik.http.services.api.loadbalancer.server.port=8080
