First, copy `.env.example` to `.env` and fill in appropriate values

On first launch run

```
docker-compose -d docker-compose.init.yml
```

to generate the ssl certificates, otherwise nginx will not start.

Then start the services

```
docker-compose up -d
```
