#!/bin/bash

cd charts

helm package microservice
helm repo index .

git add ..

git commit -m "chart update"

git push

helm repo remove jd_repos

sleep 5

helm repo add jd_repos https://github.com/justinndavis/inventory/-/raw/master/flux/charts

sleep 5

helm repo update

sleep 5

curl https://gitlab.com/justinndavis/inventory/-/raw/master/flux/charts/index.yaml

helm search repo jd_repos

cd -