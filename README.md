# galaxy

## Host

### Install operating system

Install ubuntu server 20.04, creating a `digit` user during installation steps.
Make sure to install OpenSSH server when prompted but don't install any additional software.

### Update repositories

```sh
sudo apt update
sudo apt upgrade -y
```

### Setup basic firewall

```sh
sudo ufw allow 22 # ssh
sudo ufw allow 80 # http
sudo ufw allow 443 # https
```

### Install NetworkManager

```sh
sudo apt install -y network-manager

# The following is needed for networks to be managed by NetworkManager, so that they can be managed in Cockpit
# See: https://github.com/cockpit-project/cockpit/issues/8477#issuecomment-630124971
# NOTE: if 50-cloud-init.yaml doesn't exist, put this in the 00-installer-config.yaml file instead
sudo sed -i 's/version: 2/version: 2\n    renderer: NetworkManager/g' /etc/netplan/50-cloud-init.yaml
sudo netplan apply
```

### Install libvirt

Libvirt is used to manage virtual machines and supports multiple backends, we'll use `kvm`.
For more information about this setup see https://linuxhint.com/libvirt_qemu_kvm_debian/.

```sh
sudo apt install -y libvirt-clients libvirt-daemon-system virtinst
sudo virsh net-start default
sudo virsh net-autostart default

# Install nameserver service for libvirt, so that vms can be accessed via their name,
# each vms needs to set their nameserver to the hosts nameserver if they also want to
# access the other vms by name
# See: https://libvirt.org/nss.html
sudo apt install -y libnss-libvirt
sudo sed -i 's/hosts.*/hosts:\t\tfiles libvirt libvirt_guest dns mymachines/g' /etc/nsswitch.conf
```

### Install cockpit

Cockpit is a server administration interface, where virtual machines and other things can be managed. The GUI is exposed on port 9090.

```sh
sudo apt install -y cockpit cockpit-machines
```

### Create virtual machines

#### Get ubuntu server image

```sh
wget https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso \
  -O /tmp/ubuntu-20.04-server-amd64.iso
```

#### Install

Two virtual machines will be installed, one kubernetes node and an http server. The setup is not automatic but the virtual machines can accessed through cockpit, a `digit` user should be created on them too.

> Memory, cpus and disk values need to be adjusted

```sh
sudo virt-install \
  --virt-type kvm \
  --name kubernetes-1 \
  --memory 4096 --vcpus=2 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=128 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole \
  --autostart

sudo virt-install \
  --virt-type kvm \
  --name http \
  --memory 1024 --vcpus=1 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=16 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole \
  --autostart
```

### Caddy

Caddy is a proxy server and will be used to SSH terminate web traffic to the kubernetes cluster. It will also be used to forward other tcp traffic for various services (OpenLDAP, MineCraft, IRC etc.). Caddy also manages SSL certificates automatically via letsencrypt.

```sh
sudo apt install caddy
# Copy conf-files/caddy/Caddyfile to /etc/caddy/Caddyfile
sudo systemctl restart caddy
```

## both vms

### Update repositories

```sh
sudo apt update
sudo apt upgrade -y
```

### Set nameserver

Set nameserver to libvirts host nameserver so that other vms can be reached by name

```sh
sudo rm /etc/resolv.conf
echo 'nameserver 192.168.122.1' | sudo dd of=/etc/resolv.conf status=none
```

## http vm

### Install nginx

```sh
sudo apt install nginx
```

## kubernetes vm

### Install docker

Instructions are extracted from https://docs.docker.com/engine/install/ubuntu/.

```sh
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker digit
```

### ssh trust

Add hosts pub key to .ssh/authorized_keys
