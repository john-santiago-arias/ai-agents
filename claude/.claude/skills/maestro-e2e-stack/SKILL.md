---
name: maestro-e2e-stack
description: Apply when writing or running mobile end-to-end tests with Maestro for React Native / Expo apps. Covers the .maestro/ workspace and config, flows + subflows, selector priority (id/testID), assert-before-interact waiting, and data setup/teardown. Trigger on any mobile E2E task: new user-journey flow, login subflow, flaky-flow fix, or Maestro config change.
allowed-tools: Read, Glob, Grep
---

# Maestro Mobile E2E — Stack Rules

**Stack:** Maestro (YAML flows) · React Native + Expo · Android & iOS

→ Workspace & run config (`.maestro/config.yaml`, appId, devices): `maestro-config.md`
→ Flows + subflows (structure, reuse): `flows-and-subflows.md`
→ Writing flows (commands, naming, examples): `writing-flows.md`
→ Shared testing conventions (AAA, `testID`): `../shared-patterns/testing.md`

Maestro flows are **YAML**, not TypeScript — the repo's arrow-function / TS code-style rules do not
apply. English-only naming still applies (flow names, `id`s, env vars, comments), from
`.claude/rules/naming-english.md`.

---

## Placement

```
.maestro/                          # Maestro workspace at repo root
├── config.yaml                    # workspace config (flow directory, executionOrder)
├── <feature>.yaml                 # one flow per user journey
├── subflows/                      # cross-cutting reusable steps
│   ├── login.yaml
│   └── logout.yaml
└── .env                           # local APP_ID / credentials (gitignored)
```

- E2E flows live in `.maestro/`, separate from colocated Jest/RNTL unit tests.
- One flow = one user journey, so a failure points at a single feature.

## Selector priority (non-negotiable)

1. `id:` — the `testID` (Android resource-id / iOS accessibility id). Most stable; survives i18n.
2. text — visible copy (fragile across locales; use only when no `testID` exists).
3. accessibility label.

Align `id`s with the app's `testID` convention from `shared-patterns/testing.md` and the
`react-native-expo-stack` skill. If a needed element has no `testID`, report it to QA — do not fall
back to brittle text matching on critical steps.

## Assert-before-interact (non-negotiable)

- After navigation, wait for the target to be **visible** before tapping it:
  `extendedWaitUntil: visible: id: target ; timeout: 10000`.
- Wait for content to appear, not for spinners to disappear. Never a fixed `wait`/sleep.

## Cross-platform (Android & iOS)

- Flows are cross-platform when they select by `id`. The same `.yaml` runs on both.
- The agent targets whatever device is booted; see `maestro-config.md` for `--device` selection.

## Data setup & teardown

- Use `onFlowStart` for setup and `onFlowComplete` for teardown. `onFlowComplete` runs on failure
  too, so every flow that creates data cleans it up.
- Factor login/auth and other shared steps into `subflows/` and reuse with `runFlow`.
