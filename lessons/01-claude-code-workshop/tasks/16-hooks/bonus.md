## Going further — the full lifecycle

- **Lifecycle events** — `PreToolUse`, `PostToolUse`, `Stop`, `SessionStart`, `SessionEnd`,
  `UserPromptSubmit`, and more, with JSON input/output and exit codes.
- **`SessionStart`** can inject context at the start of a session.
- **HTTP hooks, prompt hooks, and MCP-tool hooks** extend automation beyond local shell scripts.
- Hooks also work in the **Agent SDK** as callbacks for programmatic agents.

Try adding a `SessionStart` hook that reminds you of your project's quality gates.
