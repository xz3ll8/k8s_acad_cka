#k8s_centos_install.sh

clear
echo -e  "Sleeping for 60 seconds.... have you..."
echo -e  "\n\nFirstly turn swap off, and edit fstab to ensure it is persistent"
echo -e  "\nsudo swapoff -a"
echo -e  "\nsudo vi /etc/fstab"
echo -e  "\n\nLook for the line in /etc/fstab that says /root/swap and comment it out"
echo -e  "\n\nHave you turned off selinux?"
echo -e  "\nsudo setenforce 0 \nsudo vi /etc/selinux/config"
echo -e  "\n\nPersist Change edit the line that says SELINUX=enforcing to SELINUX=permissive\n\n\n\n" 
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

exit;
