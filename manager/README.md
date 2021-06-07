# manager

The manager server is the first server, and is only used to execute `ansible` scripts and manage the kubernetes cluster using `rke`.
All other servers are setup using `ansible`, but this one needs some manual setup.

## How to setup

### Installing packages

Run scripts `000`, `001`, `002`, and `010` from the `scripts` folder.

```sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/manager/scripts/000-update.sh | sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/manager/scripts/001-install-qemu-guest-agent.sh | sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/manager/scripts/002-install-ansible.sh | sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/manager/scripts/010-install-k8s-reqs.sh | sh
```

### Running ansible

Make sure all machines are up and running before running the following playbooks

```sh
ansible-playbook ./ansible/playbooks/ubuntu/copy-ssh.yml -i ./ansible/inventory/hosts -k
ansible-playbook ./ansible/playbooks/ubuntu/upgrade.yml -i ./ansible/inventory/hosts -K
ansible-playbook ./ansible/playbooks/ubuntu/qemu-guest-agent.yml -i ./ansible/inventory/hosts -K
ansible-playbook ./ansible/playbooks/docker/install-docker.yml -i ./ansible/inventory/hosts -K
```

### Creating the kubernetes cluster

Make sure that all machines are up and running before continuing.

First, create a new directory called `rke`, either on the home directory or under `/opt`, it doesn't really matter.

Then, run `rke config`, filling in the necessary field and choosing default on the rest. This command creates `cluster.yml`.

Modify the following in the `cluster.yml`, see more [here](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/chart-options/#external-tls-termination)

```yml
ingress:
  provider: "nginx"
  options:
    use-forwarded-headers: "true"
```

Run `rke up` to update the nodes. When complete the kubernetes cluster is fully functioning. If the command fails for whatever reason, just run it again.

### Installing rancher

`export KUBECONFIG=<rke folder path>/kube_config_cluster.yml`

To install rancher run the `011-install-rancher.sh` script.

```sh
curl https://raw.githubusercontent.com/rosengrenen/a-galaxy-reborn/master/manager/scripts/011-install-rancher.sh | sh
```
