## Overview

Point Claude Code at the API key provided for this workshop instead of your personal Claude
account, using the built-in `/config` command. This keeps everyone's usage and cost on the
workshop's shared billing and removes one more blocker before the first real exercise.

## Prerequisites

- Claude Code installed and verified (previous task)
- The API key shared by your trainer for this workshop

## Steps

1. Get the workshop API key from your trainer (usually shared at the start of the session, e.g.
   via chat or a slide).
2. Start a session in any directory:

   ```bash
   claude
   ```

3. Open the configuration menu:

   ```
   /config
   ```

4. Find the API key / authentication setting and **paste in the workshop key**, then confirm/save.
5. Restart `claude` (or open a fresh session) and confirm it does **not** prompt you to sign in
   with a personal Claude.ai/Console account — it should use the configured key automatically.
6. Ask a trivial question (for example, "what is 2 + 2") to confirm requests go through
   successfully using the workshop key.

## Success Criteria

- [ ] `/config` shows the workshop API key as the active authentication method
- [ ] Starting `claude` does not prompt for personal sign-in
- [ ] A trivial question was answered successfully using the workshop key
- [ ] The setting persists in a freshly opened session without repeating `/config`

## References

- Claude Code — Slash commands: https://code.claude.com/docs/en/slash-commands
- Claude Code — Settings: https://code.claude.com/docs/en/settings
- Claude Code — Overview: https://code.claude.com/docs/en/overview
