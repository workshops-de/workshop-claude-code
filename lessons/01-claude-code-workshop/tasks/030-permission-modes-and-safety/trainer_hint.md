## Learning goals

- **Skills:** reading the starting mode from the status line; selecting and switching permission
  modes; setting defaults; stating boundaries; reading the auto-mode default rules; reading and
  writing permission rules in `/permissions`.
- **Concepts:** oversight-vs-flow trade-off; classifier-based safeguards; protected paths;
  human-in-the-loop; sandboxing for autonomous runs.
- **Takeaways:** match the mode to the risk; looser modes raise the stakes of review; for hard
  guarantees use deny rules and sandboxes, not prompts alone.

## Facilitation notes

- Open with the question from step 1: **which mode does the status line show after start, and why?**
  With Claude Code v2.1.283 or later most participants see `auto mode on`, because auto is the
  built-in starting mode for interactive terminal and VS Code sessions. Others see `manual mode on`:
  an older version, a `permissions.defaultMode` in their settings, an organization that switched
  auto mode off, or a model or plan without auto mode. Let them find the reason themselves; the
  precedence (flag, then settings, then built-in default) is the point.
- The mode that asks before most actions is called **Manual** in the CLI, VS Code, JetBrains and the
  desktop app; its config value is `default` (the CLI also accepts `manual`). Use both names once,
  so participants recognise `default` in settings files and hooks.
- Shift+Tab cycle from auto: Manual → `acceptEdits` → `plan` → `auto`. `bypassPermissions` only
  appears when the session was started with it allowed; `dontAsk` never appears in the cycle.
- If auto mode is unavailable for a participant, walk the docs and `claude auto-mode defaults`
  together instead of the live classifier.
- Later tasks on `bookmonkey-legacy` ask to start in Manual or plan mode so the repository stays
  clean. Mention it here, because an auto-mode default would otherwise let Claude edit files during
  read-only exercises.
- This pairs directly with the "you push it, you own it" theme used throughout the workshop: call
  that connection out explicitly.
- If you have the trainer's private demo hub, show its `/permissions` page before the exercise (4
  minutes: "Who wins?", "A rule is not a fence", live demo). Let the group predict step 5 first:
  deny beats allow, in any order and any file.
- If Claude takes a detour by itself after a blocked `curl` (a script, WebFetch), let it happen.
  That is the lesson: a Bash rule matches command text, it is not a fence. Sandboxes are.
- Check that everyone deleted both `curl` rules at the end of step 5; a leftover deny rule breaks
  later tasks.
- A good live moment: deliberately test whether a stated boundary survives a `/compact`. In short
  test sessions it held (6 of 6), but nothing enforces it. A deny rule does.

## Time estimate

~40 minutes, less if the group already cycled modes during the install task.
