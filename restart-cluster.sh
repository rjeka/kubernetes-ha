#!/bin/bash

bash create-config.sh
systemctl restart docker && systemctl restart kubelet

kubeadm reset


docker-compose --file etcd/docker-compose.yaml stop
docker-compose --file etcd/docker-compose.yaml rm -f

systemctl stop kubelet
systemctl stop docker
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*

rm -rf /etc/cni/

ip a | grep -E 'docker|flannel|cni'
ip link del docker0
ip link del flannel.1

ip link del cni0
systemctl restart docker && systemctl restart kubelet

