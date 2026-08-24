---
name: add-serena-lsp
description: Add or update reproducible Serena LSP support by pairing language-server packages in default.nix with language IDs in .serena/project.yml. Use when adding a language, framework, or language server to this development harness or a project derived from it.
---

# Add Serena LSP

## Inspect

1. Enter the project direnv shell before using Serena.
2. Read `default.nix`, `.serena/project.yml`, and repository instructions.
3. Identify the current Serena language-server ID from Serena documentation or its current project template.
4. Identify the matching executable and package available from the pinned nixpkgs.
5. Check whether Serena starts companion servers. Avoid redundant entries; for example, Svelte includes TypeScript support.

## Implement

1. Add the package or repository-owned derivation to `default.nix`.
2. Add the language ID to `language_servers` in `.serena/project.yml`.
3. Keep both lists ordered consistently with existing entries.
4. Put durable, shared support in both versioned files. Use `.serena/project.local.yml` only for machine-local overrides.
5. Add `ls_specific_settings` only when the server needs durable project settings.
6. Avoid unrelated shell packages, project configuration, and generated Serena state.

## Validate

Run from project root:

```bash
nix-shell --pure --run 'command -v <language-server>'
nix-shell --pure --run 'uvx --from git+https://github.com/oraios/serena serena project health-check .'
nix-shell --pure --run 'nixfmt --check default.nix shell.nix'
git diff --check
```

If repository-local Serena caches or certificate variables are required, preserve existing shell or MCP environment instead of inventing new global state.

Confirm one semantic Serena operation for a file handled by the new server. Report Nix evaluation, executable availability, Serena startup, semantic operation, and non-fatal LSP warnings separately. Do not claim live MCP health from configuration or package presence alone.
