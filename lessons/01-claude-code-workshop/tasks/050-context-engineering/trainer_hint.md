## Learning goals

- **Feature:** `/context`, `/compact` with focus instructions, `/clear`, `/btw`, delegating reads
  to a subagent.
- **Concepts:** the finite context window; context failure modes; "lost in the middle"; why legacy
  code fills the window fast.
- **Takeaways:** curate what goes in; prune noise; one task per fresh session when you can.

## Facilitation notes

- Keep it hands-on but time-boxed. What fills the window is many files read with the Read tool
  (the big route file first) and long logs pasted into the chat.
- `git log -p` or a lockfile through Bash barely count: in a test Claude got only a short preview
  of each, plus the file path. That is a good discussion point: the tool already protects the window.
- The most memorable moment is the before/after comparison around `/compact`. Make sure every
  participant actually asks the same question before and after.
- The subagent step previews the subagents task. Keep it short; the point is how little lands in
  the main context.
- Connect back to "context is king" and forward to skills, hooks, subagents, and MCP: all of them
  are context-engineering levers.

## Time estimate

~30 minutes.
