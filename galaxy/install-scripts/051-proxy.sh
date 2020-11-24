read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

sudo certbot certonly \
  --preferred-challenges=dns \
  --rsa-key-size=4096 \
  --cert-name=$domain \
  --domains=$domain \
  --domains=*.$domain \
  --domains=*.dev.$domain \
  --manual \
  --agree-tos \
  --no-eff-email \
  --manual-public-ip-logging-ok

export DOMAIN=$domain
envsubst '${DOMAIN}' < /galaxy/a-galaxy-reborn/galaxy/conf-files/nginx/nginx.conf.template | sudo dd of=/etc/nginx/nginx.conf status=none
sudo systemctl restart nginx
