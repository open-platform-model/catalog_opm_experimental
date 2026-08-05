# OPM experimental catalog

The staging catalog for the Open Platform Model. `catalog_opm_experimental` is where new `#Resource`s, `#Trait`s, `#Blueprint`s, and `#ComponentTransformer`s are trialled before (or instead of) graduating into the stable catalog (`catalog_opm` / `opmodel.dev/catalogs/opm@v1`).

This repository is a single CUE module, `opmodel.dev/catalogs/opm_experimental@v1`, published to `ghcr.io/open-platform-model/catalogs/opm_experimental` and consumed via `import "opmodel.dev/catalogs/opm_experimental@v1"` (package `opm_experimental`).

The module is explicitly experimental and ships on a v1 alpha prerelease line (`v1.x.x-alpha.x`, enhancement 0002 / D14): expect breaking changes in any release.

**Current state:** carries the namespace/webhook/admission-policy primitives, the `#RuntimeClass` trait, and a fork of the five workload transformers (daemonset, deployment, statefulset, job, cronjob).

## Layout

The CUE module lives under `src/` — both the catalog package files and `cue.mod/` sit there, so `src/` is the module root and the import path stays `opmodel.dev/catalogs/opm_experimental@v1`.

```text
src/cue.mod/module.cue   CUE module manifest — opmodel.dev/catalogs/opm_experimental@v1
src/catalog.cue          catalog manifest (c.#Catalog; empty transformers for now)
src/identity/            ModulePath + Version (publish-time stamping anchor)
src/INDEX.md             generated definition index
```

## Dependencies

- `opmodel.dev/core@v1` — the OPM schema this catalog instantiates.
- `opmodel.dev/catalogs/opm@v1` — the stable catalog, for its `resources`, `traits`, and Kubernetes `schemas` packages.
- `cue.dev/x/k8s.io@v0` — vendored Kubernetes types.

This catalog **depends on** `catalog_opm` rather than duplicating it. The two are still parallel in purpose — new primitives are trialled here — but reusing the stable catalog's resource and trait packages avoids forking `#ContainerResource`, `#Volumes`, `#SecurityContext` and friends just to add one field.

The dependency is one-way: `catalog_opm` does not know this catalog exists. A primitive here can therefore never change what a stable transformer emits — see the workload-transformer note in [`CLAUDE.md`](CLAUDE.md).

## Release lifecycle

Independent release cadence driven by [release-please](https://github.com/googleapis/release-please): conventional commits open a release PR; merging tags `vX.Y.Z` and the same run publishes via publish-time version stamping (`task publish`) to `ghcr.io/open-platform-model`.

## Common commands

```bash
task fmt             # format CUE files
task vet             # validate the catalog package
task generate:index  # regenerate src/INDEX.md
task check           # fmt check + vet + INDEX freshness
task publish VERSION=v0.1.0   # stamp + publish the CUE module (CI does this on release)
```
