helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.chalmers.it \
  --set tls=external \
  --set replicas=1

# Wait for the installation to finish
kubectl -n cattle-system rollout status deploy/rancher
