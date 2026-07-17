---
name: react-native-expo-stack
description: Apply when working on React Native / Expo mobile projects. Covers folder structure, implementation order, component anatomy, NativeWind styling, React Navigation, Reanimated, Expo/EAS config, and testID accessibility. Trigger on any mobile UI task: screen, component, Expo config change, or RN + tests in one pass.
allowed-tools: Read, Glob, Grep
---

# React Native / Expo — Stack Rules

**Stack:** Expo + EAS · Zustand · TanStack Query v5 · React Navigation · NativeWind · React Hook Form + Zod · Jest + RNTL · Reanimated

→ Component anatomy & file rules: `file-conventions.md`
→ Expo / RN specific patterns: `expo-patterns.md`
→ TanStack Query, Zustand, RHF, Testing: `../shared-patterns/SKILL.md`

Universal code rules (arrow functions, TypeScript, import/body order, English-only, documentation) load always from `.claude/rules/` via `CLAUDE.md` — not repeated here.

---

## Folder structure

```
src/
  components/
    <feature>/              ← camelCase domain folder
      FeatureContainer/     ← PascalCase; contains ONLY its own files
        Feature.tsx
        Feature.types.ts
        Feature.styles.ts
        Feature.helpers.ts
        Feature.test.tsx
      SubComponent/         ← sibling at feature level, NEVER nested inside container
  screens/
    FeatureScreen.tsx       ← thin shell: <FeatureContainer /> only
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
  theme/
    fonts.ts
    colors.ts
```

## Implementation order (strict)

1. **Types** — `ComponentName.types.ts`
2. **Helpers** — `ComponentName.helpers.ts`
3. **Styles** — `ComponentName.styles.ts` — ALL NativeWind strings here
4. **Service** — `<feature>.service.ts` + `<feature>.service.types.ts`
5. **Query hooks** — `<feature>.service.hooks.ts`
6. **Store** — `<feature>.store.ts` + types + helpers
7. **Component** — `ComponentName.tsx`
8. **Screen** — `<Feature>.screen.tsx` — thin shell
9. **Navigation** — update navigator with typed params
10. **Tests** — colocated, after each logical slice
