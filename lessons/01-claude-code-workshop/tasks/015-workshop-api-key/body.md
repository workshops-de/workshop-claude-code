## Overview

Point Claude Code at the API key provided for this workshop instead of your personal Claude
account. This keeps everyone's usage and cost on the workshop's shared billing and removes one
more blocker before the first real exercise.

## Prerequisites

- Claude Code installed and verified (previous task)
- The API key shared by your trainer for this workshop

## Steps

1. Get the workshop API key from your trainer (usually shared at the start of the session, e.g.
   via chat or a slide).
2. Export it as an environment variable in your current shell:

   ```bash
   export ANTHROPIC_API_KEY="sk-ant-..."
   ```

3. Start (or restart) `claude` and confirm it does **not** prompt you to sign in with a personal
   Claude.ai/Console account — it should pick up the key automatically.
4. Ask a trivial question (for example, "what is 2 + 2") to confirm requests go through
   successfully using the workshop key.
5. **Persist** the variable so it survives closing your terminal, by adding the `export` line to
   your shell profile (`~/.zshrc`, `~/.bashrc`, or the equivalent for your shell/OS) and opening a
   new terminal to confirm it's still set.

## Success Criteria

- [ ] `ANTHROPIC_API_KEY` is set in your current shell (`echo $ANTHROPIC_API_KEY` shows it)
- [ ] Starting `claude` does not prompt for personal sign-in
- [ ] A trivial question was answered successfully using the workshop key
- [ ] The variable is persisted and still set in a freshly opened terminal

## References

- Claude Code — Environment variables: https://code.claude.com/docs/en/env-vars
- Claude Code — Overview: https://code.claude.com/docs/en/overview
