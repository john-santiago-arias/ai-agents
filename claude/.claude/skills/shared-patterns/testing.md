# Testing

## Placement

- Colocate `ComponentName.test.tsx` next to source
- Web: `page.tsx` / `layout.tsx` → `page.test.tsx` / `layout.test.tsx` in same folder
- Mobile: `FeatureName.screen.test.tsx` in `src/screens/`
- Standalone modules: `moduleName.test.ts` beside the module
- Shared mocks in `__mocks__/` by category
- Feature-specific mocks colocated in the test file

## Queries

**Web (RTL):** prefer semantic — `getByRole`, `getByLabelText`; async: `findBy*` or `waitFor`
**Mobile (RNTL):** `getByTestId` and a11y queries aligned with `testID` and labels

## Structure: Arrange / Act / Assert in every test

```ts
// Arrange
render(<Component prop="value" />);

// Act
fireEvent.press(screen.getByTestId('submit-btn'));

// Assert
expect(screen.getByText('Success')).toBeTruthy();
```

## Rules

- Coverage: components/screens + all logic touched in the same session
- Regression tests for bugfixes
- Security-sensitive flows when in scope
- Focus: behavior and public output — not implementation internals

## web-software-engineer / app-software-engineer

Tests ship in the same session as the code..
