> **⚠️ Setup first:** Start a session in your `bookmonkey-legacy` clone (terminal: `cd bookmonkey-legacy` and `claude`; Desktop App: new session, pick the `bookmonkey-legacy` folder) and send this prompt. No clone yet? Do the setup of task 020 first.
>
> ```text
> Setup for task 030: Check with git remote -v that this folder is the bookmonkey-legacy clone, with git status that it is clean, and with node -v that Node.js 24 or newer is installed. Change nothing. Give me a checklist with ✅ and ❌ at the end.
> ```

---

This task is about **how much Claude may do without asking**. A **permission mode** sets that for the whole session. **Permission rules** make exceptions to it, and a **sandbox** lets the operating system draw limits. You try all three and at the end pick the mode that fits the risk.

You work in your `bookmonkey-legacy` clone. An overview of the modes is at the end.

### 1. Read the mode before you type

Start `claude` in the clone. Which mode does the status line show, and why? Check `claude --version` and `permissions.defaultMode` in your `~/.claude/settings.json` to explain it.

Then press `Shift+Tab` a few times: from `auto` it goes to Manual (`⏸ manual mode on`), then `acceptEdits`, `plan` and back to `auto`.

<details>
<summary>In the desktop app</summary>

There is no status line, and `Shift+Tab` does not switch the mode. You see and switch it in the mode menu below the input field (Windows `Ctrl+Shift+M`, macOS `Cmd+Shift+M`). Commands like `git diff` run in the app's terminal (``Ctrl+` ``).

</details>

<details>
<summary>Answer: why this mode?</summary>

Since Claude Code v2.1.283 a terminal session starts in **auto mode**. A `--permission-mode` flag or `permissions.defaultMode` in your settings takes precedence. If auto mode is not available for your session, it starts in Manual.

</details>

### 2. Change something in `acceptEdits`

Switch to `acceptEdits` (terminal: `Shift+Tab`; desktop app: mode menu, **Accept edits**) and send:

```text
Add the line "Workshop test" in README.md right below the first heading.
```

The change comes without a prompt. Read the diff: `git diff` (desktop app: in the app's diff view or in the app's terminal).

Then take it back with **rewind**: `/rewind` (in the terminal also `Esc` twice), pick your message from just now, then **Restore code**. This works in the desktop app too. Rewind only restores changes Claude made with Edit or Write, not through Bash. Fallback: `git restore .`.

### 3. Compare auto and Manual

Run `claude auto-mode defaults` in a second terminal and find two actions the classifier blocks by default and two it allows. Then give a well-scoped task that runs commands in **auto mode**. Switch to **Manual** with `Shift+Tab` and give the same task again. Count the prompts in both modes. If you answer a Bash prompt in Manual with "Yes, and don't ask again", the rule then sits in `.claude/settings.local.json`.

