---
name: react-nextjs-stack
description: Apply when working on Next.js App Router / React web projects. Covers folder structure, implementation order, component anatomy, server vs client boundaries, Next.js patterns, Tailwind CSS, SVG assets, fonts, and colors. Trigger on any web UI task: new page, component, form, styling, or Next.js-specific pattern.
---

# React / Next.js App Router — Stack Rules

**Stack:** Next.js 14 App Router · React · TypeScript · Zustand · TanStack Query v5 · Tailwind CSS · React Hook Form + Yup · Jest + RTL

→ Component anatomy & file rules: `file-conventions.md`
→ Next.js App Router patterns: `nextjs-patterns.md`
→ TanStack Query, Zustand, RHF, Testing: `../shared-patterns/SKILL.md`

Universal code rules (arrow functions, TypeScript, import/body order, English-only, documentation) load always from `.cursor/rules/` via `AGENTS.md` — not repeated here.

---

## Folder structure

```
my-app/
│
├── .github/
│   ├── workflows/
│   │   ├── ci.yml
│   │   ├── cd.yml
│   │   └── pr-checks.yml
│   └── PULL_REQUEST_TEMPLATE.md
│
├── .husky/
│   ├── pre-commit
│   └── commit-msg
│
├── public/                                         # Assets served by URL (no static import)
│   ├── fonts/
│   ├── icons/
│   │   └── sprite.svg
│   └── images/                                     # Only images referenced as URL strings in external CSS/HTML
│
├── src/
│   │
│   ├── assets/                                     # Assets imported directly in components
│   │   └── images/                                 # import logo from "@/assets/images/logo.png"
│   │
│   ├── app/                                        # Next.js App Router
│   │   ├── [locale]/                               # i18n dynamic segment
│   │   │   ├── (<group>)/                          # Route group — does not affect URL
│   │   │   │   ├── <route>/
│   │   │   │   │   ├── page.tsx                    # Thin shell: <FeatureContainer /> only; Server Component
│   │   │   │   │   ├── loading.tsx
│   │   │   │   │   └── error.tsx
│   │   │   │   └── layout.tsx
│   │   │   ├── layout.tsx
│   │   │   └── page.tsx
│   │   │
│   │   ├── api/
│   │   │   ├── auth/
│   │   │   │   └── [...nextauth]/
│   │   │   │       └── route.ts
│   │   │   └── webhooks/
│   │   │       └── route.ts
│   │   │
│   │   ├── globals.css
│   │   ├── layout.tsx                              # Root layout
│   │   └── not-found.tsx
│   │
│   │
│   ├── components/
│   │   │
│   │   ├── <feature>/                              # camelCase domain folder
│   │   │   ├── <Feature>Container/                 # Orchestrator: data fetching + state
│   │   │   │   ├── <Feature>Container.tsx
│   │   │   │   ├── <Feature>Container.types.ts
│   │   │   │   ├── <Feature>Container.helpers.ts
│   │   │   │   ├── <Feature>Container.test.tsx
│   │   │   │   ├── <Feature>Container.mocks.ts
│   │   │   │   └── index.ts
│   │   │   │
│   │   │   └── <SubComponent>/                     # Sibling to container, NEVER nested inside
│   │   │       ├── <SubComponent>.tsx
│   │   │       ├── <SubComponent>.types.ts
│   │   │       ├── <SubComponent>.helpers.ts
│   │   │       ├── <SubComponent>.test.tsx
│   │   │       ├── <SubComponent>.mocks.ts
│   │   │       └── index.ts
│   │   │
│   │   ├── ui/                                     # Pure primitives — no business logic
│   │   │   ├── <Primitive>/
│   │   │   │   ├── <Primitive>.tsx
│   │   │   │   ├── <Primitive>.variants.ts         # cva / tailwind-variants
│   │   │   │   ├── <Primitive>.test.tsx
│   │   │   │   └── index.ts
│   │   │   └── index.ts                            # Global barrel export for ui/
│   │   │
│   │   ├── global/                                 # Reusable cross-feature components
│   │   │   ├── layouts/
│   │   │   │   ├── AppLayout/
│   │   │   │   │   ├── AppLayout.tsx
│   │   │   │   │   └── index.ts
│   │   │   │   └── AuthLayout/
│   │   │   │       ├── AuthLayout.tsx
│   │   │   │       └── index.ts
│   │   │   ├── navigation/
│   │   │   │   ├── Navbar/
│   │   │   │   │   ├── Navbar.tsx
│   │   │   │   │   ├── Navbar.test.tsx
│   │   │   │   │   └── index.ts
│   │   │   │   └── Sidebar/
│   │   │   │       ├── Sidebar.tsx
│   │   │   │       └── index.ts
│   │   │   ├── feedback/
│   │   │   │   ├── ErrorBoundary/
│   │   │   │   │   ├── ErrorBoundary.tsx
│   │   │   │   │   └── index.ts
│   │   │   │   └── Toast/
│   │   │   │       ├── Toast.tsx
│   │   │   │       └── index.ts
│   │   │   └── seo/
│   │   │       └── MetaTags/
│   │   │           ├── MetaTags.tsx
│   │   │           └── index.ts
│   │   │
│   │   └── animations/                             # Reusable Framer Motion wrappers
│   │       ├── FadeIn/
│   │       │   ├── FadeIn.tsx
│   │       │   └── index.ts
│   │       ├── SlideIn/
│   │       │   ├── SlideIn.tsx
│   │       │   └── index.ts
│   │       ├── StaggerChildren/
│   │       │   ├── StaggerChildren.tsx
│   │       │   └── index.ts
│   │       └── PageTransition/
│   │           ├── PageTransition.tsx
│   │           └── index.ts
│   │
│   │
│   ├── services/                                   # Data access layer (API layer)
│   │   ├── api/
│   │   │   ├── client.ts                           # Instancia base axios/fetch
│   │   │   ├── interceptors.ts
│   │   │   └── endpoints.ts
│   │   │
│   │   ├── <feature>/
│   │   │   ├── <feature>.service.ts                # Pure HTTP calls
│   │   │   ├── <feature>.service.types.ts          # Request / Response DTOs
│   │   │   ├── <feature>.service.hooks.ts          # useQuery / useMutation (TanStack Query)
│   │   │   └── <feature>.service.mock.ts           # Feature-specific MSW handlers
│   │   │
│   │   └── external/
│   │       └── analytics.ts
│   │
│   │
│   ├── stores/                                     # Zustand — client state
│   │   ├── index.ts                                # Global re-exports
│   │   ├── ui/
│   │   │   ├── ui.store.ts                         # Theme, modals, sidebar
│   │   │   ├── ui.store.types.ts
│   │   │   └── ui.store.helpers.ts
│   │   ├── notifications/
│   │   │   ├── notifications.store.ts
│   │   │   ├── notifications.store.types.ts
│   │   │   └── notifications.store.helpers.ts
│   │   └── <feature>/
│   │       ├── <feature>.store.ts                  # Domain-specific Zustand slice
│   │       ├── <feature>.store.types.ts
│   │       └── <feature>.store.helpers.ts          # Selectors, computed helpers
│   │
│   │
│   ├── schemas/                                    # Zod — validation and data contracts
│   │   ├── common/
│   │   │   ├── common.schema.ts                    # Shared schemas (pagination, ids, ...)
│   │   │   └── index.ts
│   │   └── <feature>/
│   │       ├── <feature>.schema.ts                 # z.object({...}) + z.infer<> types
│   │       └── index.ts
│   │
│   │
│   ├── hooks/                                      # Global custom hooks (no domain logic)
│   │   ├── useDebounce.ts
│   │   ├── useLocalStorage.ts
│   │   ├── useMediaQuery.ts
│   │   ├── useOnClickOutside.ts
│   │   ├── useIntersectionObserver.ts
│   │   ├── usePrevious.ts
│   │   ├── useToggle.ts
│   │   └── useWindowSize.ts
│   │
│   │
│   ├── lib/                                        # Third-party library configuration
│   │   ├── query/
│   │   │   ├── queryClient.ts                      # TanStack Query — global instance and defaults
│   │   │   └── queryKeys.ts                        # Global query key factory
│   │   ├── framer/
│   │   │   └── variants.ts                         # Shared animation variants
│   │   ├── i18n/
│   │   │   ├── config.ts
│   │   │   └── request.ts
│   │   └── auth/
│   │       └── nextAuth.config.ts
│   │
│   │
│   ├── i18n/                                       # Internationalization
│   │   ├── locales/
│   │   │   ├── en/
│   │   │   │   ├── common.json
│   │   │   │   └── <feature>.json
│   │   │   └── es/
│   │   │       ├── common.json
│   │   │       └── <feature>.json
│   │   ├── routing.ts
│   │   └── navigation.ts
│   │
│   │
│   ├── types/                                      # Global TypeScript types
│   │   ├── api.types.ts
│   │   ├── common.types.ts
│   │   ├── env.d.ts
│   │   └── global.d.ts
│   │
│   │
│   ├── utils/                                      # Pure functions without side effects
│   │   ├── cn.ts                                   # clsx + tailwind-merge
│   │   ├── date.ts
│   │   ├── format.ts
│   │   └── constants.ts
│   │
│   │
│   └── config/                                     # Static app configuration
│       ├── routes.ts
│       ├── navigation.ts
│       └── site.ts
│
│
├── tests/                                          # Global and E2E tests
│   ├── e2e/
│   │   └── <feature>.spec.ts
│   ├── mocks/
│   │   ├── handlers.ts                             # MSW — global handler composition
│   │   ├── server.ts
│   │   └── data/
│   │       └── <feature>.mock.ts
│   └── utils/
│       └── test-utils.tsx                          # Custom render with all providers
│
├── .env.example
├── .env.local
├── .eslintrc.json
├── .gitignore
├── .prettierrc
├── commitlint.config.js
├── jest.config.ts
├── jest.setup.ts
├── middleware.ts                                   # i18n routing + auth guards
├── next.config.ts
├── postcss.config.js
├── tailwind.config.ts
├── tsconfig.json
└── package.json
```

## Assets: `src/assets/` vs `public/` (non-negotiable)

| Case                                                                                             | Location             | Import                                        |
| ------------------------------------------------------------------------------------------------ | -------------------- | --------------------------------------------- |
| Image used directly in a component (`<Image>`, `<img>`)                                          | `src/assets/images/` | `import logo from "@/assets/images/logo.png"` |
| Image referenced by URL string (CSS `background-image`, external `<img src="...">`, og:image)   | `public/images/`     | `"/images/logo.png"`                          |
| SVG as a React component                                                                          | `src/assets/images/` | `import Logo from "@/assets/images/logo.svg"` |
| SVG sprite or favicon                                                                             | `public/icons/`      | `"/icons/sprite.svg"`                         |
| Self-hosted fonts                                                                                 | `public/fonts/`      | CSS `@font-face url('/fonts/...')`            |

**Rule:** if the file is `import`ed in a `.tsx`, it goes in `src/assets/`. If it is referenced as a URL string, it goes in `public/`.

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
