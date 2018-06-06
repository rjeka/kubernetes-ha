#!/bin/bash

# local machine ip address
export K8SHA_IPLOCAL=172.26.133.21

# local machine etcd name, options: etcd1, etcd2, etcd3, etcd4, etcd5
export K8SHA_ETCDNAME=etcd1

# local machine keepalived state config, options: MASTER, BACKUP. One keepalived cluster only one MASTER, other's are BACKUP
export K8SHA_KA_STATE=MASTER

# local machine keepalived priority config, options: 102, 101, 100, 99, 98. MASTER must 102
export K8SHA_KA_PRIO=102

# local machine keepalived network interface name config, for example: eth0
export K8SHA_KA_INTF=ens18

#######################################
# all masters settings below must be same
#######################################

# master keepalived virtual ip address
export K8SHA_IPVIRTUAL=172.26.133.20

# master01 ip address
export K8SHA_IP1=172.26.133.21

# master02 ip address
export K8SHA_IP2=172.26.133.22

# master03 ip address
export K8SHA_IP3=172.26.133.23

# master04 ip address
export K8SHA_IP4=172.26.133.24

# master05 ip address
export K8SHA_IP5=172.26.133.25

# master01 hostname
export K8SHA_HOSTNAME1=hb-master01

# master02 hostname
export K8SHA_HOSTNAME2=hb-master02

# master03 hostname
export K8SHA_HOSTNAME3=hb-master03

# master04 hostname
export K8SHA_HOSTNAME4=hb-master04

# master04 hostname
export K8SHA_HOSTNAME5=hb-master05

# keepalived auth_pass config, all masters must be same
export K8SHA_KA_AUTH=56cf8dd754c90194d1600c483e10abfr

#etcd tocken:
export ETCD_TOKEN=9489bf68bdfe1b9ae037d6fd9e7efefd

# kubernetes cluster token, you can use 'kubeadm token generate' to get a new one
export K8SHA_TOKEN=yf0t14.7ekahohaetbdphqg

# kubernetes CIDR pod subnet, if CIDR pod subnet is "10.244.0.0/16" please set to "10.244.0.0\\/16"
export K8SHA_CIDR=10.244.0.0\\/16


##############################
# please do not modify anything below
##############################

# set etcd cluster docker-compose.yaml file
sed \
-e "s/K8SHA_ETCDNAME/$K8SHA_ETCDNAME/g" \
-e "s/K8SHA_IPLOCAL/$K8SHA_IPLOCAL/g" \
-e "s/K8SHA_IP1/$K8SHA_IP1/g" \
-e "s/K8SHA_IP2/$K8SHA_IP2/g" \
-e "s/K8SHA_IP3/$K8SHA_IP3/g" \
-e "s/K8SHA_IP4/$K8SHA_IP4/g" \
-e "s/K8SHA_IP5/$K8SHA_IP5/g" \
-e "s/ETCD_TOKEN/$ETCD_TOKEN/g" \
etcd/docker-compose.yaml.tpl > etcd/docker-compose.yaml

echo 'set etcd cluster docker-compose.yaml file success: etcd/docker-compose.yaml'

# set keepalived config file
mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

cp keepalived/check_apiserver.sh /etc/keepalived/

sed \
-e "s/K8SHA_KA_STATE/$K8SHA_KA_STATE/g" \
-e "s/K8SHA_KA_INTF/$K8SHA_KA_INTF/g" \
-e "s/K8SHA_IPLOCAL/$K8SHA_IPLOCAL/g" \
-e "s/K8SHA_KA_PRIO/$K8SHA_KA_PRIO/g" \
-e "s/K8SHA_IPVIRTUAL/$K8SHA_IPVIRTUAL/g" \
-e "s/K8SHA_KA_AUTH/$K8SHA_KA_AUTH/g" \
keepalived/keepalived.conf.tpl > /etc/keepalived/keepalived.conf

echo 'set keepalived config file success: /etc/keepalived/keepalived.conf'

# set nginx load balancer config file
sed \
-e "s/K8SHA_IP1/$K8SHA_IP1/g" \
-e "s/K8SHA_IP2/$K8SHA_IP2/g" \
-e "s/K8SHA_IP3/$K8SHA_IP3/g" \
-e "s/K8SHA_IP4/$K8SHA_IP4/g" \
-e "s/K8SHA_IP5/$K8SHA_IP5/g" \
nginx-lb/nginx-lb.conf.tpl > nginx-lb/nginx-lb.conf

echo 'set nginx load balancer config file success: nginx-lb/nginx-lb.conf'

# set kubeadm init config file
sed \
-e "s/K8SHA_HOSTNAME1/$K8SHA_HOSTNAME1/g" \
-e "s/K8SHA_HOSTNAME2/$K8SHA_HOSTNAME2/g" \
-e "s/K8SHA_HOSTNAME3/$K8SHA_HOSTNAME3/g" \
-e "s/K8SHA_HOSTNAME4/$K8SHA_HOSTNAME4/g" \
-e "s/K8SHA_HOSTNAME5/$K8SHA_HOSTNAME5/g" \
-e "s/K8SHA_IP1/$K8SHA_IP1/g" \
-e "s/K8SHA_IP2/$K8SHA_IP2/g" \
-e "s/K8SHA_IP3/$K8SHA_IP3/g" \
-e "s/K8SHA_IP4/$K8SHA_IP4/g" \
-e "s/K8SHA_IP5/$K8SHA_IP5/g" \
-e "s/K8SHA_IPVIRTUAL/$K8SHA_IPVIRTUAL/g" \
-e "s/K8SHA_TOKEN/$K8SHA_TOKEN/g" \
-e "s/K8SHA_CIDR/$K8SHA_CIDR/g" \
kubeadm-init.yaml.tpl > kubeadm-init.yaml

sed \
-e "s/K8SHA_IPVIRTUAL/$K8SHA_IPVIRTUAL/g" \
kube-ingress/service-nodeport.yaml.tpl > kube-ingress/service-nodeport.yaml




echo 'set kubeadm init config file success: kubeadm-init.yaml'

