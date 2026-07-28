package traits

import (
	id "opmodel.dev/catalogs/opm_experimental/identity"
	c "opmodel.dev/core@v1"
)

// #NetworkPolicyTrait attaches an ingress/egress policy to a workload.
//
// Modelled as a TRAIT on the workload rather than a standalone resource, and
// that is forced by how selectors work: a NetworkPolicy's `podSelector` has to
// match the workload's rendered pod labels, which only a transformer knows
// (#context.componentLabels). A standalone resource would have to be told the
// selector by hand, and any drift between it and the workload's actual labels
// produces a policy that silently selects nothing — i.e. no protection, with no
// error anywhere.
//
// Note this trait deliberately does NOT declare `appliesTo` against
// catalog_opm's #ContainerResource. This catalog is typed only against core and
// must stay that way: transformer matching is exact-FQN and an FQN embeds the
// catalog version, so an experimental transformer that demanded a stable-catalog
// FQN would stop matching on every stable release. The trait attaches to any
// component; its transformer requires only this trait's own FQN.
#NetworkPolicyTrait: c.#Trait & {
	metadata: {
		modulePath:  "\(id.ModulePath)/traits"
		version:     id.Version
		name:        "network-policy"
		description: "Ingress and egress network policy for a workload's pods"
		labels: {
			"trait.opmodel.dev/category": "network"
		}
	}

	spec: networkPolicy: #NetworkPolicySchema
}

#NetworkPolicy: c.#Component & {
	#traits: (#NetworkPolicyTrait.metadata.fqn): #NetworkPolicyTrait
}

#NetworkPolicySchema: {
	// Which directions this policy governs. Naming a direction with no matching
	// rule DENIES all traffic in that direction — "Egress" with no `egress`
	// entries is a deny-all-egress policy, not a no-op.
	policyTypes: [...("Ingress" | "Egress")] | *["Ingress"]

	ingress?: [...#NetworkPolicyIngressRule]
	egress?: [...#NetworkPolicyEgressRule]
}

// An empty rule (`{}`) means "allow all in this direction" — the idiom istiod
// uses for egress, because features like JWKS resolution need to reach
// user-defined endpoints.
#NetworkPolicyIngressRule: {
	ports?: [...#NetworkPolicyPort]
	from?: [...#NetworkPolicyPeer]
}

#NetworkPolicyEgressRule: {
	ports?: [...#NetworkPolicyPort]
	to?: [...#NetworkPolicyPeer]
}

#NetworkPolicyPort: {
	protocol?: "TCP" | "UDP" | "SCTP"
	port?:     int & >=1 & <=65535
	endPort?:  int & >=1 & <=65535
}

#NetworkPolicyPeer: {
	podSelector?: {...}
	namespaceSelector?: {...}
	ipBlock?: {
		cidr!: string
		except?: [...string]
	}
}
