# manager

The manager server is the first server, and is only used to execute `ansible` scripts and manage the kubernetes cluster using `rke`.
All other servers are setup using `ansible`, but this one needs some manual setup.

## Setup

TODO...

Modify the following in the `cluster.yml`, see more [here](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/chart-options/#external-tls-termination)

```yml
ingress:
  provider: "nginx"
  options:
    use-forwarded-headers: "true"
```
