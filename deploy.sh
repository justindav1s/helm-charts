#!/bin/bash

cd charts

helm package microservice
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