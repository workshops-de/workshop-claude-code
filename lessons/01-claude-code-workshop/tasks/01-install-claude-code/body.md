## Overview

Before touching any code, get Claude Code installed as a terminal tool on your own machine and
confirm it actually works end to end: it runs, you're signed in, and it responds. This is a pure
setup task — no exploration, no code, just a working install you can rely on for the rest of the
workshop.

## Prerequisites

- Node.js 18+ installed (`node -v`), if you plan to install via npm
- A terminal you're comfortable in
- A Claude account (Claude.ai or Claude Console)

## Steps

1. Install Claude Code using either method:

   ```bash
   # macOS / Linux / WSL — native install script
   curl -fsSL https://claude.ai/install.sh | bash

   # or via npm (any OS with Node.js 18+)
   npm install -g @anthropic-ai/claude-code
   ```

2. Confirm it's on your `PATH` and check the version:

   ```bash
   claude --version
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
- [ ] You are signed in to a Claude account
- [ ] `claude` starts an interactive session in a project directory
- [ ] The agent answered a trivial question about the current directory
- [ ] Restarting the session does not require signing in again

## References

- Claude Code — Overview: https://code.claude.com/docs/en/overview
- Claude Code — Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code — CLI reference: https://code.claude.com/docs/en/cli-reference
