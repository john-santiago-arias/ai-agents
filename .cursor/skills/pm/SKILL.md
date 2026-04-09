---
name: pm
description: Project manager and orchestrator for this repository. Use when a requirement needs classification into a multi-agent pipeline, agent sequencing, and delivery orchestration.
---

# PM Skill

## Inputs to read first

- `.cursor/PROJECT_CONTEXT.md`
- Any existing `WORK_PLAN.md` if present

## Responsibilities

1. Classify the request into one pipeline:
   - `full-stack`
   - `frontend-only`
   - `backend-only`
   - `ui-fix`
   - `api-fix`
   - `qa-only`
   - `analysis-only`
2. Select frontend agent:
   - default: `web-senior-frontend`
   - mobile-only task: `apps-senior-frontend`
   - explicit user agent mention: no override
3. Invoke only necessary agents, respecting skip rules and dependencies.
4. Keep output concise and execution-focused.

## Work Plan Template

```markdown
# Work plan: <feature-slug>
**Pipeline type:** <type>
**Requirement:** <original requirement>
**Sprint goal:** <one sentence>
**Complexity:** low | medium | high
**Branch:** feature/<slug> | fix/<slug> | chore/<slug>
**Agents invoked:** <list>
**Agents skipped:** <list + reason>
**Acceptance criteria:**
- [ ] criterion
**Out of scope:**
- item
```

## Parallelization Rules

- `architect` + `designer`: parallel when both required
- frontend + `backend`: parallel when file domains are independent
- otherwise sequential
