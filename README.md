# galaxy

## Host

### Install operating system

Install Proxmox Virtual Environment

### Fix repositories for no subscription

Add `deb http://download.proxmox.com/debian buster pve-no-subscription` to `/etc/apt/sources.list`.

Comment out the first and only line in `/etc/apt/sources.list.d/pve-enterprise.list`.

### Upgrade

```sh
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
```

### Create virtual machines

Install them through the proxmox interface which is available on port 8006.

List of virtual machines to probably install:

- Kubernetes node(s)
- Http server, running nginx or caddy
- Proxy server, running nginx or caddy, the entry point

### Spin up k8s cluster

Run `000-rke-reqs.sh` on the host.

#### Configure rke

Execute the following commands in `~/.rke`.

```sh
/opt/rke/rke config
```

Modify the following in the `cluster.yml`, see more [here](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/chart-options/#external-tls-termination)

```yml
ingress:
  provider: "nginx"
  options:
    use-forwarded-headers: "true"
```

Run `/opt/rke/rke up` to launch the cluster.

Run `export KUBECONFIG=~/.rke/kube_config_cluster.yml`.

Run `001-install-rancher.sh` on the host.

### Configuring rancher

Create 5 new projects in Rancher:

- `Storage`
- `digit-secret`
- `digit-core`
- `digit`
- `digit-dev`

In the `Storage` project create a `Longhorn` app with default replicas set to number of kubernetes nodes, capped at 3.
