# TypeScript Rules

## Non-negotiable

- `strict: true` — no implicit `any`
- No unchecked index access
- No implicit returns on complex branches
- If truly unavoidable: `// TODO: type this — <reason>`
- Explicit types for all: props, payloads, responses, state shapes
- Path aliases from tsconfig — never deep relative imports

## Web (Next.js specific)

- Prettier: semicolons on, double quotes, width 80, no trailing commas, 2 spaces
- ESLint: Next + TypeScript plugin — fix all errors before committing

## Documentation

- JSDoc on exported interfaces reused across modules or representing API/store contracts
- `@param`/`@returns` on exported functions in `utils`, `services`, `stores` when signature alone is insufficient
- Comments in English, describing intent — not obvious syntax
- Keep comments in sync with code changes

## Error handling

- Async flows: explicit error behavior — user feedback, fallback UI, or retry path
- Never silently swallow exceptions
- Console logs must be actionable — no noise in stable paths
