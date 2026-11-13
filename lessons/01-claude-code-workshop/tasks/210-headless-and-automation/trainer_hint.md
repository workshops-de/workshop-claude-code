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
- Step 6 (pre-push hook) replaces the former open "build your own script". It closes the arc: pipe,
  schema, exit code, hook. Tested 2026-11-13 (Claude Code 2.1.323, Sonnet) on a throwaway copy with a
  local bare remote: the PR branch push stopped, an unchanged branch went through, `--no-verify`
  skipped the hook. Claude chose `.githooks` plus `core.hooksPath`.
- Say clearly: Git hook is not Claude Code hook (task 120). Why `pre-push` and not `pre-commit`: the
  check takes a while. Why `--no-verify` exists: the AI verdict varies between runs. Bridge to 215:
  locally as hook, for the team as GitHub Action.
- Pitfall: in our run Claude made `review.sh` exit 2 on errors (for example no network) and short-circuit on an empty diff (exit 0). The step 4 prompt does not ask for either, so other runs may differ: an error that exits 0 lets the push through unchecked, an error that exits 2 blocks it. Check the script with the group if the clean push behaves oddly.
- Pitfall: participants must not push to their real remote for the test; the setup block creates a test remote and the prompt names it. The clean-branch push is optional (time).
- Participants who finish early can still wrap their own daily check in a script.
- If API costs are a concern for the room, point out `total_cost_usd` in the JSON output as a way
  to track spend per invocation.

## Time estimate

~30 minutes.
