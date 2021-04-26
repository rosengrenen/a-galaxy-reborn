# proxy

A server that proxies and load balances connections. It is the main entry point for most applications.

## Info about setup

Runs a dockerized [caddy](https://caddyserver.com/) as an ssl terminating proxy server and a couple of simple port forwarding containers. It exposes http (80), https (443), and some other ports as needed for port forwarding (to ldap and irc).

## How to setup

### Build docker image

docker buildx build -t cthit/caddy-cloudflare:2.3.0 --push --platform linux/amd64,linux/arm64 .

### Starting proxy

Copy `config` to a good location on the host, such as `~/proxy` or `/opt/proxy`. Folder can be copied with `scp` from your local computer.

In the `proxy` directory copy `.env.example` to `.env` and fill in the values.

Run `docker-compose up -d` to start the services.
