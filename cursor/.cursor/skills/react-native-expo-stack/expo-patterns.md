# Expo / React Native Patterns

## Expo / EAS

- Expo-compatible APIs and `app.config` over ad-hoc native edits
- New native capabilities: Expo config plugins only
- Never commit secrets — EAS Secrets / `.env` per repo policy

## React Navigation

- Typed param lists — params must be serializable (no functions, no non-serializable objects)
- No duplicate screen registration
- Nav params received in screen, passed as props to container — never `useNavigation` inside a container

## Colors (non-negotiable)

- All tokens in `tailwind.config.js` — HSL format: `hsl(210, 18%, 96%)`
- In `className`: token utilities — `bg-surface-container-low`, `text-on-surface`
- Dynamic colors: `src/theme/colors.ts` constants — never inline hex
- Never hardcode `#hex`, `rgb()`, or color names in components

## Fonts (non-negotiable)

- All font definitions in `src/theme/fonts.ts` — single source of truth
- Loaded with `useFonts` in root `_layout.tsx` — never in individual components
- Components use NativeWind classes (`font-sans`) — never hardcode `fontFamily: "Inter"`
- New font: add asset → register in `fontMap` → extend `tailwind.config.js`
- `SplashScreen.preventAutoHideAsync()` + hide after fonts loaded

## Assets (non-negotiable)

- SVGs via `react-native-svg-transformer`; names end with `SVG` suffix — `EyeOffIconSVG`
- Import: `import IconSVG from "@/assets/images/icons/icon.svg"`
- Props: `width`, `height`, `color`, `accessibilityLabel`
- Raster: `expo-image` `<Image>` with `require()` — never raw `<img>`

## Reanimated

- `useSharedValue`, `useAnimatedStyle`, `withTiming` — UI thread only
- `runOnJS` when calling React state setters from worklets
- `react-native-reanimated/plugin` MUST be last in `babel.config.js`

## Accessibility

- `accessibilityLabel` + `accessibilityRole` on all interactive elements
- `testID` on every interactive element

## Schemas

- All Zod schemas in `src/schemas/<feature>/<feature>.schema.ts`
- `.types.ts` holds TypeScript interfaces only — NOT Zod schemas
- Use `zodResolver` from `@hookform/resolvers/zod`
