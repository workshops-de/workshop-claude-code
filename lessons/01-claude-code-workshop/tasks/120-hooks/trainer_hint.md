## Learning goals

- **Feature:** hook events and matchers, stdin JSON input, blocking with `exit 2`, project hooks in
  `.claude/settings.json`, `/hooks`.
- **Concepts:** deterministic guardrails vs. advisory memory; defense in depth.
- **Practice ground:** the BookMonkey reading-list state machine as a pure domain function with a
  per-user client store.
- **Takeaways:** if it must always happen, make it a hook — not an instruction.

## Facilitation notes

- Reconnect to the `CLAUDE.md` task: memory advises, hooks enforce — draw the contrast explicitly.
- The `exit 1` vs. `exit 2` trap catches most people writing their first guard; let them hit it,
  then point at the hint.
- Watch for slow hooks (full test suite per edit) — steer back to fast, targeted commands.
- The payoff moment is the type-check hook pushing back mid-feature; ask someone to show it.
- `localStorage` is a deliberate stopgap because the API has no reading-list endpoint. If someone
  asks "isn't that insecure / not shared across devices?" — yes, and that is what the own backend
  in tasks 200/230 can fix. Keep the pure `transition` function: it moves to the backend unchanged.
- Hydration mismatches are common when the header counter reads `localStorage` during render —
  a good debugging example if it shows up.
- The type-check hook runs after every single edit. During a multi-edit change it can report
  errors such as `Cannot find name ...` that the next edit (often the import) fixes. Expected;
  the agent usually carries on.
- `Edit|Write` doesn't catch files the agent writes through `Bash` (for example a heredoc). Point
  it out when someone wonders why the hook stayed quiet.
- "Per user" needs a user key on the client, but the session cookie is http-only. Expect the
  agent to pass the signed-in email or id from the server into the client store.
- Bonus `SessionStart` hook (a participant's idea): if the session hangs at start, the hook keeps the server's stdout open. The fix is `> .claude/logs/x.log 2>&1 &` (or `nohup`), so the hook returns at once. Good moment for "side effects in hooks": check and report is the safe default, starting processes is a choice.
- Two-account testing is the step people skip — check for it during the room walk.

## Time estimate

~50 minutes.
