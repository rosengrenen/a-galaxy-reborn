# Install xcaddy (https://github.com/caddyserver/xcaddy)
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key' | sudo apt-key add -
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-xcaddy.list
sudo apt update
sudo apt install xcaddy

# build caddy
sudo snap install go --classic
sudo xcaddy build --with github.com/caddy-dns/cloudflare --output /usr/bin/caddy

# account and service setup
sudo groupadd --system caddy
sudo useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy
sudo wget https://raw.githubusercontent.com/caddyserver/dist/master/init/caddy.service \
  -O /etc/systemd/system/caddy.service
sudo systemctl daemon-reload
sudo systemctl enable --now caddy
