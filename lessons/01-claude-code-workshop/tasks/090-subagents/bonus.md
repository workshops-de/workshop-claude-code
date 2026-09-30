## Going further — multi-agent at scale

A single subagent is the start. Claude Code can coordinate **many** agents:

- **Parallel subagents** — run a reviewer and a "test runner" subagent (reports only pass/fail and
  failing test names) at the same time.
- **Agent teams** — multiple Claude Code sessions working together with shared tasks and
  inter-agent messaging.
- **Worktrees** — isolate parallel sessions and subagents so their changes don't collide.
- **Run a whole session as an agent** — `claude --agent security-reviewer` gives the main thread
  the reviewer's tool restrictions and model.

Try adding a second, test-running subagent and delegating to both in one prompt.
