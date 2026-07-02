## Learning goals

- **Skills:** reviewing security-sensitive agent output; reading diffs critically; challenging the
  agent's decisions.
- **Concepts:** password hashing; signed session cookies; route-level guards; secrets from the
  environment.
- **Takeaways:** trust but verify; the commit has your name on it.

## Facilitation notes

- This is a good moment to slow the room down — resist the urge to let people rubber-stamp the
  diff. Ask at least one person to read their diff aloud.
- If someone "vibe-codes" this task (accepts everything without reading), use it as a teaching
  moment about "you push it, you own it" rather than a failure.
- Common issue on recent Next.js: forgetting to `await cookies()`/`headers()`.

## Time estimate

~45 minutes; this closes out the "Modeling & Building the Skeleton" morning.
