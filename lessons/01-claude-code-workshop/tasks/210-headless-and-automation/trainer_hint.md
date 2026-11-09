## Learning goals

- **Skills:** running `claude -p`; piping data; producing/parsing JSON output; pre-approving
  tools; wrapping Claude in a project script.
- **Concepts:** non-interactive execution; reproducible runs with `--bare`; structured outputs;
  scripting and CI integration.
- **Takeaways:** Claude Code composes like any CLI; lock down tools and use bare mode for
  predictable automation.

## Facilitation notes

- The script wraps a `git diff` review (step 4). If time allows, the previous task's quality-gate
  command can be a second thing to wrap.
- If API costs are a concern for the room, point out `total_cost_usd` in the JSON output as a way
  to track spend per invocation.

## Time estimate

~30 minutes.
