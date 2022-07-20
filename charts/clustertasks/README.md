# Tekton Clustertasks

This chart contains the tasks that are used commonly by the pipelines. Currently it has the following tasks:

- get-version: It reads the versions of Helm Chart and Maven Applications, then saves into variables for further usage (ie image tagging).
- helm-package: It packages up the helm charts and saves it in the Nexus.
- bake: It containerizes the application.
- deploy: It deploys the newly built container by updating the gitops configuration.