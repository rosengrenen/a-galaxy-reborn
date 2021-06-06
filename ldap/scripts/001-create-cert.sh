sudo certbot certonly \
  --email serverchef.digit@chalmers.it \
  --rsa-key-size=4096 \
  --cert-name=dantooine.chalmers.it \
  --domains=dantooine.chalmers.it \
  --standalone \
  --agree-tos \
  --no-eff-email
