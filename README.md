# The Harness Bootstrap

A minimal, agent agnostic, application-stack-agnostic development harness with shared skills and project instructions.

[Quick start](#quick-start) · [Supported agents](#supported-agents) · [Workflow](#bmad-to-spec-kit-workflow) · [Roadmap](./ROADMAP.md) · [Contributing](#contributing-and-license)

## Quick Start

### For fresh projects

1. Clone the repository:

   ```sh
   git clone https://github.com/Tenshock/the-harness-bootstrap.git my-project
   cd my-project
   ```

2. Choose an environment entry point:

   - **Local Nix shell:** install [Nix](https://nixos.org/download/). [direnv](https://direnv.net/docs/installation.html) is optional.
   - **Dev Container:** install Docker and use a [Dev Container](https://containers.dev/) compatible client, then reopen the repository in its container.

3. Preview the changes, then initialize the project:

   ```sh
   nix-shell --run 'scripts/clean-bootstrap --dry-run my-project'
   nix-shell --run 'scripts/clean-bootstrap my-project'
   ```

   The bootstrap personalizes the repository, initializes Spec Kit and BMAD Method, validates the generated state, and removes itself.

4. Launch any supported agent and invoke `bmad-product-brief`.

### For existing projects

> Adoption into existing repositories is planned in the [roadmap](./ROADMAP.md).

## Supported agents

> A checkmark means the repository provides the corresponding configuration or shared integration.

| Agent          | Shared instructions | Shared skills | Serena MCP | Pinned Spec Kit | Pinned BMAD |
| -------------- | :-----------------: | :-----------: | :--------: | :-------------: | :---------: |
| Codex          |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Claude Code    |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| GitHub Copilot |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Gemini CLI     |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Cursor         |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Cline          |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| opencode       |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Qwen Code      |         ✅          |      ✅       |     ✅     |       ✅        |     ✅      |
| Windsurf       |         ✅          |      ✅       |    ✅¹     |       ❌        |     ✅      |

[AGENTS.md](./AGENTS.md) is the canonical repository-wide instruction file.  
[.agents/skills](./.agents/skills/) is the canonical shared skills directory.

> ¹: Windsurf requires copying or merging `.windsurf/mcp_config.json` into `~/.codeium/windsurf/mcp_config.json`, its documented user-level MCP configuration path.

## How it works

### Sources of truth

| Concern             | Owner or source           |
| ------------------- | ------------------------- |
| Toolchain           | `default.nix` and `npins` |
| Instructions        | `AGENTS.md`               |
| Skills              | `.agents/skills`          |
| Semantic navigation | Serena                    |
| Product planning    | BMAD                      |
| Feature delivery    | Spec Kit                  |

### Development environment

Nix defines and owns the project toolchain. Developers use one of two environment entry points:

- Local Nix shell: run nix-shell; direnv can load the environment automatically.
- Dev Container: enter the container, which uses the same repository-defined Nix toolchain.

### Planning and delivery

[Serena](https://oraios.github.io/serena/01-about/000_intro.html) gives agents LSP-backed symbols, definitions, references, implementations, and diagnostics. Repository search covers configuration and cross-language relationships outside LSP scope. Each MCP adapter launches Serena through UV from its current upstream source.

[BMAD](https://github.com/bmad-code-org/BMAD-METHOD) handles product discovery, requirements, UX direction, cross-cutting architecture, and optional backlog decomposition. It hands one approved, independently testable delivery slice to Spec Kit.

[Spec Kit](https://github.com/github/spec-kit) turns each approved BMAD slice into a feature specification, implementation plan, task breakdown, implementation, and convergence validation.

## BMAD to Spec Kit workflow

1. Use `bmad-product-brief`, `bmad-prd`, optional `bmad-ux`, and `bmad-architecture` for strategy. Use `bmad-create-epics-and-stories` only when backlog decomposition adds value.
2. Approve one independently testable delivery slice.
3. Start `speckit-specify` with the relevant BMAD source paths and stable capability, epic, or story identifiers.
4. Continue with optional `speckit-clarify`, then `speckit-plan`, `speckit-tasks`, `speckit-analyze`, `speckit-implement`, and `speckit-converge`.

Do not run `bmad-spec`, BMAD sprint tracking, or BMAD build workflows for work handed to Spec Kit. Spec Kit owns feature-local specification, planning, tasks, implementation, and convergence.

## Generated state and safety

The bootstrap runs the pinned Specify CLI before the pinned BMAD Method installer. Both generate namespaced Agent Skills under the canonical `.agents/skills` directory without asking which agent the project uses. Existing links expose those skills through the supported agent-specific paths.

Specify and BMAD internally use their `codex` adapter IDs because those adapters emit the shared Agent Skills layout. The bootstrap passes `--ignore-agent-tools`, does not require Codex, and does not generate optional agent-specific command files. The adapter IDs remain recorded in upstream manifests so later upgrades use the same layout.

Generated project state includes `.specify`, `_bmad`, `_bmad-output`, Spec Kit skills, and BMAD `bmm` skills. The command refuses to overwrite an existing Spec Kit or BMAD installation. `--force` only permits a dirty Git worktree. Review generated files before committing them in the consuming project.

If initialization or validation fails, the bootstrap restores the original template files and removes newly generated workflow state.

## Maintenance

Preview and apply all supported dependency updates from the loaded Nix shell:

```sh
nix-shell --run 'scripts/update-dependencies --dry-run'
nix-shell --run 'scripts/update-dependencies'
```

The script updates nixpkgs and BMAD Method together. It regenerates the BMAD npm dependency hash, validates Serena's UV launcher and the resulting configuration, and restores changed dependency files if validation fails. Spec Kit updates through nixpkgs. Serena follows its current upstream source when UV refreshes its cache. Review upstream release notes before applying an update.

Do not use mutable global Specify or BMAD installations as repository sources of truth.

## Contributing and license

See [CONTRIBUTING.md](./CONTRIBUTING.md). This project is licensed under the [MIT License](./LICENSE).
