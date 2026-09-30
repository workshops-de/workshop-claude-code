## Overview

Make quality and safety **deterministic** with hooks — commands that Claude Code runs on
lifecycle events, every time, regardless of what the model decides. You set up a format/type-check
hook and a secrets guard first, then build the most intricate feature of the app with both active.

## The Feature

Hooks are configured in settings (`.claude/settings.json` for the project, commit it) and fire on
events such as `PreToolUse` (before a tool runs — can block), `PostToolUse` (after it ran),
`Stop`, or `SessionStart`.

- **Matchers** pick the tools a hook applies to, e.g. `"Edit|Write"`.
- **Input** arrives as JSON on stdin — the edited file is at `.tool_input.file_path`:

  ```json
  {
    "hooks": {
      "PostToolUse": [
        {
          "matcher": "Edit|Write",
          "hooks": [
            {
              "type": "command",
              "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write"
            }
          ]
        }
      ]
    }
  }
  ```

- **Blocking** — in a `PreToolUse` hook, `exit 2` blocks the tool call and your stderr is shown to
  Claude as the reason. Careful: `exit 1` does **not** block, it's treated as a non-blocking error.
- **Scripts** — keep longer logic in `.claude/hooks/*.sh` (executable) and reference it as
  `"${CLAUDE_PROJECT_DIR}/.claude/hooks/guard.sh"`.
- **Inspect** — `/hooks` shows every configured hook, its matcher, and which settings file it came
  from.

Memory advises; hooks enforce.

## Apply it to Clash

The practice ground is the heart of the domain: people **request to join** an activity, hosts
**accept or reject**, and each transition **notifies** the right person. A participation moves
from _pending_ to _accepted_ or _rejected_ — nothing else. It touches schema, server actions,
authorization, and UI in many files at once: exactly where a hook that formats and type-checks
every edit keeps the agent honest.

## Prerequisites

- `jq` installed (used to read hook input).
- Recommended: `prisma-client-api`, `react-best-practices`

## Steps

1. Add a **`PostToolUse`** hook for `Edit|Write` that formats the changed file and runs a fast
   type-check. Make a trivial edit and confirm it fires.
2. Add a **`PreToolUse`** guard script that blocks reads and writes to `.env*` files and key
   material with `exit 2`. Ask the agent to read your `.env` and confirm it's blocked with your
   message.
3. Check both in `/hooks`.
4. With the hooks active, state the **transitions** to the agent (request → pending, notify host;
   accept/reject → decided, notify requester) and have it restate them before coding.
5. Implement join/leave and host accept/reject as server actions that validate, **authorize** (only
   the host decides), persist, notify, and revalidate — plus the participant UI, the host's
   requests view, and a grouped "my participations" page. Notice when the type-check hook pushes
   back on the agent mid-task.
6. Verify with two seeded accounts: one requests, the other accepts; confirm the notification
   reaches the right person.

## Success Criteria

**Feature**

- [ ] A post-edit hook formats and type-checks automatically, and you saw it fire during the build
- [ ] A guard hook blocks access to at least one sensitive path with `exit 2`
- [ ] Both hooks appear in `/hooks` from your project settings
- [ ] You can explain why these belong in hooks rather than in `CLAUDE.md`

**App still works**

- [ ] Join/leave and host accept/reject work and enforce authorization
- [ ] Each transition notifies the correct person; invalid transitions and duplicate requests are
      rejected
- [ ] "My participations" groups going / awaiting / declined; `npm run build` passes

## References

- Claude Code — Hooks reference: https://code.claude.com/docs/en/hooks
- Claude Code — Hooks guide: https://code.claude.com/docs/en/hooks-guide
- Claude Code — Settings: https://code.claude.com/docs/en/settings
- Next.js — Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
