### External Secret Operator (ESO)
External Secret integrates your Azure Key Vault to OpenShift Container Platform so that you can access your secrets in a secure way. You can read more [here](https://external-secrets.io/v0.5.7/)

External Secret Operator is the glue of this integration. It retrieves the secrets from KeyVault with your provided Service Principal credential and stores it in your namespace. Also, updating your OpenShift secret if there is a change in Azure KeyVault side.

This installation provides a cluster wide External Secret Operator that can watch all namespaces and works towards your secret retrieve requests from any namespaces (via `ExternalSecret` object)

#### Installation
Since this is a basic installation, it doesn't require any specific configuration or values:

```
helm template -f values.yaml . | oc apply -f- -n external-secrets
```

You can refer this helm chart through your GitOps configuration to deploy it with ArgoCD.
