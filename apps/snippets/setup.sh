#!/bin/bash -e

source ../bin/common.sh
check_meao_env

wget https://raw.githubusercontent.com/mozmar/snippets-service/master/Procfile
deis create snippets-prod --no-remote
kubectl -n snippets-prod apply -f ./k8s/snippets-prod-nodeport.yaml

deis config:set ALLOWED_HOSTS=snippets-prod.frankfurt,snippets-prod.moz.works,snippets.cdn.mozilla.net,snippets-prod-cdn.moz.works,snippets.mozilla.com -a snippets-prod

deis pull mozorg/snippets:9973b1 -a snippets-prod


