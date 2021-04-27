# http

A server that servers simple web applications that are not yet dockerized.

## Info about setup

Runs a dockerized [caddy](https://caddyserver.com/) server. It exposes only http (80).

## How to setup

Copy `config` to a good location on the host, such as `~/http` or `/opt/http`. Folder can be copied with `scp` from your local computer.

Run `docker-compose up -d` to start the services.
