# Project context for Cursor

## What this project is

## Frontend agent for this project

**Default web agent:** `web-software-engineer`
**Default mobile agent:** `app-software-engineer`

## Always-active rules

Universal engineering rules (code, semantics, order, style) load on every session, for every stack and agent, via `.cursor/rules/`:

- code-style
- naming-english
- typescript
- semantics-order
- documentation

Stack-specific and library patterns are on-demand skills under `.cursor/skills/` — loaded only when that stack applies.

Canonical project facts: `.cursor/PROJECT_CONTEXT.md`.

## Git conventions

- Branch naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`
- Commit format: `feat(scope): description` / `fix(scope): description`
- One PR per agent pipeline run
- **Agents never run `git commit` or `git add`**

## Output rules

- Return code first. Explanation after, only if non-obvious.
- No inline prose. Comments only where logic is unclear.
- No boilerplate unless explicitly requested.

## Review rules

- State the bug. Show the fix. Stop.
- No suggestions beyond scope.
- No compliments before or after.

## Debugging rules

- Never speculate without reading the relevant code first.
- State what you found, where, and the fix. One pass.
- If cause is unclear: say so. Do not guess.

---

## Quality gates

```bash
pnpm check-types   # tsc --noEmit — MUST pass
pnpm lint          # MUST pass
pnpm test:ci       # MUST pass — coverage minimum 80%
```

---
