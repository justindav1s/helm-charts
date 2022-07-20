# Overview

## Introduction
This helm chart is used to set up an instance of the Openshift Service Mesh Control (OSSM) for Dev namespaces

## Prerequisites/Assumptions
To use this helm chart you need to set up the following operators on OpenShift 
* Jaeger Operator (by Red Hat), 
* Kiali (by Red Hat), 
* Prometheus (by Red Hat), 
* Openshift Service Mesh 

and create a project/namespace called `istio-servicemesh-dev` - where the agent will reside (Note: it is all taken care by [GitOps](https://github.com/justindav1s/residency-gitops/blob/bd05ff4b7ae020fa53431a3c5d09e8920d0f0f28/tooling/values-tooling.yaml#L153)).


## How it works
It creates 2 resources
1. One [`ServiceMeshControlPlane`](https://github.com/maistra/api/blob/maistra-2.1/docs/crd/maistra.io_ServiceMeshControlPlane_v2.adoc) custom resource that determines an OSSM control plane tenant and the components and cross-cutting service mesh configurations (eg. mTLS) for this tenant.
2. One `ServiceMeshMemberRole` custom resource which determines which namespaces will be part of the service mesh tenant.

## Values
- `namespace`: Name of the namespace to be part of the service mesh

