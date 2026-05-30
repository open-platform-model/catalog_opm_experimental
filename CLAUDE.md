# catalog_opm_experimental repository guide

## Purpose

This repo defines and publishes the **OPM experimental catalog** as a versioned CUE module (`opmodel.dev/catalogs/opm-experimental@v0`).

It is the staging ground for new OPM Kubernetes building blocks — `#Resource`s, `#Trait`s, `#Blueprint`s, and `#ComponentTransformer`s — that are being trialled before (or instead of) being ported into the stable `opmodel.dev/catalogs/opm` catalog (the `catalog_opm` repo). It is typed only against the `core` schema — it does NOT depend on `catalog_opm`.

This is a pure CUE repository. No Go code.

**Current state: skeleton.** `src/catalog.cue` carries an empty `#transformers` map and there are no resources/traits/blueprints/transformers yet. The scaffolding (module, identity, Taskfile, CI, release-please) mirrors `catalog_opm` so adding content is a matter of dropping files in and registering transformers.

## Relationship to other repos

This is its **own independent catalog** — it does NOT depend on `catalog_opm`. Both catalogs sit side by side, each typed only against `core`.

- **`catalog_opm`** (`opmodel.dev/catalogs/opm@v0`) — the stable catalog. A separate, parallel catalog; mature primitives may be promoted there by porting, not by dependency.
- **`core`** (`opmodel.dev/core@v0`) — the schema everything is typed against. The only OPM dependency.
- **`catalog/`** (legacy, deprecated/read-only) — old multi-domain catalog; reference only when authoring future provider catalogs.

## Repository Layout

```text
src/cue.mod/module.cue   CUE module manifest — opmodel.dev/catalogs/opm-experimental@v0
src/catalog.cue          catalog manifest (bare c.#Catalog; empty transformers for now)
src/identity/            ModulePath + Version (publish-time stamping anchor)
src/INDEX.md             generated definition index (ships inside the CUE module)
.tasks/                  Taskfile script fragments (index + branch-tag)
```

`src/` is the CUE module root. Internal imports resolve as `opmodel.dev/catalogs/opm-experimental/...` relative to it. A breaking revision bumps the module major (`@v0` → `@v1`).

## Dependencies

- `opmodel.dev/core@v0` — the OPM schema this catalog instantiates. The only OPM dependency.
- `cue.dev/x/k8s.io@v0` — vendored Kubernetes types.

`cue vet` needs a reachable registry. Export the workspace registry vars from the root `CLAUDE.md` (`CUE_REGISTRY`, `OPM_REGISTRY`) before running raw `cue` outside `task`.

## Version Stamping

Same publish-time stamping as `catalog_opm`: the committed tree resolves `identity.Version` to the `0.0.0-dev` sentinel; `task publish VERSION=vX.Y.Z` stamps a concrete version into a transient build dir and publishes. Never hand-edit `metadata.version` — change `identity` or pass `VERSION`.

## Adding content

1. Add `resources/`, `traits/`, `blueprints/`, and/or `transformers/` packages under `src/` (follow the `catalog_opm` patterns; import `id "opmodel.dev/catalogs/opm-experimental/identity"`).
2. Register each transformer in `src/catalog.cue`'s `#transformers` map, keyed by `metadata.fqn`. Resources/traits/blueprints surface transitively via transformer required/optional maps.
3. `task generate:index` to refresh `src/INDEX.md`.
4. `task check` (fmt + vet + INDEX freshness) before finishing.

## Build And Dev Commands

| Command                       | Purpose                                              |
| ---                           | ---                                                  |
| `task fmt` / `task fmt:check` | Format CUE files / verify formatting                 |
| `task vet`                    | Validate the catalog package                         |
| `task generate:index`         | Regenerate `src/INDEX.md`                            |
| `task check`                  | fmt check + vet + INDEX freshness                    |
| `task publish VERSION=vX.Y.Z` | Stamp + publish the catalog (CI does this on release)|

### Release & publishing

Same flow as `catalog_opm`: release-please opens the release PR; merging tags `vX.Y.Z` and the same run publishes via `task publish` to `ghcr.io/open-platform-model`. `branch-publish.yml` publishes `-dev` pre-releases on non-main branches.