Without the CLI in the desktop app: the default rules are on the docs page [Configure auto mode](https://code.claude.com/docs/en/auto-mode-config).

### 4. Turn a wish into a rule

Tell Claude in the conversation: "Do not run any network commands until I say so." Ask Claude for `curl -I https://example.com` and check whether it sticks to it. Run `/compact` and check again: does the limit hold after compacting?

Then write the same limit as a **deny rule** in `.claude/settings.local.json`:

```json
{"permissions": {"deny": ["Bash(curl *)"]}}
```

Test a third time. The sentence in the conversation is a wish to the model, the deny rule is checked by Claude Code on every command.

<details>
<summary>Native Windows without Git for Windows</summary>

Claude uses the **PowerShell tool** there, a `Bash(...)` rule does not apply. Add `"PowerShell(curl *)", "PowerShell(curl.exe *)", "PowerShell(Invoke-WebRequest *)"` and test with `curl.exe -I https://example.com`. Create the file in your editor or let Claude create it, not with `>` in Windows PowerShell (that saves it as UTF-16).

</details>

### 5. Find the rule in `/permissions` and look for its gap

Open `/permissions`, switch tabs with `←` and `→` and find your deny rule. The dialog shows which file it comes from. In the **Allow** tab, add the same rule `Bash(curl *)` (local project settings).

Predict first: who wins, deny or allow? Then let Claude run `curl -I https://example.com` and read the message: who won?

Now ask for `sh -c 'curl -I https://example.com'` (Windows without Git: `cmd /c curl.exe -I https://example.com`). Does the deny rule apply? Why not? If a prompt comes, answer No. Delete both rules afterwards.

If `/permissions` is not available in the desktop app, start `claude` in the app's terminal.

### 6. Pick the mode for the risk

Which mode fits, and why? Exploring an unknown repo. Iterating on code you are reviewing right now. A locked-down CI job.

### 7. Let the operating system stop it

A **sandbox** does not read command text. It limits what the running process may access. Check with `/sandbox` whether it is on, and switch it off for this step. Native Windows has no sandbox, and this step needs the CLI: watch someone on macOS, Linux or WSL2 and predict what happens.

In a second terminal create `echo secret > ~/sandbox-demo.txt` and give Claude this prompt:

```text
Run exactly this command once, no alternatives: python3 -c "import os; h=os.path.expanduser('~'); print(open(h+'/sandbox-demo.txt').read()); open(h+'/sandbox-demo-2.txt','w').write('x'); print('WRITE OK')"
```

If Claude asks, allow the command. If the classifier blocks it, switch to Manual and confirm. Python reads and writes outside the project, and it works. Predict what happens with the sandbox. Quit with `/exit` and start again:

```bash
claude --settings '{"permissions":{"blockReadsOutsideWorkingDirectories":true},"sandbox":{"enabled":true,"allowUnsandboxedCommands":false,"failIfUnavailable":true}}'
```

Send the same prompt. On macOS Python reports `PermissionError: [Errno 1] Operation not permitted`. Same code, but the operating system said no, not Claude. Clean up: `rm -f ~/sandbox-demo.txt ~/sandbox-demo-2.txt`.

<details>
<summary>In the desktop app</summary>

In the app, `/sandbox` opens the settings:

1. Turn on **Local sandbox** and, below it, **Strict sandbox mode** (blocks commands that cannot run in the sandbox instead of asking).
2. Start a new session (**+ New**), because the sandbox only applies to new sessions. Send the Python prompt from above.
3. Predict what happens. Without `blockReadsOutsideWorkingDirectories` the sandbox usually allows reading but not writing outside the project: Python prints `secret` and then reports `PermissionError` on the write.
4. Turn both switches off again afterwards. **Strict sandbox mode** also applies in the terminal.

</details>

### What just happened

| Mode | Without asking |
|---|---|
| Manual (`default`) | read only |
| `acceptEdits` | read, edit files |
| `plan` | read only, change nothing |
| `auto` | Claude acts, a classifier checks every action first |
| `dontAsk` | only tools allowed in advance, nothing else |
| `bypassPermissions` | everything except deny rules, no other checks, only in an isolated container or VM |

| Lever | Checked by | Gap |
|---|---|---|
| Sentence in the conversation | the model, if it sticks to it | no guarantee |
| Deny rule | Claude Code, on the command text | `sh -c '…'` is a different text |
| Sandbox | the operating system, on access | covers shell commands, not Claude's file tools, MCP servers or hooks |

Rules are checked in a fixed order: **deny, then ask, then allow**. The first match decides, so a more specific rule does not win. If no rule matches, the mode decides.

**Done when** you can say which mode your session starts in and why, how many prompts auto and Manual gave, which file a rule comes from, who wins between deny and allow, why `sh -c` gets past the deny rule, who stopped the Python command, and you have picked a mode for the three scenarios.

<details>
<summary>More on this</summary>

A rule has the form `Tool` or `Tool(specifier)`, for example `Bash(curl *)` or `Edit(./src/**)` (edits below `src/`). An ask rule asks even when an allow rule matches as well. A deny rule blocks in every mode, including `bypassPermissions`. Rules live in `~/.claude/settings.json` (you, everywhere), `.claude/settings.json` (team, in Git), `.claude/settings.local.json` (you, this repo) and in managed settings (your IT). A deny on one level beats an allow on any other. Docs: [Permission modes](https://code.claude.com/docs/en/permission-modes), [Configure auto mode](https://code.claude.com/docs/en/auto-mode-config), [Permissions](https://code.claude.com/docs/en/permissions), [Sandboxing](https://code.claude.com/docs/en/sandboxing).

</details>
