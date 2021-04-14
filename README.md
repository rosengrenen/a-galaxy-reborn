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

### Setup machines

Install pip and ansible

```sh
sudo apt install python3-pip
pip3 install ansible
```

This usually installs it into `~/.local/bin`, so add that to the path with `export PATH=$HOME/.local/bin:$PATH`

Add/remove hosts in `ansible/inventory/hosts` as needed. Then run the following playbooks:

```sh
# Copy public key to hosts
ansible-playbook ./ansible/playbooks/copy-ssh.yml  -i ./ansible/inventory/hosts -k

# Upgrade systems
ansible-playbook ./ansible/playbooks/upgrade.yml  -i ./ansible/inventory/hosts -K

# Install qemu guest agent so that proxmox can get more info about vms
ansible-playbook ./ansible/playbooks/qemu-guest-agent.yml  -i ./ansible/inventory/hosts -K

# Install docker on machines in the docker hosts groups
ansible-playbook ./ansible/playbooks/install-docker.yml  -i ./ansible/inventory/hosts -K
```

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
