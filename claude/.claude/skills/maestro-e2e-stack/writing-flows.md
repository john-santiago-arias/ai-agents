# Writing flows

## Naming & structure

- One flow per user journey: `.maestro/<feature>.yaml` (kebab-case, English).
- YAML shape: `appId` + optional `onFlowStart`/`onFlowComplete` in the header block, then `---`, then
  the ordered list of commands.
- Mirror Arrange / Act / Assert (see `../shared-patterns/testing.md`): set up state (subflow / launch),
  perform the action (`tapOn`, `inputText`), assert the outcome (`assertVisible`).

## Common commands

```yaml
- launchApp:
    clearState: true
- tapOn:
    id: "submit-button"          # prefer id (testID)
- inputText: "221B Baker Street"
- extendedWaitUntil:             # assert-before-interact; no fixed waits
    visible:
      id: "order-confirmation"
    timeout: 10000
- assertVisible:
    id: "order-confirmation"
- assertVisible: "Order confirmed"   # text — only when no testID exists
- scrollUntilVisible:
    element:
      id: "footer"
```

## Rules

- Selector priority: `id` (testID) > text > accessibility. `id`s survive i18n; text does not.
- Never a fixed `wait`/sleep — use `extendedWaitUntil: visible:` before interacting.
- One user-visible outcome per assertion; assert behavior, not implementation internals.
- Keep flows independent — no shared mutable state; use subflows/`onFlowStart` for setup and
  `onFlowComplete` for cleanup (runs on failure too).
- Text assertions must match the app's i18n output for the locale under test.
- If a needed element lacks a `testID`, report it to QA rather than matching brittle text on a
  critical step.

## Coverage focus (QA scenarios)

- The happy path of the feature QA described.
- The key negative/validation paths QA cares about (bad input, blocked action, empty state).
- Do not test OS UI or third-party screens — only the product's own behavior.
