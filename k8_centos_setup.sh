# K8s Centos Setup

# Initialize the Kube Master. Do this only on the master node.
# Changed for Calico Network Plugin

sudo kubeadm init --apiserver-advertise-address='192.168.56.101' --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=NumCPU
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install flannel networking.
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

#Install Calico networking
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
exit
