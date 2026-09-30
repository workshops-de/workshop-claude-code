## Learning goals

- **Feature:** hook events and matchers, stdin JSON input, blocking with `exit 2`, project hooks in
  `.claude/settings.json`, `/hooks`.
- **Concepts:** deterministic guardrails vs. advisory memory; defense in depth.
- **Practice ground:** the participation state machine with notifications and host-only
  authorization.
- **Takeaways:** if it must always happen, make it a hook — not an instruction.

## Facilitation notes

- Reconnect to the `CLAUDE.md` task: memory advises, hooks enforce — draw the contrast explicitly.
- The `exit 1` vs. `exit 2` trap catches most people writing their first guard; let them hit it,
  then point at the hint.
- Watch for slow hooks (full test suite per edit) — steer back to fast, targeted commands.
- The payoff moment is the type-check hook pushing back mid-feature; ask someone to show it.
- Two-account testing of the participation flow is the step people skip — check for it during the
  room walk.

## Time estimate

~50 minutes.
