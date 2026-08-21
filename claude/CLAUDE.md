# Project context for Claude Code

## What this project is

## Frontend agent for this project

**Default web agent:** `web-software-engineer`
**Default mobile agent:** `app-software-engineer`
**Web QA E2E agent:** `web-qa-engineer` (Playwright end-to-end tests for QA)
**App QA E2E agent:** `app-qa-engineer` (Maestro mobile end-to-end tests for QA)

## Always-active rules

Universal engineering rules (code, semantics, order, style) load on every session, for every stack and agent:

@.claude/rules/code-style.md
@.claude/rules/naming-english.md
@.claude/rules/typescript.md
@.claude/rules/semantics-order.md
@.claude/rules/documentation.md
@.claude/rules/env_files.md

Stack-specific and library patterns are on-demand skills under `.claude/skills/` — loaded only when that stack applies.

## Git conventions

- Branch naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`
- Commit format: `feat(scope): description` / `fix(scope): description`
- One PR per agent pipeline run
- **Agents never run `git commit` or `git add`**
  - **Exception — QA agents (`web-qa-engineer`, `app-qa-engineer`) only:** each creates a
    `test/<feature>` branch, and after tests pass green it may `git add` / `git commit` / `git push`
    **but only after explicit confirmation**. Every new task restarts the flow on a fresh branch.
    No other agent commits.

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
