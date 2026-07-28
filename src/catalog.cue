// Catalog manifest for the OPM experimental catalog. Embeds bare c.#Catalog
// (modules pattern — no Catalog: wrapper) and sources metadata from the sibling
// identity/ package. Experimental resources, traits, blueprints, and
// transformers land here before (or instead of) graduating into the stable
// opmodel.dev/catalogs/opm catalog.
//
// To add a transformer: define it under transformers/ and enumerate it in the
// #transformers map below, keyed by its own metadata.fqn. Resources, traits, and
// blueprints surface transitively through each transformer's required/optional
// maps.
package opm_experimental

import (
	c "opmodel.dev/core@v1"
	id "opmodel.dev/catalogs/opm_experimental/identity"
	tf "opmodel.dev/catalogs/opm_experimental/transformers"
)

c.#Catalog
metadata: {
	modulePath:  id.ModulePath
	version:     id.Version
	description: "OPM experimental catalog — staging ground for new resources, traits, blueprints, and transformers"
}

#transformers: {
	(tf.#NamespaceTransformer.metadata.fqn):         tf.#NamespaceTransformer
	(tf.#ValidatingWebhookTransformer.metadata.fqn): tf.#ValidatingWebhookTransformer
	(tf.#MutatingWebhookTransformer.metadata.fqn):   tf.#MutatingWebhookTransformer
	(tf.#AdmissionPolicyTransformer.metadata.fqn):   tf.#AdmissionPolicyTransformer
}
