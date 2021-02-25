#!/usr/bin/env bash
function kubectl_get_external_ip() {
    local appname = $1
    local namespace = $2
    local ip = ${kubectl get services ${appname} -n ${namespace}  --output jsonpath='{.status.loadBalancer.ingress[0].ip}'}
    local port = ${kubectl get services ${appname} -n ${namespace}  --output jsonpath='{.spec.ports[0].port}'}
    echo "Running on ${ip}:${port}"
}

function gen_yaml() {
  set +x
  local envvars=$1
  local directory=$2
  source "${envvars}"
  for filename in $(find $directory -name '*.tmpl') ; do
    cat $filename | envsubst >${filename%.tmpl}
  done
}

"$@"