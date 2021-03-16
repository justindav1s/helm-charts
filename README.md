## Adventures with Helm


### Minikube

With VMware driver

https://minikube.sigs.k8s.io/docs/drivers/vmware/

```
minikube delete

brew install docker-machine-driver-vmware

minikube start --driver=vmware --memory=32768 --cpus=8

minikube addons enable ingress

minikube dashboard

kubectl create namespace hello
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0 -n hello
kubectl expose deployment web --type=NodePort --port=8080 -n hello
kubectl get service web -n hello
minikube service web --url -n hello
http://192.168.28.136:31161

so hello.192.168.28.136.nip.io is our host
kubectl apply -f hello-ingress.yaml -n hello

```

### Helm Operator & Flux1

https://docs.fluxcd.io/projects/helm-operator/en/stable/get-started/quickstart/

https://github.com/fluxcd/helm-operator-get-started

```

kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/1.2.0/deploy/crds.yaml
kubectl create ns flux
helm repo add fluxcd https://charts.fluxcd.io

helm upgrade -i flux fluxcd/flux \
   --set git.url=git@gitlab.com:justindav1s/inventory \
   --namespace flux

get the output ssh public key 
kubectl -n flux logs deployment/flux | grep identity.pub | cut -d '"' -f2
upload to gitlab

helm upgrade -i helm-operator fluxcd/helm-operator \
   --set helm.versions=v3 \
   --set git.ssh.secretName=flux-git-deploy \
   --namespace flux    

```


### Flux2

https://toolkit.fluxcd.io/get-started/


```
oc new-project flux-system

oc adm policy add-scc-to-user privileged -z source-controller

flux bootstrap gitlab \
  --owner=$GITLAB_USER \
  --repository=flux2 \
  --branch=master \
  --path=./clusters/ocp \
  --personal


find out why namespace is stuck terminating

https://www.openshift.com/blog/the-hidden-dangers-of-terminating-namespaces

oc  api-resources --verbs=list --namespaced -o name | xargs -n 1 oc get --show-kind --ignore-not-found -n flux-system


oc get kustomization flux-system -o json > kustomization.json

remove finalizers

then

curl -k -H "Content-Type: application/json" -H "Authorization: Bearer $(oc whoami -t)" -X PUT --data-binary @kustomization.json $(oc whoami --show-server)/apis/kustomize.toolkit.fluxcd.io/v1beta1/namespaces/flux-system/kustomizations/flux-system

oc get namespace flux-system -o json > flux-system-ns.json

remove finalizers

then 

curl -k -H "Content-Type: application/json" -H "Authorization: Bearer $(oc whoami -t)" -X PUT --data-binary @flux-system-ns.json  $(oc whoami --show-server)/api/v1/namespaces/flux-system/finalize


https://toolkit.fluxcd.io/guides/helmreleases/


apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: jd-repo
  namespace: flux-system
spec:
  interval: 1m
  url: https://gitlab.com/justinndavis/inventory/-/raw/master/flux/charts/
  
```