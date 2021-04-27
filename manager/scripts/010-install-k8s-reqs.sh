# kubectl
sudo wget "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  -O /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl

# helm
sudo wget https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz \
  -O /tmp/helm.tar.gz
sudo tar -xzf /tmp/helm.tar.gz \
  -C /tmp
sudo cp /tmp/linux-amd64/helm /usr/local/bin/helm
sudo chmod +x /usr/local/bin/helm

# # rke
sudo wget https://github.com/rancher/rke/releases/download/v1.2.7/rke_linux-amd64 \
  -O /usr/local/bin/rke
sudo chmod +x /usr/local/bin/rke
