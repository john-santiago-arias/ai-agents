# Next.js App Router Patterns

## Server vs Client

- Server components by default
- `"use client"` only for: interactivity, browser APIs, hooks requiring client context
- Identify boundary for every file before writing it

## SSR + TanStack Query

```ts
// Server layout / page
const queryClient = getQueryClient();
await queryClient.prefetchQuery({ queryKey: q('feature', 'list'), queryFn });
return (
  <HydrationBoundary state={dehydrate(queryClient)}>
    {children}
  </HydrationBoundary>
);
```

- `prefetchQuery` / `prefetchInfiniteQuery` in server layouts for key views
- Server prefetch utilities in `src/utils/query.utils.ts` — reuse, don't reinvent
- `headers()` only in server context — never leak request-specific state into global modules

## Providers & metadata

- Global providers in root layout only — never duplicate `QueryClient`
- Preserve `generateMetadata`, canonical URLs, OG tags when changing route data logic
- Route-group organization consistent with existing groups

## Forms

```tsx
const form = useForm<FormValues>({
  resolver: yupResolver(schema),
  defaultValues: stableDefaults,  // never inline on render
});

const onSubmit: SubmitHandler<FormValues> = async (data) => { ... };
const onError: SubmitErrorHandler<FormValues> = (errors) => { ... };
```

- Shared validators in `src/utils/form.utils.ts`
- Disable submit while in-flight — no duplicate submissions
- Preserve input on recoverable failures
- Named handlers in `.helpers.ts` for complex flows

## Assets

- SVGs via SVGR (`@svgr/webpack`); names end with `SVG` suffix — `EyeOffIconSVG`
- Import: `import IconSVG from "@/assets/images/icons/icon.svg"`
- Props: `className`, `aria-hidden`; never inline `<svg>` blocks in JSX
- Types in `src/types/svg.d.ts`

## Fonts (non-negotiable)

- All fonts in `src/config/fonts.ts` — single source of truth
- Use `next/font/google` or `next/font/local`
- Wire CSS variables in root layout → extend `tailwind.config.ts` (in that order)
- Components use Tailwind font classes (`font-sans`) — never hardcode font family strings
- `display: "swap"` on all font definitions

## Colors (non-negotiable)

- All tokens in `src/app/globals.css` — HSL format: `hsl(H S% L%)`
- In `className`: token utilities — `bg-surface-container-low`, `text-on-surface`
- Dynamic `style={{}}`: CSS variable references — `var(--color-error-container)`
- Never hardcode `#hex`, `rgb()`, or named colors in component files

## QA handoff (web-senior-frontend only)

Every interactive element needs `data-testid`.
