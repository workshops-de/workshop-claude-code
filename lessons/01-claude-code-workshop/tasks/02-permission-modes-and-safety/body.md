## Overview

Understand and control **how much autonomy** you grant Claude Code, so you can match oversight to
risk. You will learn the permission modes (`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`,
`bypassPermissions`), how to switch between them, and the safeguards that protect you — including
**auto mode's** background safety classifier and the idea of human-in-the-loop boundaries. This
underpins every later task: the looser the mode, the more your review discipline matters.

## Background

When Claude wants to edit a file, run a command, or make a network request, it normally pauses for
approval. Permission modes change how often that pause happens, trading oversight for flow. `plan`
and `default` only read without asking; `acceptEdits` writes files (and common filesystem commands)
without prompting; `auto` lets Claude act with a separate classifier model reviewing each action
first; `dontAsk` allows only pre-approved tools (ideal for locked-down CI); `bypassPermissions`
skips checks entirely and is only safe in an isolated container or VM.

## Steps

1. In a session, **cycle** through `default` → `acceptEdits` → `plan` with `Shift+Tab` and watch
   the status indicator. Note what each allows without asking.
2. Make a small edit in `acceptEdits` and confirm it applied without a prompt; then review the
   change with `git diff` afterward.
3. If your account supports it, try **auto mode** on a contained task and observe the classifier:
   inspect the default rules and identify two actions it blocks and two it allows by default.
4. State a **boundary** in conversation (for example, "don't run any network commands until I say
   so") and verify Claude respects it even where defaults would allow the action.
5. Decide, for three scenarios (exploring an unfamiliar repo, iterating on code you're reviewing, a
   locked-down CI job), which mode fits and why.
6. Read how to run autonomously **safely** — a sandbox or dev container — and note why deterministic
   isolation is stronger than prompt-based safeguards.

## Success Criteria

- [ ] You can name each permission mode and what it does without asking
- [ ] You confirmed at least one boundary was respected in conversation
- [ ] You can explain the difference between a stated boundary and a deny rule
- [ ] You picked an appropriate mode for each of the three given scenarios

## References

- Claude Code — Choose a permission mode: https://code.claude.com/docs/en/permission-modes
- Claude Code — Configure auto mode: https://code.claude.com/docs/en/auto-mode-config
- Claude Code — Permissions (allow/ask/deny rules): https://code.claude.com/docs/en/permissions
- Claude Code — Sandboxing: https://code.claude.com/docs/en/sandboxing
