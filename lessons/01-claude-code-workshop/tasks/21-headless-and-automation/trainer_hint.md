## Learning goals

- **Skills:** running `claude -p`; piping data; producing/parsing JSON output; pre-approving
  tools; wrapping Claude in a project script.
- **Concepts:** non-interactive execution; reproducible runs with `--bare`; structured outputs;
  scripting and CI integration.
- **Takeaways:** Claude Code composes like any CLI; lock down tools and use bare mode for
  predictable automation.

## Facilitation notes

- Directly builds on the previous task's quality-gate command — reuse it as the thing being
  wrapped into a script here.
- If API costs are a concern for the room, point out `total_cost_usd` in the JSON output as a way
  to track spend per invocation.

## Time estimate

~30 minutes.
