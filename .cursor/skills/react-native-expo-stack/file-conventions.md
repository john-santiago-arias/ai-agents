# File Conventions — React Native / Expo

Component declaration, component body order, import order, and the 300-line limit are universal rules — see `.cursor/rules/code-style.mdc` and `.cursor/rules/semantics-order.mdc`. RN-specific hooks slot into the same body order (`useNavigation`/`useIsFocused` as library hooks, `onPress` handlers before effects).

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
