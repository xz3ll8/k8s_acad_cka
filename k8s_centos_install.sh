#k8s_centos_install.sh

clear
printf "Sleeping for 60 seconds.... have you..."
printf "\n\nFirstly turn swap off, and edit fstab to ensure it is persistent"
printf "\nsudo swapoff -a"
printf "\nsudo vi /etc/fstab"
printf "\n\nLook for the line in /etc/fstab that says /root/swap and comment it out"
printf "\n\nHave you turned off selinux?"
printf "\nsudo setenforce 0 \nsudo vi /etc/selinux/config"
printf "\n\nPersist Change edit the line that says SELINUX=enforcing to SELINUX=permissive\n\n\n\n" 
sleep 60

# Install and configure Docker.

sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

# Add the Kubernetes repo.
cat << EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Install Kubernetes Components.
sudo yum install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Configure sysctl.
cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

# Initialize the Kube Master. Do this only on the master node.
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-checks "NumCPU"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install flannel networking.
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

exit
