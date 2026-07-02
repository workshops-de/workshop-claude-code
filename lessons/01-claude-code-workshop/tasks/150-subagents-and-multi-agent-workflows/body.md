## Overview

Use **subagents** to delegate noisy or exploratory work to a separate context, keeping your main
session focused. You will learn how delegation protects the primary context — the subagent does
the digging and returns only a clean summary — and when that trade-off is worth it.

## Background

A subagent runs with its own context window, its own instructions, and optionally a restricted set
of tools and permissions. The orchestrating agent hands it a task; the subagent does the work
elsewhere and reports back. The subagent's intermediate reading and reasoning do **not** pollute
your main context.

## Steps

1. Pick a research question about your own codebase — for example, "where are participation state
   transitions handled, and what's the flow?"
2. Delegate it to a **read-only explorer subagent** and ask for a concise summary.
3. Check your **main** context usage and note that it stayed lean despite the exploration.
4. For contrast, ask the same question directly in the main session and watch the context grow —
   discuss the trade-off.
5. Optionally configure a second subagent for a different job (for example, running the test suite
   and reporting only pass/fail and failing test names).
6. Reflect: which kinds of tasks are best delegated, and which are simpler to do inline?

## Success Criteria

- [ ] A read-only explorer subagent exists and was invoked for a real question
- [ ] The main session's context stayed noticeably leaner than the direct-ask comparison
- [ ] You can explain the delegation trade-off in your own words

## References

- Claude Code — Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — Best practices: https://code.claude.com/docs/en/best-practices
