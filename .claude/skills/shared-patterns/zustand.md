# Zustand

## Scope

Client/UI state only — never duplicate server cache (TanStack Query owns server state).

## Pattern

```ts
// <feature>.store.helpers.ts
export const defaultValues: FeatureState = { ... };

// <feature>.store.ts
export const useFeatureStore = create<FeatureState & FeatureActions>()(
  devtools((set) => ({
    ...defaultValues,
    setX: (value) => set({ value }, false, { type: 'setX', payload: value }),
    resetX: () => set(defaultValues, false, { type: 'resetX' }),
    clearX: () => set({ x: null }, false, { type: 'clearX' }),
  }))
);
```

## Rules

- Narrow selectors: `useFeatureStore(s => s.specificSlice)`
- Action names: verbs — `setX`, `resetX`, `clearX`
- `reset` restores `defaultValues` deterministically
- `defaultValues` in `.store.helpers.ts`
- No UI components or screen concerns inside stores
- Follow `create(...devtools(...))` pattern from existing stores
