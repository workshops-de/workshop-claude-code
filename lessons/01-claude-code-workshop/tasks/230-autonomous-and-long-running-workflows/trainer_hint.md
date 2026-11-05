## Learning goals

- **Feature:** `/goal` (condition, evaluator, status, clear), auto mode vs. curated
  `--allowedTools`, `claude --worktree` isolation.
- **Concepts:** semi-autonomous workflows; goal-directed execution; measurable end states;
  fail-safe autonomy with a human checkpoint.
- **Practice ground:** finishing the own BookMonkey NestJS backend against the contract suite, then
  switching the frontend over.
- **Takeaways:** autonomy is bounded delegation; isolate it, bound it, and review the outcome.

## Facilitation notes

- This opens the final morning — frame it as "everything you've learned, applied with less
  hand-holding", and as the payoff of the storyline started in tasks 070 and 200.
- If auto mode isn't available on participants' accounts, a curated `--allowedTools` set works
  fine as a substitute — don't let access differences block the exercise.
- Step 1 (extending the suite by hand) is deliberate: the human owns the definition of done, the
  agent owns the route there. Don't let people hand step 1 to the goal run.
- Runs can take a while — have people start the goal before a break, or trim the scope to the
  `GET /books` query surface plus `DELETE`.
- The frontend switch-over is the emotional payoff; ask one participant to demo it with the browser
  journey from the MCP task.

## Time estimate

~45 minutes (plus run time; start it before a break if possible).
