# Solution to not being able to use environment variables in nginx config
# Uses a template file
envsubst '${DOMAIN}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Basically, reload config every 6 hours to load new ssl certificates
while :; do sleep 6h; nginx -s reload; done & exec nginx -g "daemon off;"
