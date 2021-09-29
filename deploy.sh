#!/bin/bash

git pull

cd charts

helm package microservice
# helm package spring-boot
# helm package istio-base
# helm package istio-cni
# helm package istio-control/istio-discovery
# helm package istio-gateways/istio-ingress
# helm package istio-gateways/istio-engress
# helm package istio-operator
# helm package istio-remote

helm repo index .

git add ..

git commit -m "chart update"

git push

helm repo remove jd_repos

helm repo add jd_repos https://raw.githubusercontent.com/justindav1s/helm-charts/main/charts/

helm repo update

curl https://raw.githubusercontent.com/justindav1s/helm-charts/main/charts/index.yaml

helm search repo jd_repos

cd -