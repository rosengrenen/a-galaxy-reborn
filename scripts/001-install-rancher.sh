/opt/helm/helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
/opt/kubectl/kubectl create namespace cattle-system
/opt/helm/helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.chalmers.it \
  --set tls=external \
  --set replicas=1

# Wait for the installation to finish
/opt/kubectl/kubectl -n cattle-system rollout status deploy/rancher