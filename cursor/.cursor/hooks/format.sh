#!/usr/bin/env bash
# Format then lint-fix the file Cursor just edited (afterFileEdit).
# Fail-open: never block the agent turn.
set -u

input=$(cat)
f=$(python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("file_path") or "")' <<<"$input")
[ -n "$f" ] || exit 0

pnpm exec prettier --write --ignore-unknown "$f" 2>/dev/null || true

case "$f" in
  *.ts|*.tsx|*.js|*.jsx|*.mjs|*.cjs)
    pnpm exec eslint --fix "$f" 2>/dev/null || true
    ;;
esac

exit 0
