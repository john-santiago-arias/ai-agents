# Project context for Claude Code

## What this project is

## Frontend agent for this project

**Default web agent:** `web-software-engineer`
**Default mobile agent:** `app-software-engineer`

## Git conventions

- Branch naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`
- Commit format: `feat(scope): description` / `fix(scope): description`
- One PR per agent pipeline run
- **Agents never run `git commit` or `git add`**

## Output rules

- Return code first. Explanation after, only if non-obvious.
- No inline prose. Comments only where logic is unclear.
- No boilerplate unless explicitly requested.

## Code rules

- Simplest working solution. No over-engineering.
- No abstractions for single-use operations.
- No speculative features.
- Read the file before modifying it. Never edit blind.
- No docstrings or type annotations on code not being changed.
- No error handling for scenarios that cannot happen.
- Three similar lines is better than a premature abstraction.

## Review rules

- State the bug. Show the fix. Stop.
- No suggestions beyond scope.
- No compliments before or after.

## Debugging rules

- Never speculate without reading the relevant code first.
- State what you found, where, and the fix. One pass.
- If cause is unclear: say so. Do not guess.

## Formatting rules

- No em dashes, smart quotes, or decorative Unicode.
- Plain hyphens and straight quotes only.
- Code output must be copy-paste safe.

---

## Quality gates

```bash
pnpm check-types   # tsc --noEmit — MUST pass
pnpm lint          # MUST pass
pnpm test:ci       # MUST pass — coverage minimum 80%
```

---
