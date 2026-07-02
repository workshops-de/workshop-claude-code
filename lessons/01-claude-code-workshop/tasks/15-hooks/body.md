## Overview

Make quality and safety **deterministic** with hooks — shell commands that run automatically on
Claude Code lifecycle events. You will enforce guarantees that don't depend on the model
"remembering," such as formatting and type-checking changed files, or blocking access to secrets.

## Background

Hooks register scripts that fire on events in the agent's lifecycle — after an edit, before a
commit, and so on. Because they run every time, regardless of what the model decides, they turn
"please remember to format" into an actual guarantee.

## Steps

1. Add a **post-edit hook** that runs when files are written or edited and automatically formats
   the changed file(s) and runs a fast type-check.
2. Add a **safety hook** that blocks reading or writing sensitive paths (environment files, key
   material).
3. Trigger them: make a trivial edit and confirm formatting/type-checking run on their own; then
   ask the agent to read an environment file and confirm it is blocked.
4. Reflect on why these guarantees are stronger as hooks than as lines in your project memory.
5. Optionally add a pre-commit hook that runs lint and aborts on failure.

## Success Criteria

- [ ] A post-edit hook formats and type-checks automatically on file changes
- [ ] A safety hook blocks reads/writes to at least one sensitive path
- [ ] Both hooks were triggered and observed to fire

## References

- Claude Code — Hooks: https://code.claude.com/docs/en/hooks
- Claude Code — Settings: https://code.claude.com/docs/en/settings
- Claude Code — Best practices: https://code.claude.com/docs/en/best-practices
