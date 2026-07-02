## Overview

Use the agent to build a real safety net across the test pyramid, and practise **test-driven
development** with an agent — letting tests give it a built-in "done" signal.

## Prerequisites

- Recommended: `agent-browser` for end-to-end browser flows.

## Background

Agents are strong test writers and can run tests themselves, which makes testing the most reliable
feedback loop available to them. Agents won't reliably do TDD unless you ask, so make it explicit.

## Steps

1. Pick a domain rule (for example, a date must be in the future). Instruct the agent to use
   **TDD**: write failing tests first, review them, then implement the minimal code to pass.
2. Before the implementation, review the tests and ask the agent to enumerate **edge cases**; add
   any it missed.
3. Add an **integration test** that exercises a write against an ephemeral database.
4. Add one **end-to-end test** for a critical path.
5. Wire the **quality gates** (type-check, lint, build, tests) into a single command the agent can
   run, and record it in project memory.
6. Reflect on how having a runnable test loop changed the agent's behaviour.

## Success Criteria

- [ ] A domain rule was implemented test-first, with tests reviewed before code
- [ ] An integration test exercises a real write against an ephemeral database
- [ ] One end-to-end test covers a critical path
- [ ] A single command runs all quality gates

## References

- Test pyramid (Martin Fowler): https://martinfowler.com/articles/practical-test-pyramid.html
- Vitest — Getting started: https://vitest.dev/guide/
- Playwright — Writing tests: https://playwright.dev/docs/writing-tests
