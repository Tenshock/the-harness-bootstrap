# Harness Audit

## Gaps

### 1. Harness lifecycle CLI

Only the fresh-clone `scripts/clean-bootstrap` workflow exists. The repository does not yet provide:

- `harness init`;
- `harness adopt`;
- `harness reconcile`;
- explicit `--agents` selection; or
- a project manifest recording the harness version, adoption mode, selected agents, and managed paths.

Existing repositories therefore cannot safely adopt, upgrade, reconcile, or selectively remove harness-managed files.

### 2. Automated compatibility testing

The repository has no automated test suite or CI workflow. Bootstrap validation currently checks generated paths, configuration syntax, Nix evaluation, and shared skill links. It does not prove that every supported agent can:

- start its configured MCP adapter;
- complete the MCP `initialize` handshake;
- discover tools through `tools/list`; or
- execute a Serena semantic operation.

The supported-agent table therefore demonstrates configuration or shared integration presence, not end-to-end compatibility.

### 3. Unified validation entry point

The repository has no `scripts/validate` command. Validation is split between `scripts/clean-bootstrap`, `scripts/update-dependencies`, and `CONTRIBUTING.md`.

The contributor instructions also omit checks already used by `scripts/update-dependencies`, including ShellCheck for the dependency updater and TOML validation for `.codex/config.toml`. A single validation command should own the complete local contract and serve as the CI entry point.

### 4. Fully reproducible runtime inputs

Nixpkgs and BMAD Method are pinned, but Serena is launched from the unpinned source URL `git+https://github.com/oraios/serena`. A UV cache refresh can therefore change Serena behavior without a repository change.

The Dev Container locks the Nix feature metadata, but its `mcr.microsoft.com/devcontainers/base:ubuntu-24.04` base image uses a mutable tag rather than an image digest.

### 5. Canonical adapter generation

Agent-specific Serena configuration is duplicated across nine committed adapter files. The repository has no canonical adapter schema, template set, or generator.

Current maintenance validation checks configuration syntax and Serena source occurrence. It does not verify semantic equivalence between adapters or detect capability drift.

### 6. Application-level feedback contract

The harness supplies tools, instructions, planning workflows, and semantic navigation. It does not define consuming-project contracts for:

- building;
- testing;
- formatting;
- linting;
- security checks; or
- releases.

It also has no stack-profile mechanism that extends Nix packages and Serena language servers during bootstrap. Projects must add language support manually through the `add-serena-lsp` skill. This boundary may remain intentional, but the current harness is a development foundation rather than a complete application feedback loop.

### 7. Release and observable proof

The repository has no release tags, declared supported agent-version matrix, or validated platform matrix. It also lacks a completed example project and an end-to-end demonstration covering:

```text
clone -> bootstrap -> BMAD brief -> handoff -> Spec Kit feature -> implementation
```

Users can inspect configuration, but they cannot yet pin a stable release or review repeatable compatibility evidence.

## Recommended delivery order

1. Implement manifest-backed `harness init` with explicit agent selection.
2. Add one comprehensive `scripts/validate` entry point.
3. Add fresh-clone compatibility CI, including MCP startup, initialization, tool discovery, and a semantic operation where supported.
4. Implement `harness adopt` for repositories without an existing harness.
5. Implement manifest-driven `harness reconcile` and explicit agent pruning.
6. Pin Serena and the Dev Container base image reproducibly.
7. Generate adapter configuration from one canonical model and test semantic parity.
8. Publish a tagged release with support matrices, known limitations, an example project, and an end-to-end demonstration.

Adding more agents or MCP servers is not a current priority. Lifecycle management, validation evidence, reproducibility, and maintenance confidence provide greater value.
