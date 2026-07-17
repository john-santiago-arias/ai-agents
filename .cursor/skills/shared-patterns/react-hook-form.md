# React Hook Form

## Web (Yup)

```tsx
const form = useForm<FormValues>({
  resolver: yupResolver(schema),
  defaultValues: stableDefaults,  // never inline on render
});

const onSubmit: SubmitHandler<FormValues> = async (data) => { ... };
const onError: SubmitErrorHandler<FormValues> = (errors) => { ... };
```

- Shared validators in `src/utils/form.utils.ts`

## Mobile (Zod)

```tsx
const form = useForm<FormValues>({
  resolver: zodResolver(schema),
  defaultValues: stableDefaults,
});
```

- `Controller` / `useController` for RN inputs

## Shared rules

- Stable `defaultValues` — never inline on render
- Disable submit while in-flight — no duplicate submissions
- Preserve input on recoverable failures
- Named handlers (`create`, `update`, `submit`) in `.helpers.ts` for complex flows
