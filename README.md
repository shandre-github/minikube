# Minikube Hello World
This project is a simple hellow world application written in Python. The application is build using Docker and is load balance within minikube.

# Dependencies
You will need to install the following on your local environment:
- docker
- kubectl
- minikube
- python
- pip
- make
- pytest
- flask

# Kubernetes manifest files
All manifest files must be of extension *.yaml.*tmpl*. Using templates to pass in values for the placeholders in the files.

# Makefile
**Note**: Run **make help** to see all the available commands.

# How to load balance the application via minikube
1. Update the .env file with your config.
2. Start minikube by running **make minikube_start disksize={disksize}** .Default disk size is 20GB.
3. Set the minikube docker daemon by running **make set_minikube_docker_daemon**
4. Build the docker image by running **make docker_build appname={appname} context={context}** .Default is '.' if you are in the root.
5. Generate the .yaml files by running **make gen_yaml**
6. Create the namespaces, deployment and service by running **make kubectl_apply directory={directory}**
7. To get the load balancer service url run **make minikube_service_url appname={appname} namespace={namespace}**
8. View the running application in the browser.

**Optional:**
 1. If you want an external IP run **make minikube_tunnel** in a different window and keep it open.
 2. To get the external IP run **make kubectl_get_external_ip appname={appname} namespace={namespace}** 
 
**Note**: **{appname}** and **{namespace}** will be what you configured in the *.env* file.

# How to stop the application
1. Stop the **make minikube tunnel** command if you ran it.
2. Delete the deployments by running **make kubectl_delete_deployments appname={appname} namespace={namespace}**
3. Delete the services by running **make kubectl_delete_services appname={appname} namespace={namespace}**
4. Unset the minikube docker daemon by running **make unset_minikube_docker_daemon**
5. Stop minikube by running **make minikube_stop**

# To run pytest
1. Run **make test**

# To clean the project
1. Run **make clean**