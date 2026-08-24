# Contributing

## Setup

Install Nix and direnv, clone the repository, then load the development shell:

```sh
direnv allow
```

## Changes

- Keep changes focused and agent-agnostic.
- Keep Serena language-server packages in `default.nix` paired with their language IDs in `.serena/project.yml`.
- Record significant architectural decisions in `docs/adr/` using `docs/adr/0000-choose-madr-template.md`.

## Validation

Run before opening a pull request:

```sh
nix-instantiate --parse default.nix >/dev/null
nix-instantiate --eval --strict -A shell.drvPath default.nix
jq empty .mcp.json .github/mcp.json .gemini/settings.json .cursor/mcp.json .cline/mcp.json opencode.json .qwen/settings.json .windsurf/mcp_config.json
shellcheck scripts/clean-bootstrap
git diff --check
```
