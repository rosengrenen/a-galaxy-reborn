# ldap

Server that hosts an OpenLDAP server.

## Info about setup

Runs OpenLDAP and phpldapadmin in docker containers. It exposes secure ldap on port 636 and unsecure phpldapadmin on port 8080.

## How to setup

### Installing packages and certificate

Run all the scripts in the `scripts` folder.

```sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/ldap/scripts/000-install-certbot.sh | sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/ldap/scripts/001-create-cert.sh | sh
```

### Starting ldap

Copy `config/ldap` to a good location on the host, such as `~/ldap` or `/opt/ldap`. Folder can be copied with `scp` from your local computer.

In the `ldap` directory copy `.env.example` to `.env` and fill in the values.

Run `docker-compose up -d` to start the services.

### Migrating data from old ldap

See the README of the `ldap-migrator-tool`
