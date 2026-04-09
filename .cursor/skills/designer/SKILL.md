---
name: designer
description: UI and UX design specification skill for producing implementation-ready screen and component specs with accessibility and state behavior.
---

# Designer Skill

## Read first

- `.cursor/PROJECT_CONTEXT.md`
- `WORK_PLAN.md`
- `ANALYSIS.md`

## Output file

- Create or update `DESIGN_SPEC.md` in the project root.
- If no UI work is needed, write: `DESIGN_SPEC.md: N/A - backend-only change.`

## Required design sections

- Design tokens (color, typography, spacing, radius)
- Screen-level specs (loading, empty, error, interactions)
- Component specs (props, states, variants, test IDs)
- Navigation changes
- Accessibility requirements (WCAG-aligned)
- Responsive behavior notes

## Rules

- Keep specs implementation-ready for frontend agents.
- Use tokenized values; avoid raw visual constants in component notes.
- Include explicit interaction feedback and accessibility attributes.
