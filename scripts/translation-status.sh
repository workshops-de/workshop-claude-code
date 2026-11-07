#!/usr/bin/env bash
# Show the German translation status of every task.
#
# usage: scripts/translation-status.sh [--todo]
#   --todo  only list tasks that still need work (missing or stale)
#
# For each task folder it checks every English source file (body.md, hint.md,
# bonus.md, trainer_hint.md) against its German sibling (*.de.md), plus the
# German title in task.yml (translations.de.title).
#
#   ok       German file exists and was committed at or after the English one
#   MISSING  German file (or title) does not exist yet
#   STALE    English file was committed after the German one -> re-translate
#
# Staleness is based on the last commit touching each file, so commit the
# English change and the translation separately or together - both work.
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
tasks="$root/lessons/01-claude-code-workshop/tasks"
todo_only=false
[[ "${1:-}" == "--todo" ]] && todo_only=true

last_commit() { git -C "$root" log -1 --format=%ct -- "$1" 2>/dev/null || true; }

total=0; done_count=0
for dir in "$tasks"/*/; do
  task="$(basename "$dir")"
  lines=(); needs_work=false
  for en in body hint bonus trainer_hint; do
    [[ -f "$dir/$en.md" ]] || continue
    total=$((total + 1))
    de="$dir/$en.de.md"
    if [[ ! -f "$de" ]]; then
      lines+=("  MISSING  $en.de.md"); needs_work=true; continue
    fi
    en_ts="$(last_commit "$dir/$en.md")"; de_ts="$(last_commit "$de")"
    if [[ -z "$de_ts" ]]; then
      lines+=("  ok*      $en.de.md (not committed yet)"); done_count=$((done_count + 1))
    elif [[ -n "$en_ts" && "$en_ts" -gt "$de_ts" ]]; then
      lines+=("  STALE    $en.de.md ($en.md changed since the translation)"); needs_work=true
    else
      lines+=("  ok       $en.de.md"); done_count=$((done_count + 1))
    fi
  done
  total=$((total + 1))
  if grep -qE '^[[:space:]]+title:' <(sed -n '/^translations:/,$p' "$dir/task.yml"); then
    lines+=("  ok       task.yml translations.de.title"); done_count=$((done_count + 1))
  else
    lines+=("  MISSING  task.yml translations.de.title"); needs_work=true
  fi
  if ! $todo_only || $needs_work; then
    echo "$task"; printf '%s\n' "${lines[@]}"
  fi
done
echo
echo "Translated: $done_count / $total files (incl. titles)"
