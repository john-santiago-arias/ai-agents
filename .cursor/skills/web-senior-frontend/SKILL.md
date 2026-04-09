---
name: web-senior-frontend
description: Senior Next.js and React web implementation skill. Use for web UI tasks requiring strict architecture, folder structure, component body order, and QA handoff.
---

# Web Senior Frontend Skill

## Stack

Next.js App Router, React, TypeScript, Zustand, TanStack Query, Tailwind CSS, React Hook Form + Yup, Jest + RTL.

## Non-negotiable rules

- Never create git commits.
- Run quality gates and report outcomes before handoff.
- Apply Single Responsibility across pages/components/stores/services/utils.
- Never hardcode user-facing strings; use i18n dictionaries.

## Read before coding

1. `.cursor/PROJECT_CONTEXT.md`
2. `WORK_PLAN.md`, `ANALYSIS.md`
3. `ARCHITECTURE.md`, `DESIGN_SPEC.md` (if present)
4. Existing code patterns and conventions

## Implementation order (strict)

1. Types (`ComponentName.types.ts`)
2. Helpers (`ComponentName.helpers.ts`)
3. Styles strategy (inline by default; extracted constants when reused)
4. Service (`<feature>.service.ts`)
5. Service types (`<feature>.service.types.ts`)
6. Query hooks (`<feature>.service.hooks.ts`)
7. Store (`<feature>.store.ts`)
8. Store types/helpers
9. Server page/layout shell
10. Client components only where interactivity is needed
11. Forms with RHF + yupResolver

## Folder structure (non-negotiable)

```text
src/
  app/(group)/route/page.tsx
  components/<feature>/FeatureContainer/
    Feature.tsx
    Feature.types.ts
    Feature.helpers.ts
    Feature.test.tsx
  services/<feature>/
    <feature>.service.ts
    <feature>.service.types.ts
    <feature>.service.hooks.ts
  stores/<feature>/
    <feature>.store.ts
    <feature>.store.types.ts
    <feature>.store.helpers.ts
```

## Component body order (strict)

1. Props destructuring
2. Library hooks (`useRouter`, etc.)
3. Store selectors / data hooks
4. Custom hooks
5. Local state
6. Derived values/constants
7. Dependent hooks
8. Handlers
9. Effects/subscriptions
10. `return` view only

- Extract complex logic out of `return`.
- Max 300 lines per file; split when needed.

## File-type rules

- `.types.ts`: interfaces/types only.
- `.helpers.ts`: pure functions only (no hooks/JSX).
- `.tsx`: avoid business logic in render blocks.
- Use `import type` for type-only imports.

## Next.js and data rules

- Server components by default.
- Add `"use client"` only for interactivity/browser APIs.
- Keep query keys stable and invalidate after mutations.
- Keep API calls in services and data hooks.

## TypeScript and quality

- No implicit `any`.
- Explicit typing for props, payloads, responses, and state.
- Respect project aliases and lint/prettier conventions.

## Accessibility and testability

- Interactive elements must expose `data-testid`.
- Use semantic queries in tests and preserve a11y labels/roles.

## QA handoff (mandatory)

For affected components, create `QA_CONTRACT.md` including:
- data-testid table
- scenarios
- edge cases
- accessibility checks
- required mocks

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci
```
