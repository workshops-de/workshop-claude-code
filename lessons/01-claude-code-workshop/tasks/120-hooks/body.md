## Overview

Make quality and safety **deterministic** with hooks: commands that Claude Code runs on
lifecycle events, every time, regardless of what the model decides. You set up a format/type-check
hook and a secrets guard first, then build the most intricate feature of the app with both active.

## The Feature

Hooks are configured in settings (`.claude/settings.json` for the project, commit it) and fire on
events such as `PreToolUse` (before a tool runs, can block), `PostToolUse` (after it ran),
`Stop`, or `SessionStart`.

- **Matchers** pick the tools a hook applies to, e.g. `"Edit|Write"`.
- **Input** arrives as JSON on stdin; the edited file is at `.tool_input.file_path`:

  ```json
  {
    "hooks": {
      "PostToolUse": [
        {
          "matcher": "Edit|Write",
          "hooks": [
            {
              "type": "command",
              "command": "jq -r '.tool_input.file_path' | xargs npx --no-install prettier --write --ignore-unknown"
            }
          ]
        }
      ]
    }
  }
  ```

- **Blocking**: in a `PreToolUse` hook, `exit 2` blocks the tool call and your stderr is shown to
  Claude as the reason. Careful: `exit 1` does **not** block, it's treated as a non-blocking error.
- **Feedback:** a `PostToolUse` hook can't undo the edit, but `exit 2` shows its stderr to Claude,
  so it reacts to the errors. Its plain text output on exit `0` does not reach Claude (on
  `SessionStart`, `UserPromptSubmit`, `UserPromptExpansion` and `PostModelSwitch`, stdout does).
- **Scripts**: keep longer logic in `.claude/hooks/*.sh` (executable) and reference it as
  `"${CLAUDE_PROJECT_DIR}/.claude/hooks/guard.sh"`.
- **Inspect**: `/hooks` shows every configured hook, its matcher, and which settings file it came
  from.

Memory advises; hooks enforce.

## Apply it to BookMonkey

> **Repo / ports:** your `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!`

The practice ground is BookMonkey's **reading list**: a signed-in user puts a book on their list
(_want to read_), starts it (_reading_), and finishes it (_finished_), and may start a finished
book again or remove it at any time. Nothing else is legal: no jumping from _want to read_
straight to _finished_. The `bookmonkey-api` has no endpoint for this, so the list lives in the
browser for now (per user, in `localStorage`); your own backend takes it over later. A small state
machine touching a pure domain module, a client store, the detail page, a list page, and the
header at once: exactly where a hook that formats and type-checks every edit keeps the agent
honest.

## Prerequisites

- `jq` installed (used to read hook input).
- On Windows: run hook scripts under Git Bash and install `jq` with `winget install jqlang.jq`.
- Prettier in the project: `npm i -D prettier` (`create-next-app` doesn't add it). Add a small
  `.prettierrc` that matches your current style, or the first hook run reformats code you didn't
  touch.
- Optional skill (nice to have, not required): `vercel-labs/agent-skills@vercel-react-best-practices`

## Steps

1. Add a **`PostToolUse`** hook for `Edit|Write` that formats the changed file and runs a fast
   type-check, as a script in `.claude/hooks/`. `tsc --noEmit` checks the whole project, not one
   file (fine at this size). When it fails, print the errors to stderr and `exit 2`, otherwise
   Claude never sees them. Make an edit with a deliberate type error and confirm Claude reacts.
2. Add a **`PreToolUse`** guard script that blocks reads and writes to `.env*` files and key
   material with `exit 2` (let `.env.example` through). Check the file path
   (`.tool_input.file_path`), not just any text: a guard that also greps `Bash` command text blocks
   harmless commands that merely mention `.env.local`, such as a commit message. Ask the agent to
   read your `.env.local` and confirm it's blocked with your message. The guard only sees file
   tools: `cat .env.local` through Bash still ran in our test. A deny rule `Read(./.env*)` also
   covers commands like `cat`.
3. Check both in `/hooks`.
4. With the hooks active, state the **transitions** to the agent (add → _want to read_; start →
   _reading_; finish → _finished_; start again → _reading_; remove from any state) and have it
   restate them (and the illegal ones) before coding.
5. Have it implement the state machine as a **pure function** (`transition(state, action)`) that
   rejects illegal moves, a per-user store on top of it, reading-list buttons on the detail page,
   a reading-list page in the authenticated area grouped by state, and a counter in the header.
   Notice when the type-check hook pushes back on the agent mid-task.
6. Verify with two accounts in the same browser (register a second one): each sees only their own
   list, and illegal transitions are impossible from the UI.

## Success Criteria

**Feature**

- [ ] A post-edit hook formats and type-checks automatically, and you saw it fire during the build
- [ ] A guard hook blocks access to at least one sensitive path with `exit 2`
- [ ] Both hooks appear in `/hooks` from your project settings
- [ ] You can explain why these belong in hooks rather than in `CLAUDE.md`

**App still works**

- [ ] Add, start, finish, start again, and remove work; the illegal jump to _finished_ is rejected
      by the domain function, not just hidden in the UI
- [ ] Two accounts on the same browser see separate reading lists; lists survive a reload
- [ ] The reading-list page groups books by state and is only reachable when signed in
- [ ] `npm run build` passes

## References

- Claude Code: Hooks reference: https://code.claude.com/docs/en/hooks
- Claude Code: Hooks guide: https://code.claude.com/docs/en/hooks-guide
- Claude Code: Settings: https://code.claude.com/docs/en/settings
- MDN: Window.localStorage: https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
