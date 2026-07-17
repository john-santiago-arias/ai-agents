# Code Style (always applies)

Universal coding style. Applies to every stack and agent.

## Functions: arrow only (non-negotiable)

Do **not** declare functions with the `function` keyword. **Every** function is an arrow function assigned to a `const` (or inlined where appropriate).

Applies to components, hooks, helpers, handlers, utilities, services, and tests. Sync and async: use `const fn = async () => {}`, never `async function fn() {}`.

```ts
// Allowed
const sum = (a: number, b: number) => a + b;
const fetchUser = async (id: string) => {
  // ...
};
export const useFeature = () => {
  // ...
};
```

```ts
// Forbidden
function sum(a: number, b: number) {
  return a + b;
}
async function fetchUser(id: string) {}
export function useFeature() {}
```

- **Hoisting:** arrow functions are not hoisted; define helpers above use or reorder.
- **Generators:** if you need `function*`, escalate — default style is arrow-only for ordinary functions.

## Component declaration (React web + mobile)

```tsx
const ComponentName: React.FC<ComponentNameProps> = (props) => {
  // body
};

export default ComponentName;
```

## Formatting

- Prettier: semicolons on, double quotes, width 80, no trailing commas, 2 spaces.
- ESLint (stack plugin) — fix all errors before committing.
- No em dashes, smart quotes, or decorative Unicode. Plain hyphens and straight quotes only.
- Code output must be copy-paste safe.
