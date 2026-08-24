# Repository Instructions

These instructions apply to the entire repository.
This repository provides shared development tooling for agent clients. It is not application code.

## Environment

- Treat `default.nix` and pinned `npins` sources as the canonical project toolchain. Do not assume repository commands are available from the host environment.
- `#!/usr/bin/env bash` selects Bash from the current `PATH`; it does not enter the Nix shell or load `.envrc`.
- Run commands that need repository tooling from an already loaded direnv environment or with `nix-shell --run '<command>'`. Prefer `nix-shell --run` for clone/bootstrap instructions because it needs no direnv authorization.
- Make the project Nix toolchain available before using Serena.
- New or changed `.envrc` files require `direnv allow` by default. A user's direnv whitelist may authorize a directory automatically, so test the loaded environment instead of assuming whether approval was manual. Never make `.envrc` authorize itself or recommend broad trust for directories writable by untrusted repositories.
- MCP adapters that launch through `direnv exec .` require the project `.envrc` to be authorized, either explicitly or by user configuration. Diagnose direnv authorization separately from MCP startup, tool discovery, language-server health, and semantic operations.

## Tool selection

- Use Serena for semantic navigation, symbols, definitions, references, focused edits, and LSP diagnostics.
- Before broad or structural changes, build repository context: read agent instructions, accepted ADRs in `docs/adr/`, architecture docs, manifests, directory structure, and entrypoints; then use Serena to trace relevant symbols, implementations, and references.
- Inspect configuration, CI, generated code, and cross-language wiring with repository search because these relationships may be outside LSP coverage.
- Treat inferred architecture as a hypothesis until confirmed by source, tests, builds, or runtime behavior.
- Keep durable Serena LSP support paired between `default.nix` and `.serena/project.yml`. Use `.serena/project.local.yml` only for machine-local overrides.

## Planning and implementation workflow

- BMAD owns product discovery, product briefs, product requirements documents (PRDs), UX direction, cross-cutting architecture decisions, and optional backlog decomposition.
- Spec Kit owns approved feature specifications, feature-level implementation planning, task breakdown, implementation, and convergence validation.
- Use `handoff-bmad-to-speckit` to transfer one approved, independently testable delivery slice at a time. Preserve source BMAD artifact paths and stable capability, epic, or story identifiers in the Spec Kit feature specification.
- Do not use `bmad-spec`, `bmad-sprint-planning`, `bmad-build`, or `bmad-build-auto` for work handed to Spec Kit. Do not track the same work in both BMAD sprint status and Spec Kit task status.
- When upstream intent changes, update the BMAD-owned artifact first, then explicitly reconcile affected Spec Kit artifacts before implementation continues.

## Architecture decisions

- Create an ADR in `docs/adr/` for each significant architectural decision, including new system boundaries, cross-cutting constraints, and major dependency or tooling choices.
- Copy `docs/adr/0000-choose-madr-template.md` as the template. Name ADR files `NNNN-short-kebab-title.md`, starting at `0001` and incrementing sequentially.
- Do not rewrite accepted ADRs to change a decision; create a new ADR that supersedes the old one.
