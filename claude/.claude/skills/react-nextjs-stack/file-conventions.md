# File Conventions — React / Next.js

Component declaration, component body order, import order, and the 300-line limit are universal rules — see `.claude/rules/code-style.md` and `.claude/rules/semantics-order.md`.

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
