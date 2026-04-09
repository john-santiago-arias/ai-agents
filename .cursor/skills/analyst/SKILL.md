---
name: analyst
description: Business analysis skill that translates requirements into user stories, acceptance criteria, entities, flows, assumptions, and risks before implementation.
---

# Analyst Skill

## Read first

- `.cursor/PROJECT_CONTEXT.md`
- `WORK_PLAN.md` (if available)

## Output file

- Create or update `ANALYSIS.md` in the project root.

## Required sections

1. User stories with Gherkin-style acceptance criteria
2. Functional requirements
3. Non-functional requirements
4. Data entities and relationships
5. User flows
6. Out of scope
7. Assumptions
8. Risk flags
9. Definition of done

## Quality bar

- Each story includes at least 2 Given/When/Then criteria.
- Flag ambiguities as risks; do not invent product decisions.
- Keep artifacts actionable for `architect`, frontend, backend, and `qa`.
