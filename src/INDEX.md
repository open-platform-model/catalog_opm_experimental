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
| `#NetworkPolicy` | `traits/network_policy.cue` |  |
| `#NetworkPolicyEgressRule` | `traits/network_policy.cue` |  |
| `#NetworkPolicyIngressRule` | `traits/network_policy.cue` | An empty rule (`{}`) means "allow all in this direction" — the idiom istiod uses for egress, because features like JWKS resolution need to reach user-defined endpoints |
| `#NetworkPolicyPeer` | `traits/network_policy.cue` |  |
| `#NetworkPolicyPort` | `traits/network_policy.cue` |  |
| `#NetworkPolicySchema` | `traits/network_policy.cue` |  |
| `#NetworkPolicyTrait` | `traits/network_policy.cue` | #NetworkPolicyTrait attaches an ingress/egress policy to a workload |

---

## Transformers

| Definition | File | Description |
|---|---|---|
| `#AdmissionPolicyTransformer` | `transformers/admission_policy_transformer.cue` | AdmissionPolicyTransformer converts ValidatingAdmissionPolicies resources to Kubernetes ValidatingAdmissionPolicy + ValidatingAdmissionPolicyBinding pairs |
| `#MutatingWebhookTransformer` | `transformers/mutating_webhook_transformer.cue` | MutatingWebhookTransformer converts MutatingWebhooks resources to Kubernetes MutatingWebhookConfigurations |
| `#NamespaceTransformer` | `transformers/namespace_transformer.cue` | NamespaceTransformer converts Namespaces resources to Kubernetes Namespaces |
| `#NetworkPolicyTransformer` | `transformers/network_policy_transformer.cue` | NetworkPolicyTransformer converts the #NetworkPolicyTrait to a Kubernetes NetworkPolicy whose podSelector is the workload's own rendered pod labels |
| `#ValidatingWebhookTransformer` | `transformers/validating_webhook_transformer.cue` | ValidatingWebhookTransformer converts ValidatingWebhooks resources to Kubernetes ValidatingWebhookConfigurations |

---

