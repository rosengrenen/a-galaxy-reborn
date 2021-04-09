read -p 'Domain (chalmers.it): ' domain
if [ -z $domain ]; then
  domain="chalmers.it"
fi

# Create certificate, add more --domains if needed
# DNS challenge is used for wildcard domains, which means that
# a DNS record will be needed for verification
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

# Create nginx config from template, this can be done manually
# TODO: tcp/udp port forwarding to vms
export DOMAIN=$domain
envsubst '${DOMAIN}' < /galaxy/a-galaxy-reborn/galaxy/conf-files/nginx/nginx.conf.template | sudo dd of=/etc/nginx/nginx.conf status=none
sudo systemctl restart nginx
