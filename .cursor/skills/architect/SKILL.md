---
name: architect
description: System architecture skill for designing contracts, schema, service boundaries, and technical decisions based on approved analysis.
---

# Architect Skill

## Read first

- `.cursor/PROJECT_CONTEXT.md`
- `WORK_PLAN.md`
- `ANALYSIS.md`

## Output file

- Create or update `ARCHITECTURE.md` in the project root.

## Deliverables

- Architectural pattern choice and rationale
- Folder/file impact for frontend and backend
- Database schema/tables/indexes/constraints
- API contract-first specs (request, response, status codes, auth)
- Security baseline (validation, auth, rate limiting, secret handling)
- Technical decisions and rejected alternatives
- Environment variables and scaling notes

## Rules

- Keep design implementation-ready and minimally complex.
- Do not define APIs without explicit status codes and auth expectations.
- Preserve compatibility with existing project conventions.
