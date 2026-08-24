---
name: handoff-bmad-to-speckit
description: Hand an approved BMAD capability or story to Spec Kit without duplicating strategy, feature planning, implementation, or status ownership. Use after BMAD planning when a bounded delivery slice is ready for specification and implementation.
---

# Hand Off BMAD Work to Spec Kit

## Establish the handoff

1. Read project instructions, relevant BMAD product and architecture artifacts, and Spec Kit constitution.
2. Select one independently testable delivery slice. Split an oversized story or group inseparable small stories instead of preserving unsuitable backlog boundaries.
3. Record source BMAD artifact paths and stable capability, epic, or story identifiers.
4. Confirm scope, acceptance criteria, constraints, non-goals, and dependencies are explicit. Return unresolved product or architecture decisions to BMAD-owned artifacts before continuing.

## Execute with Spec Kit

1. Invoke `speckit-specify` with approved slice and BMAD source references. Ensure resulting feature specification retains those references.
2. Use `speckit-clarify` when requirements remain ambiguous.
3. Continue through `speckit-plan`, `speckit-tasks`, and `speckit-analyze` before implementation.
4. Use `speckit-implement` and `speckit-converge` for implementation and convergence.

## Preserve ownership

- BMAD owns discovery, product briefs, PRDs, UX direction, cross-cutting architecture, and optional backlog decomposition.
- Spec Kit owns approved feature specifications, implementation plans, task breakdowns, implementation, and convergence evidence.
- Do not invoke `bmad-spec`, `bmad-sprint-planning`, `bmad-build`, or `bmad-build-auto` for work handed to Spec Kit.
- Do not maintain BMAD sprint status and Spec Kit task status for same work.
- Do not synchronize artifacts bidirectionally. When strategy changes, update BMAD source first, then explicitly reconcile affected Spec Kit artifacts.
