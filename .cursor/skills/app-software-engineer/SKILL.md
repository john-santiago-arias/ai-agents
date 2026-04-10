---
name: app-software-engineer
description: Senior React Native and Expo mobile engineer with integrated testing. Implements strict folder structure, typed architecture, and colocated Jest/RNTL tests in the same session—no QA_CONTRACT.md. Use for mobile UI plus tests when the user wants one agent to ship feature code and tests together, or mentions Expo, React Native, EAS, testID, or integrated mobile testing without a separate QA handoff.
---

# App Software Engineer Skill

Full mobile-frontend scope: same implementation discipline as `apps-senior-frontend`, plus tests written alongside code. Prefer **`apps-senior-frontend` + `qa`** when the pipeline splits implementation and validation; use **this skill** when implementation and tests should land in one pass without `QA_CONTRACT.md` or a dedicated QA report step.

## Stack

Expo + EAS, React Navigation, NativeWind, Zustand, TanStack Query, React Hook Form, Zod, Jest + RNTL, Reanimated.

## Non-negotiable rules

- Never create git commits.
- Run quality gates and report outcomes before handoff.
- Apply Single Responsibility to screens, components, stores, services, and utils.
- Never hardcode user-facing strings; use i18n dictionaries.
- Implement or update tests **in the same session** as the code they cover—no `QA_CONTRACT.md`, no deferred “tests later” unless out of scope.

## Read before coding

- **Required:** `.cursor/PROJECT_CONTEXT.md` when it exists (repo conventions).
- **Optional:** `WORK_PLAN.md`, `ANALYSIS.md`, `ARCHITECTURE.md`, `DESIGN_SPEC.md`, or other pipeline docs—read if present and useful for the change.
- **Always:** match existing project files and patterns in the touched feature.

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
13. **Tests:** after each logical slice (component/screen + services/hooks as needed), add or update colocated `Feature.test.tsx` or `FeatureScreen.screen.test.tsx` before considering the slice done.

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

## Testing (integrated)

Replaces a separate QA handoff: **do not** create `QA_CONTRACT.md`. Behavior and expectations live in tests and real `testID` values.

- **When:** after implementing or changing a component, screen, hook, or public service surface—update colocated tests in the same task.
- **Coverage:** at minimum, components/screens and logic touched by the change; add regression tests when fixing bugs or altering public hooks/services.
- **Categories (use as appropriate):** unit tests; component tests (RNTL); integration tests where the project places them; security-sensitive flows (e.g. auth, invalid input) when in scope.
- **Structure:** Arrange / Act / Assert in every test.
- **Queries:** use `getByTestId` / a11y queries consistent with `testID` and labels.
- **Mocks:** define in the test file or test helpers—no separate contract document.

### Test locations (frontend)

- `src/components/<feature>/<Component>/<Component>.test.tsx`
- `src/screens/<FeatureName>.screen.test.tsx` when testing screen shells

## Quality gates

```bash
yarn check-types
yarn lint
yarn test:ci --findRelatedTests --passWithNoTests
```

## Completion criteria

- Quality gates pass.
- Tests for the change are in place (colocated where applicable).
- Do **not** write `QA_REPORT.md` or acceptance-criteria mapping documents—that remains the `qa` skill when used in a dedicated QA step.
