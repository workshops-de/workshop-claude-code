## Overview

Move from _using_ Claude Code to _embedding_ it: the **Claude Agent SDK** gives you the same tools,
agent loop, and context management as a library you can call from Python or TypeScript.

## Background

The Agent SDK is the same engine that powers Claude Code, exposed as
`@anthropic-ai/claude-agent-sdk` (TypeScript) and `claude-agent-sdk` (Python). It loads the same
`.claude/` configuration and can return structured JSON. Use the CLI for interactive and one-off
work; reach for the SDK when building custom applications, CI/CD automation, or reusable agents.

## Steps

1. Install the SDK for your language (Python 3.10+ or TypeScript) and set an API key from the
   Console.
2. Write a minimal agent that performs a real task on a small project — for example, "find all
   TODO comments and summarize them" — using only the tools it needs (`Read`, `Glob`, `Grep`).
3. Tighten it: set a permission mode, add a `PostToolUse` hook that logs file changes, and restrict
   `allowedTools`.
4. Return **structured output** (a JSON schema / typed result) and consume it in your script.
5. Optionally add a **subagent** definition and have the main agent delegate to it.
6. Compare the experience to `claude -p`: when would you reach for the SDK instead of the CLI?

## Success Criteria

- [ ] A minimal SDK agent runs and completes a real, small task
- [ ] Tools are explicitly scoped (read-only or a tight allowlist)
- [ ] The agent returns structured output your script consumes
- [ ] You can explain when to reach for the SDK vs. the CLI

## References

- Claude Code — Agent SDK overview: https://code.claude.com/docs/en/agent-sdk/overview
- Claude Code — Agent SDK quickstart: https://code.claude.com/docs/en/agent-sdk/quickstart
- Example agents: https://github.com/anthropics/claude-agent-sdk-demos
