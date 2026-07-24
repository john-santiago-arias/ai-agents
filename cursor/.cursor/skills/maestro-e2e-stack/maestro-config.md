# Maestro config & running

## Workspace config

`.maestro/config.yaml` configures the workspace (which flows to run and in what order).

```yaml
# .maestro/config.yaml
flows:
  - "*.yaml"
executionOrder:
  continueOnFailure: false
```

## appId via env

Flows read the app under test from an env var so the same flow works across build variants:

```yaml
# .maestro/<feature>.yaml
appId: ${APP_ID}
---
- launchApp
```

- `APP_ID` is the Android `applicationId` or iOS bundle identifier (e.g. `com.acme.app`).
- Pass it at run time: `maestro test -e APP_ID=com.acme.app .maestro/<feature>.yaml`.
- Double-check it matches exactly — a typo means Maestro cannot find the app.
- Keep `APP_ID` and any credentials in `.maestro/.env` (gitignored) or the shell env; never hardcode
  secrets in flows.
- **The agent never reads or writes secret files.** It lists the needed variables and their purpose
  and asks QA to set them manually, then continues assuming they exist (see the `app-qa-engineer`
  non-negotiable rules). `.env*` and `.maestro/.env` are never opened.

## Running — assume-installed model

**Maestro does not build or install the app.** The build must already be on a running
device/emulator. The agent verifies this and never builds:

```bash
# Android — an emulator must be booted and the app installed
adb devices

# iOS — a simulator must be booted and the app installed
xcrun simctl list devices booted

# Run (pick the device explicitly when more than one is connected)
maestro test -e APP_ID=com.acme.app .maestro/<feature>.yaml
maestro --device emulator-5554 test -e APP_ID=com.acme.app .maestro/<feature>.yaml
```

If there is no booted device or the app is not installed, stop and ask QA to start the
emulator/simulator and install the current build (e.g. `npx expo run:android` / `run:ios` on their
side). Do not build it from the agent.

## Debug & CI

- `maestro test` writes screenshots/logs on failure; `maestro record` and Maestro Studio help author
  flows interactively.
- CI (optional): Maestro Cloud runs the same `.maestro/` flows against uploaded builds — out of scope
  for the local QA flow but the flows are portable to it unchanged.
