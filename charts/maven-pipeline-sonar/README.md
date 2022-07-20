# Residency Maven Pipeline

## Introduction
This chart helps you to set up a Tekton pipeline to build a Java application, bake it into a container image and publish it to the Azure container repository. It then initiates deployment of the application into the relevant test project/namespace, which is then handled by ArgoCD.

## Using this pipeline

The pipeline assumes that you will be handling your application configuration through the [Residency GitOps repo](https://github.com/justindav1s/residency-gitops). 

Start by updating the repository and add your new application to the [main "App of Apps" list for ArgoCD](https://github.com/justindav1s/residency-gitops/blob/main/tooling/values-tooling.yaml).

Add the following section
```yaml
  # My Pipeline
  - name: <my-pipeline>
    enabled: true
    source: https://github.com/justindav1s/residency-helm-charts.git
    source_path: residency-maven-pipeline/
    values:
      name: <my-pipeline>
      service_name: <my-service-name>
```
* Replace `<my-pipeline>` with the name you want for your pipeline. The important thing is that is unique and identifies with your application.
* Replace `<my-service-name>` with the name of the subdirectory in the **residency-gitops** repository that should manage your deployed applications.

Push these changes to main to set up your tekton pipeline in ArgoCD. This should be automatically taken care of by ArgoCD, assuming that the ArgoCD **App of Apps** has already been manually set up through helm.

After your pipeline has been set up you can start using it. In your main application repository you should set up `chart` directory under the root directory. There you should define a Helm chart (`Chart.yaml`), a default `values.yaml` and all underlying template resources. See **https://helm.sh/docs/chart_template_guide/getting_started/** for more information. At least, your `values.yaml` should include the following.
```yaml
name: <github-repository-name>
image:
  registry: residencyregistry.azurecr.io
  repository: <github-repository-name>
  name: <github-repository-name>
  version: 0.0.1
```
Replace `<github-repository-name>` with the name of your main application repository.

Next, create a subdirectory in the **residency-gitops** repository. This directory should have the same name as `<my-service-name>` mentioned earlier. Create subdirectories under that directories called `test` and `preprod`. In those directories, create `values.yaml` files that specify a deployment of your application. The files should at least include the following
```yaml
  <github-repository-name>:
    name: <github-repository-name>
    enabled: true
    source: http://nexus.labs-ci-cd.svc.cluster.local:8081/repository/helm-charts
    chart_name: <github-repository-name>
    source_ref: 1.0.0 # helm chart version
    values:
      image:
        version: 0.0.1
```

When all the above setup has been done, you should have a functioning pipeline - but it's missing a trigger. As a last step we need to connect the application repository to the created event listener. To do this go to your GitHub repository, navigate to `Settings`->`Webhooks`. Set up a new Webhook and point it to `https://<my-pipeline>-webhook-labs-ci-cd.apps.arcaroytxry.westus2.aroapp.io`. Replace `<my-pipeline>` with the same value you entered for your pipeline in the *App of Apps list* earlier.