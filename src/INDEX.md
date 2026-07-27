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

## Transformers

| Definition | File | Description |
|---|---|---|
| `#MutatingWebhookTransformer` | `transformers/mutating_webhook_transformer.cue` | MutatingWebhookTransformer converts MutatingWebhooks resources to Kubernetes MutatingWebhookConfigurations |
| `#NamespaceTransformer` | `transformers/namespace_transformer.cue` | NamespaceTransformer converts Namespaces resources to Kubernetes Namespaces |
| `#ValidatingWebhookTransformer` | `transformers/validating_webhook_transformer.cue` | ValidatingWebhookTransformer converts ValidatingWebhooks resources to Kubernetes ValidatingWebhookConfigurations |

---

