# Playwright config

`playwright.config.ts` at the repo root. The agent runs against the local app with the latest dev
changes; Playwright auto-launches it via `webServer`. `BASE_URL` overrides the target for a deployed
staging/preview environment.

```ts
import { defineConfig, devices } from "@playwright/test";

const baseURL = process.env.BASE_URL ?? "http://localhost:3000";

export default defineConfig({
  testDir: "./tests/e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 4 : undefined,
  reporter: process.env.CI ? [["github"], ["html"]] : [["html"]],
  use: {
    baseURL,
    trace: "on-first-retry",
    screenshot: "only-on-failure",
    video: "retain-on-failure"
  },
  projects: [
    // 1) Authenticate once, save storageState for the rest.
    { name: "setup", testMatch: /.*\.setup\.ts/ },
    // 2) Guest specs (*.guest.spec.ts) — no stored session.
    {
      name: "chromium-guest",
      testMatch: /.*\.guest\.spec\.ts/,
      use: { ...devices["Desktop Chrome"] }
    },
    // 3) Authenticated specs (*.authenticated.spec.ts) — reuse the logged-in session.
    {
      name: "chromium-auth",
      testMatch: /.*\.authenticated\.spec\.ts/,
      use: { ...devices["Desktop Chrome"], storageState: "tests/e2e/.auth/user.json" },
      dependencies: ["setup"]
    }
  ],
  // Auto-launch the local app under test. Skipped when BASE_URL points elsewhere.
  webServer: process.env.BASE_URL
    ? undefined
    : {
        command: "pnpm dev",
        url: baseURL,
        reuseExistingServer: !process.env.CI,
        timeout: 120_000
      }
});
```

## Auth setup project

`tests/e2e/auth.setup.ts` logs in once and persists the session. Specs reuse it via `storageState`,
so they never re-drive the login form.

```ts
import { test as setup, expect } from "@playwright/test";

const authFile = "tests/e2e/.auth/user.json";

setup("authenticate", async ({ page }) => {
  await page.goto("/login");
  await page.getByLabel("Email").fill(process.env.E2E_USER_EMAIL ?? "");
  await page.getByLabel("Password").fill(process.env.E2E_USER_PASSWORD ?? "");
  await page.getByRole("button", { name: "Sign in" }).click();

  await expect(page.getByRole("heading", { name: "Dashboard" })).toBeVisible();
  await page.context().storageState({ path: authFile });
});
```

## package.json scripts (add if missing — idempotent)

Add this stable set of scripts so QA can run the suite from the console. Only add the ones that are
missing; never overwrite existing scripts.

```json
{
  "scripts": {
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:headed": "playwright test --headed",
    "test:e2e:debug": "playwright test --debug",
    "test:e2e:report": "playwright show-report"
  }
}
```

Runs are parameterized with pass-through args — no per-module script needed, so the set stays stable
as modules grow:

| Goal | Command |
| --- | --- |
| Whole suite | `pnpm test:e2e` |
| **One module** | `pnpm test:e2e tests/e2e/modules/auth` |
| **One spec file** | `pnpm test:e2e tests/e2e/modules/auth/specs/auth-login-validation.guest.spec.ts` |
| **One test by title** | `pnpm test:e2e -g "invalid password"` |
| Guest / authenticated only | `pnpm test:e2e --project=chromium-guest` / `--project=chromium-auth` |
| **Live UI mode (watch in browser)** | `pnpm test:e2e:ui` |
| Headed run (visible browser) | `pnpm test:e2e:headed` |
| Step-through debug | `pnpm test:e2e:debug` |
| Open last HTML report | `pnpm test:e2e:report` |

`--ui` opens Playwright's UI mode: a time-travel runner where QA picks modules/specs, watches them
execute live in the browser, and inspects each step, DOM snapshot, and network call.

## Conventions

- `tests/e2e/.auth/` holds `storageState` — add it to `.gitignore`; never commit real sessions.
- Credentials and target URLs come from env vars (`E2E_USER_EMAIL`, `E2E_USER_PASSWORD`, `BASE_URL`).
  Document only their **names and purpose** in `.env.example` (no real values); never hardcode secrets
  in specs.
- **The agent never reads or writes secret files.** It lists the needed variables and their purpose
  and asks QA to set them manually, then continues assuming they exist (see the `web-qa-engineer`
  non-negotiable rules). `.env*` and `.auth/*` are never opened.
- Browsers: `pnpm exec playwright install --with-deps` on first run.
