Run a full-stack pipeline for this requirement:

$ARGUMENTS

## Pipeline

1. Invoke `pm` to classify and write `WORK_PLAN.md` as `full-stack`.
2. Invoke `analyst`.
3. Invoke `architect` and `designer` in parallel.
4. Invoke selected frontend agent (`web-senior-frontend` by default, or `apps-senior-frontend` for mobile) and `backend` in parallel.
5. Invoke `qa` as final gate.

## Notes

- Use `.cursor` rules and skills as source of execution behavior.
