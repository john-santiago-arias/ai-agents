# TanStack Query v5

## Query keys

```ts
['feature', 'list', { filters }]   // list with optional filters
['feature', 'detail', id]          // single record
```

- Use existing `q()` factory when available in the project
- `enabled: !!id` when required ids may be undefined

## After mutations — never leave cache stale

```ts
// Invalidate
queryClient.invalidateQueries({ queryKey: q('feature', 'list') });

// Or optimistic update
queryClient.setQueryData(q('feature', 'detail', id), updatedData);
```

## v5 specifics

- `gcTime` (not `cacheTime`)
- Hooks live in `<feature>.service.hooks.ts` — never inline in components

## SSR (Next.js only)

- `prefetchQuery` / `prefetchInfiniteQuery` in server layouts
- Reuse utilities in `src/utils/query.utils.ts` — don't reinvent
