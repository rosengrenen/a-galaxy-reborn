read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

# Creates a traefik docker container. Traefik is a proxy server
# that is configured using labels, so there is no central configuration
# for routes
#
# The current configuration does not any authentication for the dashboard,
# it should probably be turned off, or authentication could be implemented
# using ForwardAuth (https://doc.traefik.io/traefik/middlewares/forwardauth/)
# by creating a custom service that connects to gamma (using authorities) or ldap
#
# Docs: https://doc.traefik.io/traefik/

export DOMAIN=$domain
# TODO: create a docker volume instead
export TRAEFIK_STORAGE_PATH=/data/traefik

sudo docker network create traefik

sudo docker stop traefik
sudo docker rm traefik
sudo docker run \
  --name traefik \
  --network traefik \
  --publish 80:80 \
  --restart unless-stopped \
  --detach \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume "$TRAEFIK_STORAGE_PATH/logs:/var/log" \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.api.rule=Host(\`traefik.$DOMAIN\`)" \
  --label "traefik.http.routers.api.service=api@internal" \
  --label "traefik.http.routers.api.entryPoints=http" \
  traefik:v2.4.8 \
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
