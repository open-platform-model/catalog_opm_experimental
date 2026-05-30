// Package identity is the single source of the catalog's module path and
// version. It sits at the bottom of the catalog's import graph (it imports
// nothing within the module) so resource/trait/transformer subpackages can
// source `ModulePath`/`Version` without a circular import, and the root
// `catalog.cue` can stamp transformer metadata in lockstep.
//
// Publish-time stamping writes a transient `version_override.cue` into this
// package pinning a concrete SemVer; the committed tree always resolves
// `Version` to the "0.0.0-dev" default. Mirrors the pattern used by the
// opmodel.dev/catalogs/opm catalog.
package identity

// #VersionType mirrors core.#VersionType (SemVer 2.0). Duplicated here so the
// identity package stays import-free at the bottom of the graph.
#VersionType: string & =~"^\\d+\\.\\d+\\.\\d+(-[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?(\\+[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?$"

// ModulePath is the catalog's CUE module path (no @vN qualifier, no version).
ModulePath: "opmodel.dev/catalogs/opm-experimental"

// Version is the catalog's bare SemVer. Defaults to the dev sentinel in the
// committed tree; a publish-time version_override.cue unifies it to a
// concrete release version.
Version: #VersionType | *"0.0.0-dev"
