# Roadmap

The harness should support new projects first, then existing projects without a harness, and finally projects that already contain an earlier or customized harness.

## Principles

- Keep Nix and pinned sources as the canonical toolchain.
- Keep `AGENTS.md` and `.agents/skills` as canonical shared agent surfaces.
- Preview changes before writing and never overwrite unrelated project files by default.
- Record harness version, adoption mode, selected agents, and managed paths in a project manifest.
- Make interrupted adoption recoverable and validate the resulting agent configuration before reporting success.

## 1. Greenfield projects

Build on the current cloned-template flow and make it the first stable CLI workflow.

```sh
harness init --project-name my-project --agents all
harness init --project-name my-project --agents codex,claude-code,cursor
```

The CLI should:

- personalize a fresh harness checkout;
- install shared Spec Kit and BMAD skills;
- generate support for all agents by default or only the explicitly selected agents;
- validate Nix, generated workflow state, instructions, skills, and MCP configuration;
- write the project manifest only after successful validation.

The existing `scripts/clean-bootstrap` command remains the greenfield foundation until the CLI provides equivalent behavior and rollback.

## 2. Brownfield projects without a harness

Add a harness to an existing application repository that has no recognized harness manifest or managed harness files.

```sh
harness adopt --agents all
harness adopt --agents codex,gemini,opencode
```

The CLI should:

- inspect repository instructions, existing agent configuration, toolchain files, and conflicting paths before writing;
- provide `--dry-run` output listing additions, merges, conflicts, and unsupported existing configuration;
- add the Nix shell, shared instructions, shared skills, selected adapters, and MCP configuration without replacing application tooling;
- merge compatible existing instructions and configuration through explicit, format-aware operations;
- stop on ambiguous or destructive conflicts and leave the repository unchanged;
- initialize Spec Kit and BMAD only after the harness files pass validation;
- record every managed path in the project manifest for later reconciliation.

No agent should be inferred from installed binaries. `--agents all` remains the default; an explicit list is authoritative.

## 3. Brownfield projects with an existing harness

Support repositories containing a current manifest, an older or customized version of this harness, or another recognizable agent harness.

```sh
harness reconcile
harness reconcile --agents all
harness reconcile --agents codex,claude-code --prune-agents
```

The CLI should:

- compare manifest state, current files, and target harness version;
- inventory third-party or manifest-less harness files before claiming ownership of any path;
- distinguish managed files, local modifications, missing files, and unmanaged collisions;
- preview migrations and agent-support changes before writing;
- preserve local edits through format-aware merges or stop with actionable conflicts;
- add newly selected agents without disturbing existing ones;
- remove deselected agent files only with explicit `--prune-agents`;
- migrate Spec Kit, BMAD, Serena, Nix, and adapter configuration in dependency order;
- create a baseline manifest for imported harnesses only after their managed scope is explicitly established;
- update the manifest only after full validation and roll back managed changes on failure.

## Agent selection contract

The same option applies to `init`, `adopt`, and `reconcile`:

```text
--agents all
--agents <comma-separated-agent-ids>
```

Initial agent IDs:

```text
codex
claude-code
github-copilot
gemini
cursor
cline
opencode
qwen
windsurf
```

- `all` expands to the supported agent set shipped by the installed harness release.
- Explicit lists generate only the selected instruction links, skill links, MCP adapters, and other required integration files.
- Shared Spec Kit and BMAD skills remain single-copy content under `.agents/skills`; selection must not duplicate workflow skills per agent.
- Unknown IDs, duplicates, empty lists, and unsupported combinations fail before any write.
- Known capability limitations must be shown during preview and validation; selecting an agent must not imply unsupported features.
- Reconciliation never removes deselected agent support unless `--prune-agents` is present.

## Delivery order

1. Stabilize greenfield CLI behavior and agent selection.
2. Implement brownfield adoption without an existing harness.
3. Implement manifest-driven reconciliation for existing harness installations.
4. Add end-to-end compatibility CI for every mode and supported agent selection.
