# Project context for Claude Code

## What this project is

<!-- ✏️ CUSTOMIZE: Describe the project — type (web/mobile/full-stack), main purpose, and primary tech (e.g. "React Native + Expo mobile app for X" or "Next.js web app for Y"). -->

This is a [web | mobile] application built with [framework]. A multi-agent team operates on this codebase. Each agent has a specific role and reads this file before starting work.

## Frontend agent for this project

<!-- ✏️ CUSTOMIZE: Set ONE default. Remove the other line. -->

**Default frontend agent:** `web-senior-frontend` ← Next.js / React web projects

<!-- **Default frontend agent:** `apps-senior-frontend` ← React Native / Expo mobile projects -->

The PM reads this section in Step 0 before routing any task.

## Agent roster

| Agent                   | Role                                                                              |
| ----------------------- | --------------------------------------------------------------------------------- |
| `pm`                    | Receives requirements, writes WORK_PLAN.md, orchestrates the team                 |
| `analyst`               | Translates requirements into user stories, entities, and risk flags → ANALYSIS.md |
| `designer`              | Defines UI/UX specs and design tokens → DESIGN_SPEC.md                            |
| `architect`             | Designs API contracts, DB schema, folder structure → ARCHITECTURE.md              |
| `web-senior-frontend`   | Next.js App Router / React web implementation                                     |
| `apps-senior-frontend`  | React Native / Expo mobile implementation                                         |
| `backend`               | Node.js / TypeScript API and DB implementation → BACKEND_REPORT.md                |
| `qa`                    | Writes tests, audits acceptance criteria → QA_REPORT.md                           |
| `web-software-engineer` | Next.js App Router / React web implementation / Writes tests                      |
| `app-software-engineer` | React Native / Expo mobile implementation / Writes tests                          |

## How to start a pipeline

```
@agent-pm New requirement: [describe what you want built]
```

The PM will classify the task, write `WORK_PLAN.md`, and invoke the needed agents in sequence. Or use a slash command shortcut:

| Command           | Use when                                             |
| ----------------- | ---------------------------------------------------- |
| `/feature <req>`  | New feature needing UI + API + DB                    |
| `/frontend <req>` | UI-only changes, no new endpoints                    |
| `/backend <req>`  | API/service/DB only, no UI                           |
| `/fix <desc>`     | Small bug or tweak with clear scope                  |
| `/dev <task>`     | Implementation + tests in one flow, no full pipeline |
| `/spec <topic>`   | Research or spec only — no code written              |
| `/qa <scope>`     | Add missing tests to existing code                   |

## Agent routing (PM must follow)

### Step 0 — Frontend agent selection

Check `## Frontend agent for this project` above:

- Mobile project → `apps-senior-frontend`
- Web project → `web-senior-frontend`
- User names an agent directly → use that agent, no override

### Pipeline selection

Replace `<FE>` with the chosen frontend agent.

| Condition                                 | Pipeline        | Agents                                                 |
| ----------------------------------------- | --------------- | ------------------------------------------------------ |
| New feature with UI + API + DB            | `full-stack`    | analyst → architect + designer → `<FE>` + backend → qa |
| UI-only: new screen, component, restyling | `frontend-only` | analyst → designer → `<FE>` → qa                       |
| API-only: endpoint, migration, service    | `backend-only`  | analyst → architect → backend → qa                     |
| Small UI fix, clear scope, no new API     | `ui-fix`        | `<FE>` → qa                                            |
| Small API fix, clear scope                | `api-fix`       | backend → qa                                           |
| Missing tests only                        | `qa-only`       | qa                                                     |
| Research / spec / no code                 | `analysis-only` | analyst                                                |

### Skip rules

- **Skip designer** when: no new screens, no new components, no visual changes
- **Skip architect** when: no new endpoints, no DB schema changes, no new services
- **Skip backend** when: no API changes — frontend reads existing endpoints only
- **Skip analyst** when: scope is fully clear and bounded (fixes, small tweaks)

### Parallel dispatch (only when file domains don't overlap)

- architect + designer → always parallel (different output files)
- `<FE>` + backend → always parallel (independent file directories)
- Never parallelize when agent B needs agent A's output

## Git conventions

<!-- ✏️ CUSTOMIZE: Adjust if your project uses different branch prefixes or commit formats. -->

- Branch naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`
- Commit format: `feat(scope): description` / `fix(scope): description`
- One PR per agent pipeline run

## Quality gates

<!-- ✏️ CUSTOMIZE: Replace with your project's package manager (yarn / pnpm / npm) and exact script names. -->

```bash
yarn check-types   # tsc --noEmit — MUST pass
yarn lint          # MUST pass
yarn test:ci       # MUST pass — coverage minimum 80%
```

## Project-specific rules

<!-- ✏️ CUSTOMIZE: Add any project-specific non-negotiable rules all agents must follow.
     Examples:
     - All user-facing strings must use i18n keys from src/i18n/
     - API base URL comes from NEXT_PUBLIC_API_URL env var — never hardcoded
     - Feature flags live in src/config/flags.ts
-->
