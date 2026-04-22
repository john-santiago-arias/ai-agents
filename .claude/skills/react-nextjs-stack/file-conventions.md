# File Conventions — React / Next.js

## Component declaration (non-negotiable)

```tsx
const ComponentName: React.FC<ComponentNameProps> = (props) => {
  // body
};

export default ComponentName;
```

## Component body order (strict)

1. Props destructuring
2. Library hooks (`useRouter`, `usePathname`, ...)
3. Store selectors / data hooks (`useQuery`, stores)
4. Project custom hooks
5. Local state (`useState`, `useReducer`)
6. Derived values and constants (no JSX)
7. Hooks dependent on earlier values
8. Handler functions (`onClick`, `handleSubmit`) — named, before effects
9. `useEffect` / `useLayoutEffect` / subscriptions
10. `return` — view tree only; simple ternaries only; no business logic

- Complex logic → extract to variable or `.helpers.ts`
- Long JSX branches → extract to named sibling subcomponent
- **Max 300 lines per file** — split if exceeded

## Rules per file type

**`.types.ts`**
- Header: `// Interfaces and types from component ComponentName`
- `ComponentNameProps` first
- JSDoc on public interfaces
- No executable logic

**`.helpers.ts`**
- Header: `// ComponentName helpers`
- Constants first, then pure functions
- JSDoc `@param`/`@returns` on each export
- No hooks, stores, or navigation

**`.styles.ts`** *(only if project already uses this convention)*
- Tailwind named exports
- `twMerge`/`cn` for composition
- `getXxxClasses(condition)` for dynamic classes

**`.tsx`**
- Simple classes inline in `className`
- Long reused strings as named `const` in same file
- Multiple variants with `cva`/`tailwind-variants`

## Import order

```
1. External packages (React, Next.js, UI libs...)
[blank line]
2. Co-located: ./ComponentName.types, ./ComponentName.helpers
3. Relative siblings ../
4. Project aliases — alphabetical
[blank line]
5. Assets (.svg, images, fonts)
```

- One import per line
- Merge symbols from same module
- `import type` for type-only imports
- Path aliases from tsconfig — never deep relative imports
