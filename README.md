# OPM experimental catalog

The staging catalog for the Open Platform Model. `catalog_opm_experimental` is where new `#Resource`s, `#Trait`s, `#Blueprint`s, and `#ComponentTransformer`s are trialled before (or instead of) graduating into the stable catalog (`catalog_opm` / `opmodel.dev/catalogs/opm@v0`).

This repository is a single CUE module, `opmodel.dev/catalogs/opm-experimental@v0`, published to `ghcr.io/open-platform-model/catalogs/opm-experimental` and consumed via `import "opmodel.dev/catalogs/opm-experimental@v0"` (package `opm_experimental`).

The module is pre-1.0 and explicitly experimental: expect breaking changes in any release.

**Current state:** skeleton — scaffolding only, no catalog content yet.

## Layout

The CUE module lives under `src/` — both the catalog package files and `cue.mod/` sit there, so `src/` is the module root and the import path stays `opmodel.dev/catalogs/opm-experimental@v0`.

```text
src/cue.mod/module.cue   CUE module manifest — opmodel.dev/catalogs/opm-experimental@v0
src/catalog.cue          catalog manifest (c.#Catalog; empty transformers for now)
src/identity/            ModulePath + Version (publish-time stamping anchor)
src/INDEX.md             generated definition index
```

## Dependencies

- `opmodel.dev/core@v0` — the OPM schema this catalog instantiates. The only OPM dependency.
- `cue.dev/x/k8s.io@v0` — vendored Kubernetes types.

This catalog is independent of `catalog_opm` (`opmodel.dev/catalogs/opm`) — they are parallel catalogs, not layered.

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
