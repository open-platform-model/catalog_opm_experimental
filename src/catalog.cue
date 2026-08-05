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

	// Workload transformers forked from opmodel.dev/catalogs/opm. They are
	// copies of the stable catalog's, except that the daemonset one
	// additionally honours the experimental #RuntimeClass trait — a pod field
	// the stable transformers have no way to emit.
	//
	// The fork exists because runtimeClassName lands INSIDE a DaemonSet that
	// catalog_opm owns; unlike #Namespaces (a standalone object with its own
	// transformer here), it cannot be contributed from the outside. Their FQNs
	// stamp under this catalog's identity, so they do not collide with the
	// stable catalog's — a module picks one catalog's workload transformers,
	// not both.
	//
	// Keep in sync when the upstream stable transformers change.
	(tf.#DaemonSetTransformer.metadata.fqn):   tf.#DaemonSetTransformer
	(tf.#DeploymentTransformer.metadata.fqn):  tf.#DeploymentTransformer
	(tf.#StatefulsetTransformer.metadata.fqn): tf.#StatefulsetTransformer
	(tf.#JobTransformer.metadata.fqn):         tf.#JobTransformer
	(tf.#CronJobTransformer.metadata.fqn):     tf.#CronJobTransformer
}
