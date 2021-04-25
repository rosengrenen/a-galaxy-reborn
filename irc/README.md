# irc

Server that hosts irc server.

## Building inspircd docker image with ldap

```sh
docker build --build-arg "CONFIGUREARGS=--enable-extras ldap" --build-arg "BUILD_DEPENDENCIES=openldap-dev" --build-arg "RUN_DEPENDENCIES=libldap" . -t cthit/inspircd:3.9.0
```

## Generating dhparam

```sh
openssl dhparam -out dhparams.pem 4096
```
