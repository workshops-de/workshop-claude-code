## Overview

Before touching any code, get Claude Code installed as a terminal tool on your own machine and
confirm it actually works end to end: it runs, you're signed in, and it responds. This is a pure
setup task — no exploration, no code, just a working install you can rely on for the rest of the
workshop.

## Prerequisites

- Node.js 26 (current LTS) installed (`node -v`). The BookMonkey API you start in the plan mode
  task declares `node >=26`; the npm install of Claude Code itself needs Node.js 22 or later.
- A terminal you're comfortable in
- A Claude account with Claude Code access (Pro, Max, Team, Enterprise, or Console; the free
  Claude.ai plan does not include Claude Code)

## Steps

1. Install Claude Code using either method:

   ```bash
   # macOS / Linux / WSL: native install script (recommended)
   curl -fsSL https://claude.ai/install.sh | bash

   # Windows PowerShell: native install script
   irm https://claude.ai/install.ps1 | iex

   # Windows, alternative: WinGet (does not auto-update)
   winget install Anthropic.ClaudeCode

   # or via npm (any OS with Node.js 22+)
   npm install -g @anthropic-ai/claude-code
   ```

   On native Windows, install [Git for Windows](https://git-scm.com/downloads/win) too, so Claude
   Code can use its Bash tool.

2. Confirm it's on your `PATH` and check the version:

   ```bash
   claude --version
   ```

   Then run the read-only diagnostics, which check install health and your settings files
   without starting a session:

   ```bash
   claude doctor
   ```

3. Navigate into any project directory and start a session:

   ```bash
   cd your-project
   claude
   ```

4. **Sign in** when prompted (via Claude.ai or Claude Console) and wait for the prompt to become
   interactive.

5. **Test that it works**: ask a trivial question (for example, "what files are in this
   directory?") and confirm you get a sensible response.

6. Exit cleanly (`/exit` or `Ctrl+C`) and start it again to confirm the second launch is just as
   smooth — no repeated login, no errors.

## Success Criteria

- [ ] `claude --version` runs without error
- [ ] `claude doctor` reports no install errors
- [ ] You are signed in to a Claude account
- [ ] `claude` starts an interactive session in a project directory
- [ ] The agent answered a trivial question about the current directory
- [ ] Restarting the session does not require signing in again

## References

- Claude Code — Overview: https://code.claude.com/docs/en/overview
- Claude Code — Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code: Advanced setup: https://code.claude.com/docs/en/setup
- Claude Code — CLI reference: https://code.claude.com/docs/en/cli-reference
