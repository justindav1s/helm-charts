#!/bin/bash

cd charts

helm package microservice
helm repo index .

git add ..

git commit -m "chart update"

git push

helm repo remove jd_repos

helm repo add jd_repos https://raw.githubusercontent.com/justindav1s/helmcharts/main/charts

helm repo update

curl https://raw.githubusercontent.com/justindav1s/helmcharts/main/charts/index.yaml

helm search repo jd_repos

cd -