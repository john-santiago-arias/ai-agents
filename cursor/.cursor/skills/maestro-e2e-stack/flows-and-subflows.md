# Flows & subflows

Keep each flow focused on one user journey; factor cross-cutting steps (login, logout, seeding) into
subflows so a UI change is fixed in one place.

## Flow (one journey per file)

```yaml
# .maestro/checkout.yaml
appId: ${APP_ID}
onFlowStart:
  - runFlow: subflows/login.yaml
onFlowComplete:
  - runFlow: subflows/logout.yaml       # runs on success AND failure
---
- launchApp:
    clearState: true                    # deterministic start
- runFlow: subflows/add-item-to-cart.yaml
- tapOn:
    id: "checkout-button"
- extendedWaitUntil:
    visible:
      id: "order-confirmation"
    timeout: 10000
- assertVisible:
    id: "order-confirmation"
```

## Subflow (reusable steps)

```yaml
# .maestro/subflows/login.yaml
appId: ${APP_ID}
---
- tapOn:
    id: "email-input"
- inputText: ${EMAIL}
- tapOn:
    id: "password-input"
- inputText: ${PASSWORD}
- tapOn:
    id: "sign-in-button"
- extendedWaitUntil:
    visible:
      id: "home-screen"
    timeout: 15000
```

- Call a subflow with `runFlow: subflows/<name>.yaml`.
- Pass data with `env:` on `runFlow`, or rely on workspace-level env vars.
- `clearState: true` on `launchApp` for an isolated, deterministic run.

## When to use which

| Situation | Approach |
| --- | --- |
| A complete user journey | Flow (`.maestro/<feature>.yaml`) |
| Login / auth / seeding reused across flows | Subflow (`.maestro/subflows/`) via `runFlow` |
| Setup / teardown of test data | `onFlowStart` / `onFlowComplete` (teardown runs on failure too) |
