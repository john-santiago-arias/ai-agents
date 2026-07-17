#!/usr/bin/env bash
# Quality gates — run before any PR; stop if any gate fails
set -e

echo "Type check..."
pnpm check-types

echo "Lint..."
pnpm lint

echo "Tests..."
pnpm test:ci

echo "All gates passed."
