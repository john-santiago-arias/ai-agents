# Hybrid architecture: Page Objects + fixtures

Use **Page Objects** for complex screens and **fixtures** for setup and business actions. Simple
flows can skip the POM and use plain locators in the spec — do not over-engineer.

## Page Objects (`modules/<module>/pages/`, or `shared/pages/` if app-wide)

- Live in the owning module (`modules/auth/pages/LoginPage.ts`). App-wide screens used by 2+ modules
  (Navbar, layout) go in `shared/pages/`.
- Encapsulate locators (lazy) and user intents. One class per screen/area.
- Store locators, never resolved `ElementHandle`s.
- Keep assertions in the spec or in clearly named `expect*` helpers — a Page Object must never hide a
  failing check.
- Arrow-function class fields for methods (repo code style is arrow-only).

```ts
import type { Page, Locator } from "@playwright/test";

export class CheckoutPage {
  readonly page: Page;
  readonly placeOrderButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.placeOrderButton = page.getByRole("button", { name: "Place order" });
  }

  goto = async () => {
    await this.page.goto("/checkout");
  };

  fillShipping = async (address: string) => {
    await this.page.getByLabel("Address").fill(address);
  };

  placeOrder = async () => {
    await this.placeOrderButton.click();
  };
}
```

## Fixtures — base (`shared/fixtures.ts`) + per module (`modules/<module>/fixtures.ts`)

Fixtures compose in two layers so each module stays decoupled:

- **`shared/fixtures.ts`** — the base extended `test`, holding only cross-module fixtures (app-wide
  Page Objects, seeded state). Auth is handled by the setup project + `storageState` (see
  `playwright-config.md`); fixtures build on top of an already-authenticated context.
- **`modules/<module>/fixtures.ts`** — extends the shared base with that module's Page Objects and
  business actions, then re-exports `test`/`expect`. Specs in the module import from here.

```ts
// shared/fixtures.ts — base, cross-module only
import { test as base, expect } from "@playwright/test";

import { NavbarPage } from "./pages/NavbarPage";

type SharedFixtures = {
  navbar: NavbarPage;
};

export const test = base.extend<SharedFixtures>({
  navbar: async ({ page }, use) => {
    await use(new NavbarPage(page));
  }
});

export { expect };
```

```ts
// modules/checkout/fixtures.ts — extends shared with module Page Objects
import { test as base } from "../../shared/fixtures";

import { CheckoutPage } from "./pages/CheckoutPage";

type CheckoutFixtures = {
  checkoutPage: CheckoutPage;
};

export const test = base.extend<CheckoutFixtures>({
  checkoutPage: async ({ page }, use) => {
    const checkoutPage = new CheckoutPage(page);
    await checkoutPage.goto();
    await use(checkoutPage);
  }
});

export { expect } from "../../shared/fixtures";
```

- Every spec imports `test` and `expect` from its **module** `fixtures.ts` (which re-exports shared) —
  never from `@playwright/test` directly, and never from another module's fixtures.
- A module with no extra fixtures can import straight from `shared/fixtures.ts`.

## When to use which

| Situation | Approach |
| --- | --- |
| Multi-step screen used within one module | Page Object in `modules/<module>/pages/` |
| Screen used by 2+ modules (Navbar, layout) | Page Object in `shared/pages/` |
| Module-specific setup / business action | Fixture in `modules/<module>/fixtures.ts` |
| Auth / seeded state / logged-in context | Base fixture + setup project `storageState` |
| One-off simple assertion on a page | Plain locators in the spec |
