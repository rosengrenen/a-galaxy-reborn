read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

sudo certbot certonly
  --preferred-challenges=dns
  --rsa-key-size=4096
  --cert-name=$domain
  --domains=cockit.$domain
  --domains=*.h.$domain
  --manual
  --force-renewal
  --agree-tos
  --no-eff-email
  --manual-public-ip-logging-ok

DOMAIN=$domain sudo envsubst '${DOMAIN}' < /galaxy/a-galaxy-reborn/galaxy/conf-files/nginx/nginx.conf.template > /etc/nginx/nginx.conf
sudo systemctl restart nginx
