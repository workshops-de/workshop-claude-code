## Learning goals

- **Skills:** installing Claude Code; verifying an install end to end; basic troubleshooting.
- **Concepts:** the CLI as a terminal-native tool; sign-in/session persistence.
- **Takeaways:** a verified install now prevents lost time in every later task.

## Facilitation notes

- This is intentionally a **pure setup task**, split out from "Claude Code Fundamentals" so
  installation problems don't eat into time meant for learning the tool itself.
- Strongly recommend sending the prerequisites (Node.js version, account signup) to participants
  **before** the session so this task takes minutes, not most of the first block.
- Common blockers: outdated Node.js, corporate proxies/firewalls blocking the install script or
  sign-in, and missing `PATH` updates after install. Have a fallback (e.g. a pre-provisioned
  Codespace/devcontainer) ready for anyone who can't get unblocked quickly.
- Walk the room and confirm every participant's `claude --version` succeeds before moving on to
  the Fundamentals task — a broken install here compounds for the rest of the day.

## Time estimate

~15 minutes for most participants; corporate network restrictions can extend this significantly.
