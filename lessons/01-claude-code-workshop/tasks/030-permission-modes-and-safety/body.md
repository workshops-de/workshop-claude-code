## Overview

Understand and control **how much autonomy** you grant Claude Code, so you can match oversight to
risk. You will learn the permission modes (Manual (`default`), `acceptEdits`, `plan`, `auto`,
`dontAsk`, `bypassPermissions`), which one a session starts in, how to switch between them, and
the safeguards that protect you, including **auto mode's** background safety classifier and the
idea of human-in-the-loop boundaries. This underpins every later task: the looser the mode, the
more your review discipline matters.

## Background

When Claude wants to edit a file, run a command, or make a network request, a permission mode
decides whether it asks you first. **Manual** (config value `default`) and `plan` only read without
asking; `acceptEdits` writes files (and common filesystem commands) without prompting; `auto` lets
Claude act while a separate classifier model reviews each action first; `dontAsk` allows only
pre-approved tools (ideal for locked-down CI); `bypassPermissions` skips checks entirely and is
only safe in an isolated container or VM.

Since Claude Code v2.1.283, **auto mode is the built-in starting mode** for interactive terminal
and VS Code sessions. A `--permission-mode` flag or `permissions.defaultMode` in a settings file
wins over that built-in default, and if auto mode is not available to your session, it starts in
Manual instead.

## Steps

1. **Start a session and read the status line** before you type anything (`claude` in your
   `bookmonkey-legacy` clone). Which mode does it show, and why? Check `claude --version` and your
   `~/.claude/settings.json` (`permissions.defaultMode`) to explain it. Then press `Shift+Tab`
   several times and watch the status line: from `auto` the first press switches to Manual
   (`⏸ manual mode on`), then the cycle runs Manual → `acceptEdits` → `plan` → back to `auto`.
   Note what each mode allows without asking.
2. Make a small edit in `acceptEdits` and confirm it applied without a prompt; then review the
   change with `git diff` afterward. Undo it with `git restore .`, so the clone stays clean for
   the next tasks.
3. Cycle back to **auto mode** and give it a contained task. Observe the classifier: run
   `claude auto-mode defaults` in a second terminal to read the default rules, and identify two
   actions it blocks and two it allows by default. Then switch to Manual (`default`) and give the
   same task: count the prompts you get now.
4. State a **boundary** in conversation (for example, "don't run any network commands until I say
   so") and verify Claude respects it even where defaults would allow the action.
   Then write the same boundary as a **deny rule** in `.claude/settings.local.json` (under
   `permissions`, for example `"deny": ["Bash(curl *)"]`), run `/compact`, and test again.
5. Decide, for three scenarios (exploring an unfamiliar repo, iterating on code you're reviewing, a
   locked-down CI job), which mode fits and why.
6. Read how to run autonomously **safely** (a sandbox or dev container) and note why deterministic
   isolation is stronger than prompt-based safeguards.

## Success Criteria

- [ ] You can say which mode your session started in, and why
- [ ] You can name each permission mode and what it does without asking
- [ ] You confirmed at least one boundary was respected in conversation
- [ ] You can explain the difference between a stated boundary and a deny rule
- [ ] You picked an appropriate mode for each of the three given scenarios

## References

- Claude Code: Choose a permission mode: https://code.claude.com/docs/en/permission-modes
- Claude Code: Configure auto mode: https://code.claude.com/docs/en/auto-mode-config
- Claude Code: Permissions (allow/ask/deny rules): https://code.claude.com/docs/en/permissions
- Claude Code: Sandboxing: https://code.claude.com/docs/en/sandboxing
