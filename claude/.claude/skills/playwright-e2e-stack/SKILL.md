---
name: playwright-e2e-stack
description: Apply when writing or running end-to-end tests with Playwright for Next.js App Router web apps. Covers project config (webServer, storageState auth), the hybrid Page Object + fixtures architecture, selector priority, web-first assertions, and spec conventions. Trigger on any E2E task: new user-flow test, auth setup, flaky-test fix, or Playwright config change.
allowed-tools: Read, Glob, Grep
---

# Playwright E2E — Stack Rules

**Stack:** Playwright Test · Next.js 14 App Router · TypeScript

→ Project config (`playwright.config.ts`, webServer, auth): `playwright-config.md`
→ Hybrid architecture (Page Objects + fixtures): `fixtures-and-pom.md`
→ Writing specs (structure, naming, examples): `writing-specs.md`
→ Shared testing conventions (AAA, `data-testid`): `../shared-patterns/testing.md`

Universal code rules (arrow functions, TypeScript, import/body order, English-only, documentation) load always from `.claude/rules/` via `CLAUDE.md` — not repeated here.

---

## Placement — group by business module (non-negotiable)

E2E is organized **by business module**, not as a flat pile of specs. Each module (auth, cart,
checkout, ...) is a self-contained folder so the suite stays readable, decoupled, and grows one
folder at a time.

```
tests/
└── e2e/
    ├── .auth/                         # storageState artifacts (gitignored)
    │   └── user.json
    ├── auth.setup.ts                  # global auth setup project → writes .auth/user.json
    │
    ├── shared/                        # ONLY cross-module building blocks
    │   ├── fixtures.ts                # base extended `test` — module fixtures build on this
    │   ├── pages/                     # app-wide Page Objects (Navbar, AppShell)
    │   │   └── NavbarPage.ts
    │   └── utils/
    │
    └── modules/                       # one folder per business module
        ├── auth/
        │   ├── pages/                 # LoginPage.ts, ...
        │   ├── fixtures.ts            # auth fixtures (extend shared) — optional
        │   └── specs/
        │       ├── auth-guards.guest.spec.ts
        │       ├── auth-login-validation.guest.spec.ts
        │       ├── auth-logout.authenticated.spec.ts
        │       └── auth-redirect.authenticated.spec.ts
        ├── cart/
        │   ├── pages/
        │   ├── fixtures.ts
        │   └── specs/
        └── checkout/
            ├── pages/
            ├── fixtures.ts
            └── specs/
playwright.config.ts                   # repo root
```

- E2E lives in `tests/e2e/`, separate from colocated Jest/RTL unit tests.
- Specs import the **extended** `test` from their module `fixtures.ts` (or `shared/fixtures.ts`),
  never `@playwright/test` directly.

## Module organization (non-negotiable)

- **One folder per business module** under `modules/`. When QA asks for a scenario, put it in the
  matching module — reuse the folder if it exists, create a new `modules/<name>/` if it does not.
  The module name is English, kebab-case (`auth`, `cart`, `checkout`, `product-search`).
- **A module is self-contained**: its `pages/`, `specs/`, and optional `fixtures.ts`. A module must
  **never import from another module's folder** — that coupling is the thing this structure prevents.
- **`shared/` is only for things used by 2+ modules**: the base `test` fixture, app-wide Page Objects
  (Navbar, layout), and utils. Promote to `shared/` when a second module needs it — not preemptively.
- **`auth.setup.ts` and `.auth/` stay at the e2e root**: the auth session is a global dependency of
  every module (the config setup project + `storageState`), not owned by the auth module's specs.
- **Growth & maintenance**: a new feature = a new `modules/<name>/` folder; removing a feature =
  delete one folder. No shared dumping ground, no cross-module reach-ins.

## Selector priority (non-negotiable)

1. `getByRole` (doubles as an accessibility check)
2. `getByLabel`
3. `getByText`
4. `getByTestId` (`data-testid`, aligned with `shared-patterns/testing.md`)

Never CSS selectors or XPath. Locators are lazy — store the locator, not a resolved handle; it re-resolves on use.

## Web-first assertions (non-negotiable)

- Use `await expect(locator).toBeVisible()` / `toHaveText()` / `toHaveURL()` — they auto-poll until the condition holds or the timeout expires.
- Never `page.waitForTimeout()` / fixed `sleep`. Never `networkidle` as a synchronization crutch.
- Debug flakiness with the Trace Viewer (`trace: 'on-first-retry'`) before touching test logic.

## Architecture: hybrid Page Object + fixtures

- **Page Objects** for complex screens: encapsulate locators and user intents; keep assertions in the spec (or in clearly named `expect*` helpers), never hidden inside the POM.
- **Fixtures** for setup and cross-cutting actions: auth via a setup project + `storageState`, and business-action fixtures (e.g. `loggedInPage`, `cartWithItems`) so specs read at the domain level.

See `fixtures-and-pom.md` for the full pattern.
