# ai-agents

Repository for storing specialized AI agents, rules, skills, and workflows for Cursor and Claude.

## What this repository is

This repository is a reusable base that includes:

- specialized agents/roles
- global workflow rules
- role-based skills
- pipeline commands

Goal: reuse this structure in other projects to keep a consistent AI workflow in Cursor and Claude.

## How to reuse it in another project

This is not installed as a package. It is reused by copying folders and config files based on the platform:

- **For Cursor**: copy `.cursor/`.
- **For Claude**: copy `.claude/` and `CLAUDE.md`.
- You can keep both structures (`.cursor` and `.claude`) in parallel in the same project.

After copying, adjust context and conventions for the new repository:

1. Update context files for the selected platform:
   - Cursor: `.cursor/PROJECT_CONTEXT.md`
   - Claude: `CLAUDE.md`
2. Update real project scripts/commands (`yarn`, `pnpm`, `npm`, etc.).
3. Review branch naming, commit format, and deployment constraints.

## Step by step for Cursor

### 1) Copy the base structure

In the target project, copy:

- `.cursor/rules/`
- `.cursor/skills/`
- `.cursor/commands/`
- `.cursor/PROJECT_CONTEXT.md`

### 2) Adjust project context

Edit:

- `.cursor/PROJECT_CONTEXT.md`

Set these values correctly:

- whether the default frontend agent is `web-senior-frontend` or `apps-senior-frontend`
- allowed pipelines
- actual quality gates used by the repository

### 3) Understand how the workflow is triggered

In Cursor, you can work in two ways:

- **By commands**: using files in `.cursor/commands/`
- **By role**: explicitly requesting a role (pm, analyst, architect, frontend, backend, qa)

Commands included in this repository (same as Claude):

- `/feature` -> full-stack
- `/dev` -> frontend + qa

### 4) Recommended workflow (example)

1. Run `/feature <requirement>`.
2. PM classifies the pipeline and defines the plan.
3. Roles run according to the route:
   - `analyst`
   - `architect` + `designer` (if needed)
   - frontend (`web-senior-frontend` or `apps-senior-frontend`) + `backend` (if needed)
   - `qa`
4. Validate quality with:
   - `yarn check-types`
   - `yarn lint`
   - `yarn test:ci`

### 5) Important rules

- Do not create automatic commits without explicit user request.
- Keep clear layer boundaries (frontend/backend/qa) and explicit contracts.
- Do not delete the alternate platform structure when working in dual mode (`.cursor` + `.claude`).

## Step by step for Claude

### 1) Copy the base structure

In the target project, copy:

- `.claude/agents/`
- `.claude/commands/`
- `CLAUDE.md`

### 2) Adjust project context

Edit:

- `CLAUDE.md`

Set these values correctly:

- project type (web/mobile)
- default frontend agent (`web-senior-frontend` or `apps-senior-frontend`)
- pipeline matrix and skip rules
- quality gates used by the repository

### 3) Understand how the workflow is triggered

In Claude, you can work in two ways:

- **By commands**: using files in `.claude/commands/`
- **By role**: explicitly invoking agents in `.claude/agents/`

Commands included in this repository:

- `/feature` -> full-stack
- `/dev` -> frontend + qa

### 4) Recommended workflow (example)

1. Run `/feature <requirement>`.
2. PM classifies the pipeline and writes `WORK_PLAN.md`.
3. Roles run according to the route:
   - `analyst`
   - `architect` + `designer` (if needed)
   - frontend (`web-senior-frontend` or `apps-senior-frontend`) + `backend` (if needed)
   - `qa`
4. Validate quality with:
   - `yarn check-types`
   - `yarn lint`
   - `yarn test:ci`

### 5) Important rules

- Keep agent instructions aligned with `CLAUDE.md`.
- Do not bypass the PM routing logic for multi-step features.
- Do not create automatic commits without explicit user request.

## Optimized usage by work sessions

In both Claude and Cursor, when using a workflow or invoking an "@agent" with a "task to perform," the context, skills, rules, and other elements are loaded with each invocation. If you need to work with one or more agents throughout a work session, the following is recommended:

In the terminal or in a Cursor agent, declare from the beginning which agent to use:

- Claude: `claude --system-prompt "$(cat ~/.claude/agents/apps-senior-frontend.md)"`
- Cursor: Uses "@apps-senior-frontend" for the entire work session.

NOTE ONLY FOR CURSOR: If you don't use all the cursor rules and skills, it's best to delete them and keep only what you will use. That way, each time you open a new agent, it will only load what is necessary, optimizing token usage.

## Main structure in this repository

```text
.claude/
.cursor/
CLAUDE.md
README.md
```

## Usage note

This repository is an operational template. Recommended approach:

1. copy the platform-specific structure into the new project,
2. adapt context and rules to the real domain,
3. run command/role workflows from day one to keep consistency.
