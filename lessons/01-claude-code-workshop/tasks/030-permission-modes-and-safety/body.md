## Overview

Understand and control **how much autonomy** you grant Claude Code, so you can match oversight to
risk. You will learn the permission modes (Manual (`default`), `acceptEdits`, `plan`, `auto`,
`dontAsk`, `bypassPermissions`), which one a session starts in, how to switch between them, and
the safeguards that protect you, including **auto mode's** background safety classifier, the idea
of human-in-the-loop boundaries, and the **permission rules** you manage with `/permissions`. This underpins every later task: the looser the mode, the
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

A mode is only the baseline. **Permission rules** are the exceptions, and `/permissions` is where
you see and change them. What an **allow** rule matches runs without asking, an **ask** rule prompts
even if an allow rule also matches, and a **deny** rule blocks, in every mode, including
`bypassPermissions`. The order is fixed: deny, then ask, then allow. The first match decides, so a more specific rule does
not win. If no rule matches, the mode decides.

A rule is written `Tool` or `Tool(specifier)`, for example `Bash(curl *)` (shell commands that
start like this) or `Edit(./src/**)` (edits below `src/`). The Permissions doc lists every shape.

Rules live in `~/.claude/settings.json` (you, everywhere), `.claude/settings.json` (team, in git),
`.claude/settings.local.json` (you, this repo) and managed settings (your IT). A deny on any level
beats an allow on any other.

## Steps

1. **Start a session and read the status line** before you type anything (`claude` in your
   `bookmonkey-legacy` clone). Which mode does it show, and why? Check `claude --version` and your
   `~/.claude/settings.json` (`permissions.defaultMode`) to explain it. Then press `Shift+Tab`
   several times and watch the status line: from `auto` the first press switches to Manual
   (`⏸ manual mode on`), then the cycle runs Manual → `acceptEdits` → `plan` → back to `auto`.
2. Make a small edit in `acceptEdits` and confirm it applied without a prompt; then review the
   change with `git diff` afterward. Undo it with `git restore .`, so the clone stays clean for
   the next tasks.
3. Cycle back to **auto mode** and give it a contained task. Observe the classifier: run
   `claude auto-mode defaults` in a second terminal to read the default rules, and identify two
   actions it blocks and two it allows by default. Then switch to Manual (`default`) and give the
   same task: count the prompts you get now. If you answer a Bash prompt with "Yes, and don't ask
   again", open `.claude/settings.local.json` afterwards: the rule is now there.
4. State a **boundary** in conversation (for example, "don't run any network commands until I say
   so") and verify Claude respects it even where defaults would allow the action.
   Run `/compact` and test the boundary again. Then write the same boundary as a **deny rule**: create
   `.claude/settings.local.json` with `{"permissions": {"deny": ["Bash(curl *)"]}}` and test once
   more.
5. **Open `/permissions`** and find your `Bash(curl *)` deny rule: `←` and `→` switch the tabs
   (Allow, Ask, Deny, Workspace and, where available, Recently blocked and Auto mode), and the
   dialog shows the settings file each rule comes from. Then add the same rule `Bash(curl *)` on
   the **Allow** tab; if asked where to save it, pick the local project settings. Before you test:
   which one wins, the older deny or the newer allow? Ask Claude to run
   `curl -I https://example.com` and read the message. Now ask for
   `sh -c 'curl -I https://example.com'`. This time the deny rule does not fire: it matches the
   command text `curl …`, not the same program inside a shell. If you get a prompt, answer No (in
   auto mode, watch what the classifier does). Delete both rules afterwards, so later tasks can
   use `curl` again.
6. Decide, for three scenarios (exploring an unfamiliar repo, iterating on code you're reviewing, a
   locked-down CI job), which mode fits and why.
7. **Let the operating system stop a command.** A sandbox does not read the command text like the
   deny rule in step 5 (remember the `sh -c` detour). It limits what the running process may touch.
   If `/sandbox` shows that your sandbox is already on, turn it off for this step.
   1. In a second terminal, create a file outside the project: `echo secret > ~/sandbox-demo.txt`.
   2. Give Claude this prompt and allow the command if it asks. Python reads the file and writes
      `~/sandbox-demo-2.txt`, both outside the project:

      ```text
      Run exactly this command once, no alternatives: python3 -c "import os; h=os.path.expanduser('~'); print(open(h+'/sandbox-demo.txt').read()); open(h+'/sandbox-demo-2.txt','w').write('x'); print('WRITE OK')"
      ```

   3. Predict: what happens to the same prompt with the sandbox on? Then leave with `/exit`, start
      again with the sandbox on and reads outside the project blocked, and send the same prompt:

      ```bash
      claude --settings '{"permissions":{"blockReadsOutsideWorkingDirectories":true},"sandbox":{"enabled":true,"allowUnsandboxedCommands":false,"failIfUnavailable":true}}'
      ```

      On macOS, Python now reports `PermissionError: [Errno 1] Operation not permitted` (Linux and
      WSL2 may word it differently, native Windows has no sandbox). The code is the same, but the
      operating system said no, not Claude.
   4. Clean up: `rm -f ~/sandbox-demo.txt ~/sandbox-demo-2.txt`.

   The sandboxing page lists what stays outside the sandbox: Claude's own file tools, MCP servers
   and hooks.

## Success Criteria

- [ ] You can say which mode your session started in, and why
- [ ] You ran the same task in auto and in Manual and can say how many prompts each gave
- [ ] You confirmed at least one boundary was respected in conversation
- [ ] You can explain the difference between a stated boundary and a deny rule
- [ ] You can say in which order deny, ask and allow are checked, and what happens if no rule matches
- [ ] You found a rule in `/permissions` and can say which settings file it comes from
- [ ] You saw a `Bash(curl *)` deny rule stop `curl` but not `sh -c 'curl …'`, and can say why
- [ ] You picked an appropriate mode for each of the three given scenarios
- [ ] You saw the same Python command work without the sandbox and fail with `Operation not permitted` with the sandbox and blocked reads, and can say who stopped it

## References

- Claude Code: Choose a permission mode: https://code.claude.com/docs/en/permission-modes
- Claude Code: Configure auto mode: https://code.claude.com/docs/en/auto-mode-config
- Claude Code: Permissions (allow/ask/deny rules): https://code.claude.com/docs/en/permissions
- Claude Code: Sandboxing: https://code.claude.com/docs/en/sandboxing
