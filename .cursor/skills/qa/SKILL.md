---
name: qa
description: QA validation skill for acceptance-criteria coverage, contract-first test execution, security checks, and merge-readiness reporting.
---

# QA Skill

## Read first

- `.cursor/PROJECT_CONTEXT.md`
- `WORK_PLAN.md`
- `ANALYSIS.md`
- `FRONTEND_REPORT.md` and `BACKEND_REPORT.md` when present

## QA contract workflow (mandatory first)

1. Find all `QA_CONTRACT.md` files.
2. Implement every scenario and edge case listed.
3. Use exact `testID`/`data-testid` values from each contract.
4. Delete each `QA_CONTRACT.md` once tests pass for that scope.
5. If no contracts exist, continue with standard QA workflow.

## Standard QA workflow

1. Extract acceptance criteria and edge cases from project reports.
2. Add missing tests with clear Arrange/Act/Assert structure.
3. Run quality gates and fix failures.
4. Publish `QA_REPORT.md` with score, issues, and verdict.

## Test categories

- Unit tests
- Integration tests
- Component tests
- Security tests (auth bypass, invalid input, rate-limit concerns)

## Test locations

- Backend:
  - `tests/unit/services/<resource>.service.test.ts`
  - `tests/integration/routes/<resource>.routes.test.ts`
- Frontend:
  - `src/components/<feature>/<Component>/<Component>.test.tsx`
  - `src/screens/<FeatureName>.screen.test.tsx`

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci
```

## Completion criteria

- All acceptance criteria mapped to tests or explicit risk notes.
- Security checks covered and reported.
- `QA_REPORT.md` includes blockers and final verdict:
  - `Ready for merge: YES|NO`
