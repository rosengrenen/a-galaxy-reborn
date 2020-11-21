# Instruction to install VMS

portainer: only runs portainer, which is directly accessible from galaxy proxy

prod+dev: runs a traefik proxy to route http traffic, all other ports pass directly to exposing containers

http: runs a dockerized nginx proxy in host mode, that takes care of configurations for each site, does not manage SSL certificates, since galaxy proxy SSL terminates all traffic do this VM
