## App Stack Deployment using Terraform Modules

This will deploy wordpress and promethues applications.

- It creates two namespaces named as staging and production.

- Then it deploys wordpress application in both staging and production along with its CPU requests.

- And finally, It deploys prometheus stack using helm in default namespace.

This code is completey flexible and can be modified/re-used as per the requirement.


## TOOLS USED

- Minikube
- Terraform 
- Helm 
- Lens [IDE] - A very useful tool for debug/troubleshooting k8s Git

## Stack Deployment Process using Terraform

I have used two modules each for wordpress and prometheus

appstack

   stack.tf - This is where I have placed required variables/parameters for deployemts. It will call the backend modules during initalization/deployment.
              terraform will run in this location and it creates .terraform folder to store all its required dependencies.

 Inside Modules:

    app.tf - It will have all required application deployment configurations using helm
    providers - It will have the required providers such as k8s, helm etc
    variables - It will have all the variables listed

Application stack [Wordpress + Prometheus] can be deployed using stack.tf file residing in appstack folder.


## COMMANDS TO USE

terrafrom init  [To Initialize modules, downloads the required providers]

<img width="775" alt="image" src="https://user-images.githubusercontent.com/28441475/183281912-56b80448-5c4f-482f-86d8-fc0cab66db22.png">


terraform fmt --recursive . [It will correct the code syntax]


terraform plan [It will show the required changes for deployment]


terraform apply [It will apply the changes after confirmation]


<img width="838" alt="image" src="https://user-images.githubusercontent.com/28441475/183281926-0647faf6-171f-4186-9da4-495c54805075.png">



##To Check pods status in all namespaces


<img width="1039" alt="image" src="https://user-images.githubusercontent.com/28441475/183281949-25cf986c-d31f-43bf-8a8f-64f6e6a027c4.png">

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

