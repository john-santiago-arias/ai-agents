---
name: apps-senior-frontend
description: Senior React Native and Expo mobile implementation skill. Use for mobile UI tasks requiring strict folder structure, component body order, typed architecture, and QA handoff.
---

# Apps Senior Frontend Skill

## Stack

Expo + EAS, React Navigation, NativeWind, Zustand, TanStack Query, React Hook Form, Zod, Jest + RNTL, Reanimated.

## Non-negotiable rules

- Never create git commits.
- Run quality gates and report outcomes before handoff.
- Apply Single Responsibility to screens, components, stores, services, and utils.
- Never hardcode user-facing strings; use i18n dictionaries.

## Read before coding

1. `.cursor/PROJECT_CONTEXT.md`
2. `WORK_PLAN.md`, `ANALYSIS.md`
3. `ARCHITECTURE.md`, `DESIGN_SPEC.md` (if present)
4. Existing project files to match patterns exactly

## Implementation order (strict)

1. Types: `ComponentName.types.ts`
2. Helpers: `ComponentName.helpers.ts`
3. Styles: `ComponentName.styles.ts`
4. Service: `src/services/<feature>/<feature>.service.ts`
5. Service types: `<feature>.service.types.ts`
6. Query hooks: `<feature>.service.hooks.ts`
7. Store: `src/stores/<feature>/<feature>.store.ts`
8. Store types: `<feature>.store.types.ts`
9. Store helpers: `<feature>.store.helpers.ts`
10. Component: `ComponentName.tsx`
11. Screen: `<Feature>.screen.tsx` (thin shell)
12. Navigation updates with typed params

## Folder structure (non-negotiable)

```text
src/
  components/
    <feature>/
      FeatureContainer/
        Feature.tsx
        Feature.types.ts
        Feature.styles.ts
        Feature.helpers.ts
        Feature.test.tsx
      SubComponent/
        SubComponent.tsx
  screens/
    FeatureScreen.tsx
  services/
    <feature>/
      <feature>.service.ts
      <feature>.service.types.ts
      <feature>.service.hooks.ts
  stores/
    <feature>/
      <feature>.store.ts
      <feature>.store.types.ts
      <feature>.store.helpers.ts
  schemas/<feature>/<feature>.schema.ts
```

## Component body order (strict)

1. Props destructuring
2. Library hooks (`useNavigation`, `useIsFocused`, etc.)
3. Store selectors / data hooks
4. Custom hooks
5. Local state
6. Derived values/constants
7. Dependent hooks
8. Handlers (`onPress`, `handleSubmit`)
9. Effects/subscriptions
10. `return` view only (no business logic)

- Extract complex logic to helpers before `return`.
- Max 300 lines per file; split when exceeded.

## File-type rules

- `.types.ts`: interfaces only, no executable logic.
- `.helpers.ts`: pure functions only; no hooks/navigation/stores.
- `.styles.ts`: all appearance tokens/classes live here.
- `.tsx`: uses styles/types/helpers; avoid inline styling logic.

## Import rules

1. External packages
2. Co-located imports (`./`)
3. Relative siblings (`../`)
4. Project aliases
5. Assets

Use `import type` for type-only imports.

## TypeScript and data rules

- No implicit `any`.
- Explicit types for props, payloads, responses, and store shapes.
- Path aliases from tsconfig; avoid deep relative paths.
- Zod schemas only in `src/schemas/...`.
- React Hook Form with `zodResolver`.

## Platform rules

- React Navigation params must be typed and serializable.
- Reanimated plugin must be last in `babel.config.js`.
- Use Expo-compatible patterns and config plugins for native capabilities.

## Accessibility and testability

- All interactive elements require `testID`.
- All interactive elements require `accessibilityLabel` and `accessibilityRole`.

## QA handoff (mandatory)

Create `QA_CONTRACT.md` in each relevant component folder including:
- test IDs table
- scenarios
- edge cases
- accessibility checks
- mock dependencies

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci --findRelatedTests --passWithNoTests
```
