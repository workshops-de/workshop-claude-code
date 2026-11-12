## Going further: the full lifecycle

- **More events**: `Stop`, `SessionStart`, `UserPromptSubmit`, `PreCompact`, and more, each with
  its own JSON input and exit-code behaviour.
- **`SessionStart`** can inject context at the start of every session.
- **HTTP, prompt, and MCP-tool hooks** extend automation beyond local shell scripts.
- **Hooks in skills and subagents**: skill frontmatter hooks stay for the rest of the session once
  the skill is invoked, subagent frontmatter hooks end with the agent.

Try adding a `SessionStart` hook that reminds the agent of your project's quality gates, or a
`Stop` hook that runs lint before the agent declares it's done.

### Let a `SessionStart` hook start the servers

An idea from a participant: instead of starting both servers by hand before step 7, let a hook do it.

```text
Set up a SessionStart hook for startup only: it checks whether port 4730 (npx bookmonkey-api) and port 3000 (npm run dev) answer. Each missing server starts in the background with its log in .claude/logs/, which Git ignores. The hook does not wait for the servers and tells you in one line which servers run.
```

Start a new session and ask `Which servers are running?`. Claude knows it without a tool call, because the hook output is added to its context.

When it is a trap: the servers outlive the session (stop them with `lsof -ti :3000 | xargs kill`), and in a team repo a hook that starts processes surprises people. There, a hook that only checks and reports is often the better choice.
