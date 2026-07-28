package resources

import (
	id "opmodel.dev/catalogs/opm_experimental/identity"
	c "opmodel.dev/core@v1"
)

/////////////////////////////////////////////////////////////////
//// ValidatingAdmissionPolicies Resource
/////////////////////////////////////////////////////////////////

// CEL-based admission validation, the in-process alternative to a validating
// webhook: no serving certificate, no CA bundle, no availability coupling to a
// pod. Istio uses one to enforce its stable-channel API subset.
//
// Each entry emits BOTH the policy and its binding — they are useless apart and
// keeping them in one entry means their names and references cannot drift.
#ValidatingAdmissionPoliciesResource: c.#Resource & {
	metadata: {
		modulePath:  "\(id.ModulePath)/resources"
		version:     id.Version
		name:        "validating-admission-policies"
		description: "ValidatingAdmissionPolicies emitted with exact names, each with its binding"
		labels: {
			"resource.opmodel.dev/category": "admission"
		}
	}

	// Alias must not be `name` — the inner field would shadow it and the
	// default becomes self-referential (cf. catalog_opm configmap.cue).
	spec: validatingAdmissionPolicies: [KeyName=string]: #ValidatingAdmissionPolicySchema & {name: string | *KeyName}
}

#ValidatingAdmissionPolicies: c.#Component & {
	#resources: (#ValidatingAdmissionPoliciesResource.metadata.fqn): #ValidatingAdmissionPoliciesResource
}

/////////////////////////////////////////////////////////////////
//// Schemas
/////////////////////////////////////////////////////////////////

#ValidatingAdmissionPolicySchema: {
	// Exact, like the webhook configurations: policies are cluster-scoped and
	// referenced by name from their bindings.
	name: string

	// The admission API graduated to v1 in Kubernetes 1.30. Helm charts pick the
	// version from `.Capabilities`, which OPM has no equivalent of and should
	// not grow — a module cannot interrogate the cluster at render time. Exposed
	// as a defaulted disjunction instead, so the choice stays declarative and a
	// module targeting an older cluster can state that explicitly.
	apiVersion: *"admissionregistration.k8s.io/v1" | "admissionregistration.k8s.io/v1beta1"

	labels?: {[string]: string}
	annotations?: {[string]: string}

	failurePolicy?: "Fail" | "Ignore"

	matchConstraints!: {
		resourceRules!: [...{
			apiGroups!: [...string]
			apiVersions!: [...string]
			operations!: [...("CREATE" | "UPDATE" | "DELETE" | "CONNECT" | "*")]
			resources!: [...string]
		}]
	}

	// CEL expressions evaluated against the incoming object. `variables` are
	// evaluated first and referenced from validations as `variables.<name>`.
	variables?: [...{
		name!:       string
		expression!: string
	}]

	validations!: [...{
		expression!:        string
		message?:           string
		messageExpression?: string
		reason?:            string
	}]

	// The binding that actually activates the policy. A policy with no binding
	// is inert, which is why this is not optional.
	binding!: {
		name!: string
		validationActions: [...("Deny" | "Warn" | "Audit")] | *["Deny"]
		matchResources?: {...}
	}
}
