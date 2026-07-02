## Overview

Get comfortable driving Claude Code as an agentic coding tool before you write a single line of
the application you will build across this workshop. You will internalize the mental model behind
the tool: an agent works in a **Reason → Act → Observe** loop, proposes tool calls that change your
environment, and is only as good as the context you give it.

You do **not** produce application code in this task — you produce fluency with the tool.

## Prerequisites

- Node.js 18+ installed (`node -v`)
- A terminal and a code editor (VS Code recommended)
- A Claude account (Claude.ai or Claude Console)

## Steps

1. Install Claude Code and confirm it runs:

   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   claude --version
   ```

   Sign in if prompted on first run.

2. Create an **empty working directory** that you will grow into your project over the coming
   tasks, initialize version control in it, and start Claude Code there:

   ```bash
   mkdir my-project && cd my-project
   git init
   claude
   ```

3. Ask the agent to **explain how it works** — what tools it has and how it decides what to do.
   Notice that it answers from context, not from your (still empty) project.

4. Explore the interactive interface: discover the available **slash commands**, look at `/help`,
   and try `/context` to see how much of the context window a conversation uses.

5. Enter a **read-only planning mode** (toggle with `Shift+Tab`) and ask the agent to outline the
   steps it _would_ take to start a new web project — but do not let it make any changes. Read the
   plan critically.

6. Experiment with **permissions**: observe when the agent asks before acting, and decide how much
   autonomy you are comfortable granting in an unfamiliar context.

7. Reflect: where in the loop (reason / act / observe) did the agent pause for you, and why?

## Success Criteria

- [ ] Claude Code is installed and you can start a session in a directory you own
- [ ] You got the agent to explain itself and could follow which tools it used
- [ ] You obtained a plan in planning mode **without** any file being changed
- [ ] You checked `/context` and know roughly how much of the window a short conversation uses
- [ ] You can explain, in your own words, when you would approve vs. reject a proposed action

## References

- Claude Code — Overview: https://code.claude.com/docs/en/overview
- Claude Code — Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code — Interactive mode: https://code.claude.com/docs/en/interactive-mode
- Claude Code — Slash commands: https://code.claude.com/docs/en/slash-commands
- Claude Code — CLI reference: https://code.claude.com/docs/en/cli-reference
