# Initialise K8s - this is done on master (K8s_ubuntu_init.sh)
# On only the Kube Master server, initialize the cluster and configure kubectl.

sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install the flannel networking plugin in the cluster by running this command on the Kube Master server.

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

exit
