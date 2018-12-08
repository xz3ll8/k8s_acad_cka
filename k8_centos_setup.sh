# K8s Centos Setup

# Initialize the Kube Master. Do this only on the master node.
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-checks "NumCPU"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install flannel networking.
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

exit
