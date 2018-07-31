apiVersion: kubeadm.k8s.io/v1alpha1
kind: MasterConfiguration
api:
  advertiseAddress: K8SHA_IPVIRTUAL
  controlPlaneEndpoint: K8SHA_IPVIRTUAL
networking:
  podSubnet: K8SHA_CIDR
apiServerCertSANs:
- K8SHA_HOSTNAME1
- K8SHA_HOSTNAME2
- K8SHA_HOSTNAME3
- K8SHA_HOSTNAME4
- K8SHA_HOSTNAME5
- K8SHA_IP1
- K8SHA_IP2
- K8SHA_IP3
- K8SHA_IP4
- K8SHA_IP5
- K8SHA_IPVIRTUAL
- 127.0.0.1
etcd:
  endpoints:
  - http://K8SHA_IP1:2379
  - http://K8SHA_IP2:2379
  - http://K8SHA_IP3:2379
  - http://K8SHA_IP4:2379
  - http://K8SHA_IP5:2379
piServerExtraArgs:
  apiserver-count: "3"
token: K8SHA_TOKEN
tokenTTL: "0"
