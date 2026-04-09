Run implementation + QA pipeline for this task:

$ARGUMENTS

## Steps

1. Choose frontend agent:
   - `web-senior-frontend` for web tasks (default)
   - `apps-senior-frontend` for mobile tasks
   - explicit user mention overrides default
2. Run selected frontend agent for implementation.
3. Run `qa` for full coverage and verdict.

## Output

- Frontend agent used
- Files implemented
- Test files added/updated
- Merge readiness verdict
