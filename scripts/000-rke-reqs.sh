# kubectl

sudo mkdir /opt/kubectl -p
sudo wget "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  -O /opt/kubectl/kubectl
sudo chmod +x /opt/kubectl/kubectl

# helm

sudo mkdir /opt/helm -p
sudo wget https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz \
  -O /opt/helm/helm.tar.gz
sudo tar -xzf /opt/helm/helm.tar.gz \
  -C /opt/helm
sudo rm -f /opt/helm/helm.tar.gz
sudo mv /opt/helm/linux-amd64/* /opt/helm
sudo rm -rf /opt/helm/linux-amd64
sudo chmod +x /opt/helm/helm

# # rke

sudo mkdir /opt/rke -p
sudo wget https://github.com/rancher/rke/releases/download/v1.2.7/rke_linux-amd64 \
  -O /opt/rke/rke
sudo chmod +x /opt/rke/rke
