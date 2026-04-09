---
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep
description: "Frontend + QA pipeline. Invokes the correct frontend agent (web or mobile) followed immediately by the QA agent. Use when you need implementation + full test coverage in one flow, without analyst, designer, or architect. Usage: /dev <what to build or fix>"
---

Run the frontend + QA pipeline for this task:

$ARGUMENTS

## Step 1 — Identify frontend agent

Read `CLAUDE.md` → `## Frontend agent for this project`:
- `apps-senior-frontend` → mobile (React Native / Expo)
- `web-senior-frontend` → web (Next.js / React)
- If the user names an agent explicitly → use that one

## Step 2 — Invoke frontend agent

Invoke the chosen frontend agent with the full task description. Wait for it to complete and pass quality gates before proceeding.

## Step 3 — Invoke QA agent

Invoke @agent-qa with this context:
- Task: `$ARGUMENTS`
- Ensure full test coverage on all files touched, covering every acceptance criterion and edge case

## Step 4 — Report

- Frontend agent used: `<name>`
- Files implemented: `<n>`
- Test files written: `<n>`
- Verdict: Ready for merge | Blockers: `<list>`

No PR is created — use /feature or @agent-pm for the full pipeline with PR.
