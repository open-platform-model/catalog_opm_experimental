package traits

import (
	id "opmodel.dev/catalogs/opm_experimental/identity"
	c "opmodel.dev/core@v1"
	res "opmodel.dev/catalogs/opm/resources"
)

// Selects the container runtime that executes the pod, by setting
// `runtimeClassName` on the pod spec. The named RuntimeClass object is NOT
// created by this trait — it is cluster-level configuration that must already
// exist, and its `handler` must match a runtime the node's containerd knows.
//
// The motivating case is GPU workloads on Talos Linux: the
// `nvidia-container-toolkit` system extension registers an `nvidia` containerd
// runtime handler, and the NVIDIA device plugin only sees the GPU when its pod
// runs under it. Upstream installs the plugin with
// `--set=runtimeClassName=nvidia`. Sidero deliberately does not make `nvidia`
// the node-wide default runtime, so per-pod selection is the supported path.
//
// Only the daemonset transformer in this catalog honours this trait today —
// see transformers/daemonset_transformer.cue. Applying it to a component
// rendered by a transformer that does not read `spec.runtimeClassName` is
// silently inert, which is why the trait is scoped narrowly here rather than
// added to the stable catalog.
#RuntimeClassTrait: c.#Trait & {
	metadata: {
		modulePath:  "\(id.ModulePath)/traits"
		version:     id.Version
		name:        "runtime-class"
		description: "Select the container runtime for the pod (runtimeClassName)"
		labels: {
			"trait.opmodel.dev/category": "runtime"
		}
	}

	appliesTo: [res.#ContainerResource]

	// Name of an existing cluster RuntimeClass, e.g. "nvidia". core.#Trait
	// forces this key to camelCase(name), so the trait's `runtime-class`
	// becomes `runtimeClass`; the transformer maps it onto the pod's
	// `runtimeClassName`, exactly as `host-pid`/`hostPid` maps onto `hostPID`.
	spec: runtimeClass: string & !=""
}

#RuntimeClass: c.#Component & {
	#traits: (#RuntimeClassTrait.metadata.fqn): #RuntimeClassTrait
}
