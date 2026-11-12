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
  minutes: "Who wins?", "What a deny rule does not cover", live demo). Let the group predict step 5 first:
  deny beats allow, in any order and any file.
- If Claude takes a detour by itself after a blocked `curl` (a script, WebFetch), let it happen.
  That is the lesson: a Bash rule only checks the command text, it does not lock anything. A
  sandbox does, as step 7 shows.
- Step 7 also works as a 5-minute trainer demo (hub: Permissions, card "How to keep Claude in the
  project folder", fold "Demo"; the Day 4 run sheet links to it). Let the group predict the second run first. Tested on 12 Nov with
  Claude Code 2.1.319 and Haiku 5.5 through `claude -p`: without the sandbox the command read and
  wrote in the home folder; with only `sandbox.enabled` it could read but not write; with
  `blockReadsOutsideWorkingDirectories` as well, the read failed too. Not tested in an interactive
  auto mode session: if the classifier blocks the first run, switch to Manual and confirm the
  prompt.
- Check that everyone deleted both `curl` rules at the end of step 5; a leftover deny rule breaks
  later tasks.
- A good live moment: deliberately test whether a stated boundary survives a `/compact`. In short
  test sessions it held (6 of 6), but nothing enforces it. A deny rule does.

## Time estimate

~45 minutes, less if the group already cycled modes during the install task.
