# ai-agents

Reusable template of agents, rules, skills, and hooks for **Cursor** and **Claude Code**.

There are only **two** implementation agents:

| Agent | When to use it |
|-------|----------------|
| `web-software-engineer` | React / Next.js App Router (web) + Jest/RTL tests |
| `app-software-engineer` | React Native / Expo (mobile) + Jest/RNTL tests |

Everything else is **always-on rules**, **on-demand skills** (stack and design), **quality-gate scripts**, and **hooks** that format/lint after each edit.

---

## What this includes

| Piece | Role |
|-------|------|
| **Agents** | Integrated engineers: feature code + tests in the same session |
| **Rules** | Style, TypeScript, semantics, English-only code, docs — always on |
| **Skills** | Stack patterns (Next / Expo / shared) and design — only when relevant |
| **Hooks** | After each edit: Prettier → ESLint `--fix` |
| **Scripts** | `check-types` → `lint` → `test:ci` |

This is not an npm package. **Copy** it into the target project and adapt it.

---

## Repository structure

```text
AGENTS.md                 # Cursor brief (always on)
CLAUDE.md                 # Claude Code brief (always on)
README.md

.cursor/                  # Cursor pack
  PROJECT_CONTEXT.md
  agents/
    web-software-engineer.md
    app-software-engineer.md
  rules/                  # *.mdc, alwaysApply
  skills/                 # stack + design
  hooks.json
  hooks/format.sh
  scripts/quality-gates.sh

.claude/                  # Claude Code pack
  agents/
  rules/                  # *.md
  skills/
  settings.json           # PostToolUse prettier/eslint
  scripts/quality-gates.sh
```

Both folders are **functionally equivalent**. Use one platform or both in the same project.

---

## Choosing an agent

1. **Web (Next.js)** project → default `web-software-engineer`
2. **Mobile (Expo / RN)** project → default `app-software-engineer`
3. If the user names an agent explicitly → use that one, no override

Stack skills load when the task matches (`react-nextjs-stack`, `react-native-expo-stack`, `shared-patterns`). Design skills (`design-taste-frontend`, `emil-desing-eng`, `ui-ux-pro-max`) are on-demand for UI / landing / polish work.

---

## Cursor guide

### 1. Copy

Into the target project:

```bash
cp AGENTS.md /path/to/project/
cp -R .cursor /path/to/project/
```

### 2. Adapt (required)

| File | What to change |
|------|----------------|
| `AGENTS.md` | What the project is; default agent (web vs mobile); real gates |
| `.cursor/PROJECT_CONTEXT.md` | Same context, paths, and conventions for the repo |
| Quality gates | If you do not use `pnpm`, switch to `yarn`/`npm` in agents, `PROJECT_CONTEXT`, `scripts/quality-gates.sh`, and `hooks/format.sh` |
| Skills | Delete the unused stack (e.g. drop `react-native-expo-stack` in a web-only repo) to save tokens |

### 3. Day-to-day usage

1. Open Agent chat in Cursor inside the project.
2. Invoke the agent at the start of the session:
   - `/web-software-engineer` — web feature + tests
   - `/app-software-engineer` — mobile feature + tests
   - Or in natural language: *“use web-software-engineer to…”*
3. **Rules** (`.cursor/rules/*.mdc`) apply automatically.
4. Stack **skills** activate when the task matches their `description`.
5. After each file edit, the `afterFileEdit` hook runs Prettier then ESLint `--fix` (the consumer project must have those binaries).

### 4. Closing a task

The agent must report gates (it does not commit):

```bash
pnpm check-types
pnpm lint
pnpm test:ci
```

Or: `.cursor/scripts/quality-gates.sh`

### 5. Hard agent rules

- Never `git commit` / `git add` unless you explicitly ask
- UI strings via i18n (es / en / br), never hardcoded
- Tests ship in the same session as the feature

---

## Claude Code guide

### 1. Copy

Into the target project:

```bash
cp CLAUDE.md /path/to/project/
cp -R .claude /path/to/project/
```

### 2. Adapt (required)

| File | What to change |
|------|----------------|
| `CLAUDE.md` | What the project is; default agent; `@` includes for rules; real gates |
| Quality gates | If you do not use `pnpm`, update `CLAUDE.md`, agents, `scripts/quality-gates.sh`, and the command in `settings.json` |
| Skills | Remove the unused stack under `.claude/skills/` |

### 3. Day-to-day usage

1. Open Claude Code in the repo.
2. Invoke the agent:
   - Web: `web-software-engineer`
   - Mobile: `app-software-engineer`
3. `CLAUDE.md` loads always-on **rules** via `@.claude/rules/...`.
4. Stack **skills** load when the stack applies (agents point at them).
5. After each `Write`/`Edit`, the `PostToolUse` hook in `.claude/settings.json` runs Prettier then ESLint `--fix`.

### 4. Closing a task

```bash
pnpm check-types
pnpm lint
pnpm test:ci
```

Or: `.claude/scripts/quality-gates.sh`

### 5. Hard agent rules

Same as Cursor: no automatic commits, i18n, tests in the same session.

---

## Dual mode (Cursor + Claude)

If the team uses both tools:

1. Copy **both** packs (`AGENTS.md` + `.cursor/` and `CLAUDE.md` + `.claude/`).
2. Keep the same meaning across agents / rules / skills (paths differ: `.cursor` vs `.claude`).
3. Do not delete one platform “because you do not use it today” if another teammate does.

---

## Post-copy checklist

- [ ] Filled in “What this project is” in `AGENTS.md` and/or `CLAUDE.md`
- [ ] Default agent is correct (web vs mobile)
- [ ] Gate scripts match the project `package.json`
- [ ] Prettier + ESLint installed (if you want format-on-edit)
- [ ] Removed the opposite-stack skills (optional, recommended)
- [ ] Smoke-tested agent invoke on a small task

---

## Notes

- This meta-repo has **no** `package.json`: Prettier/ESLint/gates only run in the **consumer project**.
- Agents **never** create commits; you decide when to commit.
- Cursor ↔ Claude parity: same two agents, same rules/skills; only native paths and formats differ (`.mdc` + `hooks.json` vs `.md` + `settings.json`).
