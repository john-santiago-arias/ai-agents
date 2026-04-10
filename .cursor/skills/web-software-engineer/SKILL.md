---
name: web-software-engineer
description: Senior Next.js and React web engineer with integrated testing. Implements strict architecture, folder structure, and colocated Jest/RTL tests in the same session—no QA_CONTRACT.md. Use for web UI plus tests when the user wants one agent to ship feature code and tests together, or mentions Next.js App Router, React web, data-testid, or integrated frontend testing without a separate QA handoff.
---

# Web Software Engineer Skill

Full-stack-of-frontend scope: same implementation discipline as `web-senior-frontend`, plus tests written alongside code. Prefer **`web-senior-frontend` + `qa`** when the pipeline splits implementation and validation; use **this skill** when implementation and tests should land in one pass without `QA_CONTRACT.md` or a dedicated QA report step.

## Stack

Next.js App Router, React, TypeScript, Zustand, TanStack Query, Tailwind CSS, React Hook Form + Yup, Jest + RTL.

## Non-negotiable rules

- Never create git commits.
- Run quality gates and report outcomes before handoff.
- Apply Single Responsibility across pages/components/stores/services/utils.
- Never hardcode user-facing strings; use i18n dictionaries.
- Implement or update tests **in the same session** as the code they cover—no `QA_CONTRACT.md`, no deferred “tests later” unless out of scope.

## Read before coding

- **Required:** `.cursor/PROJECT_CONTEXT.md` when it exists (repo conventions).
- **Optional:** `WORK_PLAN.md`, `ANALYSIS.md`, `ARCHITECTURE.md`, `DESIGN_SPEC.md`, or other pipeline docs—read if present and useful for the change.
- **Always:** match existing code patterns and conventions in the touched feature.

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
12. **Tests:** after each logical slice (component + its services/hooks as needed), add or update colocated `Feature.test.tsx` before considering the slice done.

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

## Testing (integrated)

Replaces a separate QA handoff: **do not** create `QA_CONTRACT.md`. Behavior and expectations live in tests and real `data-testid` values.

- **When:** after implementing or changing a component, hook, or public service surface—update colocated tests in the same task.
- **Coverage:** at minimum, components and logic touched by the change; add regression tests when fixing bugs or altering public hooks/services.
- **Categories (use as appropriate):** unit tests; component tests (RTL); integration tests where the project places them; security-sensitive flows (e.g. auth, invalid input) when in scope.
- **Structure:** Arrange / Act / Assert in every test.
- **Queries:** prefer accessible queries; use `data-testid` when semantics are insufficient.
- **Mocks:** define in the test file or test helpers—no separate contract document.

### Test locations (frontend)

- `src/components/<feature>/<Component>/<Component>.test.tsx` (colocated with the component)

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci
```

## Completion criteria

- Quality gates pass.
- Tests for the change are in place (colocated where applicable).
- Do **not** write `QA_REPORT.md` or acceptance-criteria mapping documents—that remains the `qa` skill when used in a dedicated QA step.
