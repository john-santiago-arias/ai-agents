# Writing specs

## Naming & structure

- Specs live in their module: `tests/e2e/modules/<module>/specs/<module>-<scenario>.<state>.spec.ts`
  (kebab-case, English), e.g. `modules/auth/specs/auth-login-validation.guest.spec.ts`.
- `<state>` is the auth context and maps to a Playwright project:
  - `.guest.spec.ts` → runs unauthenticated (no `storageState`).
  - `.authenticated.spec.ts` → runs with the logged-in session (setup project + `storageState`).
  See `playwright-config.md` for how the suffix selects the project.
- `test.describe("<Feature>", ...)` groups the flow; each `test(...)` is one scenario.
- Arrange / Act / Assert in every test (see `../shared-patterns/testing.md`).
- Import `test` and `expect` from the **module** `fixtures.ts`, never from `@playwright/test`.

## Example

```ts
// modules/checkout/specs/checkout-guest.guest.spec.ts
import { test, expect } from "../fixtures";

test.describe("Guest checkout", () => {
  test("completes an order with a valid address", async ({ page, checkoutPage }) => {
    // Arrange
    await checkoutPage.fillShipping("221B Baker Street");

    // Act
    await checkoutPage.placeOrder();

    // Assert
    await expect(page.getByRole("heading", { name: "Order confirmed" })).toBeVisible();
    await expect(page).toHaveURL(/\/order\/[a-z0-9-]+/);
  });
});
```

## Rules

- Selector priority: `getByRole` > `getByLabel` > `getByText` > `getByTestId`. No CSS/XPath.
- Web-first assertions only — `await expect(locator)...`. No `waitForTimeout`, no `networkidle`.
- One user-visible outcome per assertion block; assert on behavior, not implementation internals.
- Keep specs independent — no shared mutable state between tests; rely on fixtures for setup.
- A spec stays inside its module — it never imports a Page Object or fixture from another module.
  Shared needs come from `shared/` (see `SKILL.md` module rules).
- `data-testid` is a last-resort hook; when needed, align names with the app's existing `data-testid`
  convention from `shared-patterns/testing.md`.
- User-facing strings in assertions must match the app's i18n output for the locale under test.

## Bootstrapping from a published URL (codegen)

When there is no source access and QA gives only a live site URL, record a first pass instead of
writing from scratch:

```bash
npx playwright codegen https://my-site.com          # records clicks/inputs into a script
BASE_URL=https://my-site.com pnpm test:e2e          # run specs against the published site
```

Codegen output is a **starting point, never the final spec**. Always refactor it:

- Move the flow into its module (`modules/<module>/specs/...`) and extract screens into Page Objects.
- Replace codegen's brittle selectors (nth-child, long CSS, raw text) with the priority order:
  `getByRole` > `getByLabel` > `getByText` > `getByTestId`.
- Replace any recorded credentials/PII with env vars — never commit them (see the agent secrets rule).
- Add proper web-first assertions; codegen records actions, not verifications.
- Since `BASE_URL` is set, Playwright does **not** launch a local `webServer` (see `playwright-config.md`).

## Coverage focus (QA scenarios)

- The happy path of the feature QA described.
- The key negative/validation paths QA cares about (bad input, blocked action, empty state).
- Do not test third-party UIs or framework internals — only the product's own behavior.
