sudo certbot certonly \
  --email serverchef.digit@chalmers.it \
  --rsa-key-size=4096 \
  --cert-name=irc.chalmers.it \
  --domains=irc.chalmers.it \
  --standalone \
  --agree-tos \
  --no-eff-email
