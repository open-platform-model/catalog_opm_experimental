# catalog_opm_experimental — Definition Index

CUE module: `opmodel.dev/catalogs/opm_experimental@v1`

---

## Project Structure

```
```

---

## Identity

| Definition | File | Description |
|---|---|---|
| `#VersionType` | `identity/identity.cue` | #VersionType mirrors core |

---

## Resources

| Definition | File | Description |
|---|---|---|
| `#AdmissionResourceRule` | `resources/admission_policy.cue` |  |
| `#ValidatingAdmissionPolicies` | `resources/admission_policy.cue` |  |
| `#ValidatingAdmissionPoliciesResource` | `resources/admission_policy.cue` | CEL-based admission validation, the in-process alternative to a validating webhook: no serving certificate, no CA bundle, no availability coupling to a pod |
| `#ValidatingAdmissionPolicySchema` | `resources/admission_policy.cue` |  |
| `#NamespaceSchema` | `resources/namespace.cue` | Kubernetes Namespace, emitted with its exact name |
| `#Namespaces` | `resources/namespace.cue` |  |
| `#NamespacesResource` | `resources/namespace.cue` |  |
| `#MutatingWebhookConfigurationSchema` | `resources/webhook.cue` |  |
| `#MutatingWebhookSchema` | `resources/webhook.cue` | Mutating-only extension: the mutating admission API additionally supports reinvocationPolicy |
| `#MutatingWebhooks` | `resources/webhook.cue` |  |
| `#MutatingWebhooksResource` | `resources/webhook.cue` |  |
| `#ValidatingWebhookConfigurationSchema` | `resources/webhook.cue` | The webhooks lists are declared per variant (not on the shared meta schema) so the mutating elements can carry reinvocationPolicy without fighting the closed base #WebhookSchema |
| `#ValidatingWebhooks` | `resources/webhook.cue` |  |
| `#ValidatingWebhooksResource` | `resources/webhook.cue` |  |
| `#WebhookConfigurationMetaSchema` | `resources/webhook.cue` | Shared config-level metadata |
| `#WebhookSchema` | `resources/webhook.cue` |  |

---

## Traits

| Definition | File | Description |
|---|---|---|
| `#RuntimeClass` | `traits/runtime_class.cue` |  |
| `#RuntimeClassTrait` | `traits/runtime_class.cue` | Selects the container runtime that executes the pod, by setting `runtimeClassName` on the pod spec |

---

## Transformers

| Definition | File | Description |
|---|---|---|
| `#AdmissionPolicyTransformer` | `transformers/admission_policy_transformer.cue` | AdmissionPolicyTransformer converts ValidatingAdmissionPolicies resources to Kubernetes ValidatingAdmissionPolicy + ValidatingAdmissionPolicyBinding pairs |
| `#ToK8sContainer` | `transformers/container_helpers.cue` | #ToK8sContainer converts an OPM #ContainerSchema to a Kubernetes #Container |
| `#ToK8sContainers` | `transformers/container_helpers.cue` | #ToK8sContainers converts a list of OPM containers to Kubernetes containers |
| `#ToK8sKeyToPath` | `transformers/container_helpers.cue` | #ToK8sKeyToPath converts OPM key/path/mode items to K8s KeyToPath entries |
| `#ToK8sObjectProjection` | `transformers/container_helpers.cue` | #ToK8sObjectProjection converts an OPM object projection (configMap or secret source inside a projected volume) to its K8s shape |
| `#ToK8sVolumes` | `transformers/container_helpers.cue` | #ToK8sVolumes converts OPM volumes map to Kubernetes volumes list |
| `#CronJobTransformer` | `transformers/cronjob_transformer.cue` | CronJobTransformer converts scheduled task components to Kubernetes CronJobs |
| `#DaemonSetTransformer` | `transformers/daemonset_transformer.cue` | DaemonSetTransformer converts daemon workload components to Kubernetes DaemonSets |
| `#DeploymentTransformer` | `transformers/deployment_transformer.cue` | DeploymentTransformer converts stateless workload components to Kubernetes Deployments |
| `#JobTransformer` | `transformers/job_transformer.cue` | JobTransformer converts task workload components to Kubernetes Jobs |
| `#MutatingWebhookTransformer` | `transformers/mutating_webhook_transformer.cue` | MutatingWebhookTransformer converts MutatingWebhooks resources to Kubernetes MutatingWebhookConfigurations |
| `#WorkloadName` | `transformers/name_helpers.cue` | #WorkloadName resolves a workload's rendered object name: the exact name from #ResourceNameTrait when set, otherwise the instance-scoped default |
| `#NamespaceTransformer` | `transformers/namespace_transformer.cue` | NamespaceTransformer converts Namespaces resources to Kubernetes Namespaces |
| `#PodSchedulingFields` | `transformers/pod_helpers.cue` | Pod-spec scheduling fields from #PodSchedulingTrait |
| `#PodTemplateMetadata` | `transformers/pod_helpers.cue` | Pod-template metadata: context labels merged with #PodMetadataTrait labels, plus pod-only annotations |
| `#StatefulsetTransformer` | `transformers/statefulset_transformer.cue` | StatefulsetTransformer converts stateful workload components to Kubernetes StatefulSets |
| `#ValidatingWebhookTransformer` | `transformers/validating_webhook_transformer.cue` | ValidatingWebhookTransformer converts ValidatingWebhooks resources to Kubernetes ValidatingWebhookConfigurations |

---

