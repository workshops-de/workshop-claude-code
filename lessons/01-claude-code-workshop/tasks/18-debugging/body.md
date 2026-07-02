## Overview

Use Claude Code as a debugging partner: feed it the right evidence (errors, logs, reproduction
steps) and let it trace a problem to its root cause through the reason–act–observe loop. Good
debugging with an agent is mostly about supplying good context.

## Prerequisites

- Recommended: `agent-browser` for reproducing and inspecting UI bugs in a real browser.

## Background

Agents debug well when they can _observe_ — read the failing message, run a reproduction, inspect
logs and diagnostics, and check the diff. "Rubber-ducking" also works: describing what you did,
expected, and saw often surfaces the issue.

## Steps

1. Find or deliberately introduce a real bug in your application (a validation gap, a wrong query,
   a broken transition).
2. Give the agent the **evidence**: the error message or wrong behaviour, how to reproduce it, and
   any relevant logs.
3. Ask it to investigate by forming hypotheses and **testing** them, narrowing to the root cause —
   not patching the first symptom.
4. Apply the fix and **verify** the original problem is resolved and nothing nearby broke.
5. Try a "rubber-duck" prompt: describe what you did, expected, and observed.
6. Reflect on which evidence made the biggest difference to the diagnosis.

## Success Criteria

- [ ] A real bug was diagnosed using evidence, not guesswork
- [ ] The root cause (not just a symptom) was identified and fixed
- [ ] A check (test or manual repro) confirms the fix and guards against regression

## References

- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — Best practices: https://code.claude.com/docs/en/best-practices
- Next.js — Error handling: https://nextjs.org/docs/app/building-your-application/routing/error-handling
