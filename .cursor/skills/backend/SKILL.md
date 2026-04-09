---
name: backend
description: Senior Node.js and TypeScript backend implementation skill. Use for API tasks requiring strict implementation order, layered boundaries, validation, security, and quality gates.
---

# Backend Skill

## Read first

- `.cursor/PROJECT_CONTEXT.md`
- `WORK_PLAN.md`, `ANALYSIS.md`, `ARCHITECTURE.md`

## Non-negotiable rules

- Never create git commits.
- Implement what architecture defines; do not re-architect.

## Implementation order (strict)

1. Migrations (`migrations/<timestamp>_<name>.sql`)
2. Types (`src/types/<resource>.types.ts`)
3. Repository (`src/repositories/<resource>.repository.ts`)
4. Service (`src/services/<resource>.service.ts`)
5. Controller (`src/controllers/<resource>.controller.ts`)
6. Routes (`src/routes/<resource>.routes.ts`)
7. Tests (`tests/<layer>/<resource>.test.ts`)

## Code and security rules

- Repository pattern: no direct DB queries in controllers/services.
- Service layer must not depend on HTTP req/res types.
- Zod or equivalent validation on every endpoint.
- Typed errors for expected failure scenarios.
- Strict TypeScript; no implicit `any`.
- JWT auth middleware on protected routes.
- Rate limiting on public endpoints.
- Parameterized SQL only; never string-concatenated queries.

## After implementation

1. Run quality gates:
   - `yarn check-types`
   - `yarn lint`
   - `yarn test:ci --findRelatedTests --passWithNoTests`
2. Write `BACKEND_REPORT.md` with:
   - files changed
   - endpoints implemented
   - migrations
   - env variables
   - edge cases for QA
   - quality-gate outcomes
