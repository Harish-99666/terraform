As per the task, This code will deploy two namespaces [staging and production]

Then it deploys prometheus stack using helm in default namespace.

Finally it deploys wordpress application in both staging and production along with its CPU requests

This code is completey flexible and can be modified/re-used as per the requirement 

Tools Used:

Minikube
Terraform
Helm
Lens [IDE] - A very useful tool for debug/troubleshooting k8s
Git

Stack Deployment Process using Terraform

1. I have used two modules each for wordpress and prometheus

 Inside Module:

    app.tf - It will have all required application deployment configurations using helm
    providers - It will have the required providers such as k8s, helm etc
    variables - It will have all the variables listed

Application stack [Wordpress + Prometheus] can be deployed using stack.tf file

Commands to use 

terrafrom init 

Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Reusing previous version of hashicorp/helm from the dependency lock file
- Using previously-installed hashicorp/kubernetes v2.12.1
- Using previously-installed hashicorp/helm v2.6.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

terraform fmt --recursive .

It will correct the code syntax

terraform plan 

- It will show the required changes for deployment

terraform apply

- It will apply the changes after confirmation


module.prometheus.helm_release.prometheus: Creation complete after 39s [id=prometheus-app]
module.wordpress.helm_release.wordpress[0]: Still creating... [40s elapsed]
module.wordpress.helm_release.wordpress[1]: Still creating... [40s elapsed]
module.wordpress.helm_release.wordpress[0]: Still creating... [50s elapsed]
module.wordpress.helm_release.wordpress[1]: Still creating... [50s elapsed]
module.wordpress.helm_release.wordpress[0]: Still creating... [1m0s elapsed]
module.wordpress.helm_release.wordpress[1]: Still creating... [1m0s elapsed]
module.wordpress.helm_release.wordpress[0]: Still creating... [1m10s elapsed]
module.wordpress.helm_release.wordpress[0]: Creation complete after 1m15s [id=wordpress-01]
module.wordpress.helm_release.wordpress[1]: Still creating... [1m10s elapsed]
module.wordpress.helm_release.wordpress[1]: Creation complete after 1m13s [id=wordpress-02]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


To Check pods status in all namespaces

kubectl get po -A

NAMESPACE     NAME                                                     READY   STATUS    RESTARTS      AGE
default       alertmanager-prometheus-app-kube-promet-alertmanager-0   2/2     Running   0             4m17s
default       prometheus-app-grafana-86bdf7b484-wf9ck                  3/3     Running   0             4m20s
default       prometheus-app-kube-promet-operator-6dd4df9db-gl5zz      1/1     Running   0             4m20s
default       prometheus-app-kube-state-metrics-55ccdfd85f-2qtbf       1/1     Running   0             4m20s
default       prometheus-app-prometheus-node-exporter-k8wdt            1/1     Running   0             4m20s
default       prometheus-prometheus-app-kube-promet-prometheus-0       2/2     Running   0             4m16s
kube-system   coredns-64897985d-md62t                                  1/1     Running   1             180d
kube-system   etcd-minikube                                            1/1     Running   1             180d
kube-system   kube-apiserver-minikube                                  1/1     Running   1             180d
kube-system   kube-controller-manager-minikube                         1/1     Running   1             180d
kube-system   kube-proxy-btsmn                                         1/1     Running   1             180d
kube-system   kube-scheduler-minikube                                  1/1     Running   1             180d
kube-system   storage-provisioner                                      1/1     Running   2 (25h ago)   180d
production    wordpress-02-6846d8dccf-ldfxn                            1/1     Running   0             4m14s
production    wordpress-02-mariadb-0                                   1/1     Running   0             4m14s
staging       wordpress-01-7ffbf96449-s67f9                            1/1     Running   0             4m19s
staging       wordpress-01-mariadb-0                                   1/1     Running   0             4m19s


To Access Wordpress with staging/production namespace

Nodeport has been used as its a local Environment, LoadBalancer's/Ingress will be used in cloud.

❯  export NODE_PORT=$(kubectl get --namespace staging -o jsonpath="{.spec.ports[0].nodePort}" services wordpress-01)
❯  export NODE_IP=$(kubectl get nodes --namespace staging -o jsonpath="{.items[0].status.addresses[0].address}")
❯  echo http://$NODE_IP:$NODE_PORT/admin

To fetch the password 

❯ echo Password: $(kubectl get secret --namespace staging wordpress-01 -o jsonpath="{.data.wordpress-password}" | base64 --decode)

Default User: "user"

To Access Prometheus and Grafana

Port-forwarding must be used as the default service Type is "ClusterIP"

Prometheus listens on 9090
Grafana listens on 3000

kubectl port-forward <<Replace with prometheus pod>> 9090

kubectl port-forward deployment/<<Replace with Grafana Deployment>> 3000




