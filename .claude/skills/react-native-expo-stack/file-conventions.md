# File Conventions — React Native / Expo

## Component declaration (non-negotiable)

```tsx
const ComponentName: React.FC<ComponentNameProps> = (props) => {
  // body
};

export default ComponentName;
```

## Component body order (strict)

1. Props destructuring
2. Library hooks (`useNavigation`, `useIsFocused`, ...)
3. Store selectors / data hooks (`useQuery`, stores)
4. Project custom hooks
5. Local state (`useState`, `useReducer`)
6. Derived values and constants (no JSX)
7. Hooks dependent on earlier values
8. Handler functions (`onPress`, `handleSubmit`) — named, before effects
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

**`.styles.ts`** (ALL appearance here — non-negotiable)
- NativeWind named exports: `export const container = "flex-1 bg-background px-4"`
- Theme tokens only — no raw values
- `getXxxClasses(condition)` for dynamic classes

**`.tsx`**
- Imports from `.styles`, `.types`, `.helpers` only
- No inline appearance — exception requires one-line comment

## Import order

```
1. External packages (React, RN, Expo, navigation...)
[blank line]
2. Co-located: ./ComponentName.styles, ./ComponentName.types
3. Relative siblings ../
4. Project aliases — alphabetical
[blank line]
5. Assets (.svg, images, fonts)
```

- One import per line
- Merge symbols from same module
- `import type` for type-only imports
- Path aliases from tsconfig — never deep relative imports
