---
name: react-nextjs-stack
description: Apply when working on Next.js App Router / React web projects. Covers folder structure, implementation order, component anatomy, server vs client boundaries, Next.js patterns, Tailwind CSS, SVG assets, fonts, and colors. Trigger on any web UI task: new page, component, form, styling, or Next.js-specific pattern.
allowed-tools: Read, Glob, Grep
---

# React / Next.js App Router — Stack Rules

**Stack:** Next.js 14 App Router · React · TypeScript · Zustand · TanStack Query v5 · Tailwind CSS · React Hook Form + Yup · Jest + RTL

→ Component anatomy & file rules: `file-conventions.md`
→ Next.js App Router patterns: `nextjs-patterns.md`
→ TypeScript, TanStack Query, Zustand, RHF, Assets, Testing: `../shared-patterns/SKILL.md`

---

## Folder structure

```
src/
  app/
    (group)/
      route/
        page.tsx              ← thin shell: <FeatureContainer /> only; Server Component
  components/
    <feature>/                ← camelCase domain folder
      FeatureContainer/       ← PascalCase; contains ONLY its own files
        Feature.tsx
        Feature.types.ts
        Feature.helpers.ts
        Feature.test.tsx
        Feature.mocks.ts
      SubComponent/           ← sibling at feature level, NEVER nested inside container
  ui/                         ← shared primitives (buttons, inputs, modals)
  components/global/          ← reusable cross-feature components
  services/
    <feature>/
      <feature>.service.ts
      <feature>.service.types.ts
      <feature>.service.hooks.ts
      <feature>.service.mock.ts
  stores/
    <feature>/
      <feature>.store.ts
      <feature>.store.types.ts
      <feature>.store.helpers.ts
  types/
  utils/
  schemas/
    <feature>/
      <feature>.schema.ts
```

## Implementation order (strict)

1. **Types** — `ComponentName.types.ts`
2. **Helpers** — `ComponentName.helpers.ts`
3. **Styles** — inline `className`; extract named `const` only when long AND reused in 2+ places; no `.styles.ts` unless project already uses it
4. **Service** — `<feature>.service.ts` + `<feature>.service.types.ts`
5. **Query hooks** — `<feature>.service.hooks.ts`
6. **Store** — `<feature>.store.ts` + types + helpers
7. **Server component / layout** — prefetch, `dehydrate`, wrap with `HydrationBoundary`
8. **Client components** — `"use client"` only for interactivity or browser APIs
9. **Forms** — React Hook Form + `yupResolver`, explicit `SubmitHandler` typing
10. **Tests** — colocated, after each logical slice
