## Going further — the full lifecycle

- **More events** — `Stop`, `SessionStart`, `UserPromptSubmit`, `PreCompact`, and more, each with
  its own JSON input and exit-code behaviour.
- **`SessionStart`** can inject context at the start of every session.
- **HTTP, prompt, and MCP-tool hooks** extend automation beyond local shell scripts.
- **Hooks in skills and subagents** — frontmatter hooks run only while that skill or agent is
  active.

Try adding a `SessionStart` hook that reminds the agent of your project's quality gates, or a
`Stop` hook that runs lint before the agent declares it's done.
