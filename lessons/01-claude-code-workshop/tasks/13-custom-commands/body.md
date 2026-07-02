## Overview

Create **custom slash commands** — reusable prompts you invoke with `/` and optional arguments — to
standardize the small, frequent actions you and your team repeat (committing, reviewing,
generating boilerplate). You will learn how commands differ from skills and when each fits.

## Background

Custom commands are predefined prompts stored as Markdown files; invoking `/your-command` runs the
prompt, optionally with arguments you pass. Where a skill is something the agent decides to use, a
command is something **you** trigger deliberately.

## Steps

1. Choose a small, frequent action to codify — for example, "commit the current changes with a
   well-formed message following our convention," or "review the current changes for bugs and
   risks."
2. Author it as a **custom command**, written as a clear prompt the agent will run.
3. Add an **argument** to one command and use it to change the command's behaviour (for example, a
   scope or focus area).
4. Invoke your command(s) on real changes in your project and refine the wording until the output
   is consistently what you want.
5. Reflect: which of your repeated requests are better as commands, and which as skills?

## Success Criteria

- [ ] At least one custom command exists and can be invoked by name
- [ ] One command accepts an argument that changes its behaviour
- [ ] You can explain, in your own words, command vs. skill

## References

- Claude Code — Slash commands: https://code.claude.com/docs/en/slash-commands
- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — Settings: https://code.claude.com/docs/en/settings
