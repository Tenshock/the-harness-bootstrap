Biggest missing: observable proof and maintenance confidence—not more tools.

## Highest impact

1. **Visible end-to-end demo**

Add 60–90 second recording showing:

```text
clone → bootstrap → BMAD brief → handoff → Spec Kit feature → implementation
```

Also provide one small completed example repository. Claims need observable outcome.

2. **Automated compatibility evidence**

Current support table has checkmarks without linked proof. Add CI validating:

- Nix evaluation/build
- cleanup behavior
- BMAD + Spec Kit coexistence
- generated adapter files
- shared skill links
- MCP initialization and tool discovery where possible

3. **Stable releases**

Publish `v0.1.0` containing:

- supported agent versions
- pinned BMAD/Spec Kit versions and Serena compatibility
- validated platforms
- upgrade notes
- known limitations

Users need tags they can pin instead of following `main`.

4. **Distribution**

Add GitHub topics:

```text
ai-agents
coding-agents
mcp
nix
bmad
spec-kit
serena
agentic-development
developer-tools
```

Then submit real integration/example links to BMAD, Spec Kit, and Serena communities.

## Not currently needed

- more supported agents
- more MCP servers
- larger documentation hierarchy
- autonomous orchestration
- branding overhaul

Viral needs shareable demo. Wide adoption needs one-command onboarding, proof, releases, and maintenance confidence.
