## Tekton Config
TektonConfig custom resource is the top most component of the operator which allows user to install and customize all other components at a single place.

Configuration like `pruner` or in order to using alpha features, we need to update this configuration.

More information can be found [here](https://tekton.dev/docs/operator/tektonconfig/)


### Pruner Configuration
We can globally configure pruning for Tekton resources by configuring the Operator TektonConfig. For example we can keep the last 15 PipelineRun resources, and prune every 45 minutes using this configuration:

```yaml
  pruner:
    keep: 15
    resources:
      - pipelinerun
    schedule: '*/45 * * * *'
```

This generates a CronJob in the targetNamespace which is:

```bash
oc get cronjob resource-pruner -n openshift-pipelines -o yaml
```

You can edit this config by updating [values file.](values.yaml)

### Using Timeouts for PipelineRuns and TaskRuns
In order to use `timeouts` capability in PipelineRuns and TaskRuns, `enable-api-fields` should set to `alpha` for pipelines:

```yaml
  pipeline:
    enable-api-fields: alpha
```