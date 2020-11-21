wget https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso \
  -O /tmp/ubuntu-20.04-server-amd64.iso

sudo virt-install \
  --virt-type kvm \
  --name portainer \
  --memory 1024 --vcpus=1 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=10 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole

sudo virt-install \
  --virt-type kvm \
  --name prod \
  --memory 2048 --vcpus=2 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=10 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole

sudo virt-install \
  --virt-type kvm \
  --name dev \
  --memory 1024 --vcpus=1 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=10 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole

sudo virt-install \
  --virt-type kvm \
  --name http \
  --memory 1024 --vcpus=1 \
  --cdrom /tmp/ubuntu-20.04-server-amd64.iso \
  --disk size=10 \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole
