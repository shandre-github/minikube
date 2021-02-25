PYTHON = python3

SHELL := '/bin/bash'

.DEFAULT_GOAL = help

help:
	@echo "---------------HELP-----------------"
	@echo "To start minikube type make minikube_start disksize={disksize} .Default disk size is 20GB."
	@echo "To set the minikube docker daemon type make set_minikube_docker_daemon"
	@echo "To set the minikube docker daemon in windows type minikube docker-env | Invoke-Expression"
	@echo "To display all env vars type make display_env_vars"
	@echo "To display all env vars in windows type gci env:* | sort-object name"
	@echo "To build the docker image type make docker_build appname={appname} context={context}"
	@echo "To generate yaml from the templates type make gen_yaml"
	@echo "To apply the kubernetes manifest files changes type make kubectl_apply directory={directory}"
	@echo "To get the load balancer service url type make minikube_service_url appname={appname} namespace={namespace}"
	@echo "To get minikube connected to the load balancing service type make minikube_tunnel"
	@echo "To get the external ip after running make minikube tunnel in another window type make kubectl_get_external_ip appname={appname} namespace={namespace}"
	@echo "To delete the deployments type make kubectl_delete_deployments appname={appname} namespace={namespace}"
	@echo "To delete the services type make kubectl_delete_services appname={appname} namespace={namespace}"
	@echo "To unset the minikube docker daemon type make unset_minikube_docker_daemon"
	@echo "To unset the minikube docker daemon in windows type minikube docker-env -u | Invoke-Expression"
	@echo "To stop minikube type make minikube_stop"
	@echo "To test the project type make test"
	@echo "To run the project type make run"
	@echo "To run the project in windows type ${PYTHON} .\helloworld\main.py"
	@echo "To clean the project run make clean"
	@echo "------------------------------------"

minikube_start:
	minikube start --disk-size $(disksize)

set_minikube_docker_daemon:
	eval $(minikube docker-env)

display_env_vars:
	env

docker_build:
	docker build -t $(appname) $(context)

gen_yaml:
	./scripts/utils.sh gen_yaml .env ./kubernetes/

kubectl_apply:
	kubectl apply -Rf $(directory)

minikube_service_url:
	minikube service $(appname) -n $(namespace)

minikube_tunnel:
	minikube tunnel

kubectl_get_external_ip:
	./scripts/utils.sh kubectl_get_external_ip $(appname) $(namespace)

kubectl_delete_deployments:
	kubectl delete deployments $(appname) -n $(namespace)

kubectl_delete_services:
	kubectl delete services $(appname) -n $(namespace)

unset_minikube_docker_daemon:
	eval $(minikube docker-env -u)

minikube_stop:
	minikube stop

test:
	pytest
	
run:
	${PYTHON} ./helloworld/main.py

clean:
	rm -r .pytest_cache **/*.pyc **/__pycache__ **/**/*.yaml
