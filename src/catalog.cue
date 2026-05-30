// Catalog manifest for the OPM experimental catalog. Embeds bare c.#Catalog
// (modules pattern — no Catalog: wrapper) and sources metadata from the sibling
// identity/ package. This catalog is a skeleton: it carries no transformers yet.
// Experimental resources, traits, blueprints, and transformers land here before
// (or instead of) graduating into the stable opmodel.dev/catalogs/opm catalog.
//
// To add a transformer: define it under transformers/ and enumerate it in the
// #transformers map below, keyed by its own metadata.fqn. Resources, traits, and
// blueprints surface transitively through each transformer's required/optional
// maps.
package opm_experimental

import (
	c "opmodel.dev/core@v0"
	id "opmodel.dev/catalogs/opm-experimental/identity"
)

c.#Catalog
metadata: {
	modulePath:  id.ModulePath
	version:     id.Version
	description: "OPM experimental catalog — staging ground for new resources, traits, blueprints, and transformers"
}

// No transformers yet — this catalog is a skeleton. Add entries keyed by
// metadata.fqn as experimental transformers are introduced.
#transformers: {}
