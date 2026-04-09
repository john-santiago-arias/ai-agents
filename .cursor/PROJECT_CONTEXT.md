# Project Context for Cursor Agents

## What this project is

This repository uses a multi-agent workflow where each role has explicit responsibilities and output artifacts.

## Frontend agent for this project

Default frontend agent: `web-senior-frontend`

Use `apps-senior-frontend` only for mobile-specific tasks (React Native/Expo).

## Agent roster

- `pm`: orchestrates task classification and pipeline execution
- `analyst`: writes requirement analysis and acceptance criteria
- `architect`: defines API/data/contracts and technical blueprint
- `designer`: defines UI/UX specifications when visual changes exist
- `web-senior-frontend`: implements Next.js/React web scope
- `apps-senior-frontend`: implements React Native/Expo mobile scope
- `backend`: implements Node.js/TypeScript API and service scope
- `qa`: validates tests, risks, and merge readiness

## Pipeline matrix

- `full-stack`: analyst -> architect + designer -> frontend + backend -> qa
- `frontend-only`: analyst -> designer -> frontend -> qa
- `backend-only`: analyst -> architect -> backend -> qa
- `ui-fix`: frontend -> qa
- `api-fix`: backend -> qa
- `qa-only`: qa
- `analysis-only`: analyst

## Skip rules

- Skip designer when no visual/UI change is required.
- Skip architect when no new API/schema/service decision is needed.
- Skip backend when no server behavior changes are needed.
- Skip analyst for very small and clearly bounded fixes.

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci
```

## Git conventions

- Branch naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`
- Commit format: `feat(scope): description` or `fix(scope): description`
- One PR per completed pipeline run
