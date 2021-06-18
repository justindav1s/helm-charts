#!/bin/bash

git pull

cd charts

helm package microservice
helm package spring-boot
helm package istio-base
helm package istio-cni
helm package istio-control/istio-discovery
helm package istio-gateways/istio-ingress
helm package istio-gateways/istio-engress
helm package istio-operator
helm package istio-remote

helm repo index .

git add ..

git commit -m "chart update"

git push

helm repo remove jd_repos

helm repo add jd_repos https://gitlab.com/demoplatform/helmcharts/-/raw/main/charts/

helm repo update

curl https://gitlab.com/demoplatform/helmcharts/-/raw/main/charts/index.yaml

helm search repo jd_repos

cd -