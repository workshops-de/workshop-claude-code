## Overview

Put together everything you've learned about permissions, safety, and context to run **longer,
less-supervised** work. Combine auto mode (or a pre-approved tool set) with goal-directed
execution, background tasks, and isolation, while keeping a human in the loop where it matters.

## Background

"Autonomous" does not mean "unsupervised forever." It means setting the agent up to make routine
decisions on its own within boundaries you define, then reviewing the result. A goal/completion
condition keeps Claude iterating until the condition holds instead of stopping after one turn; git
worktrees or a sandbox keep an autonomous run isolated.

## Steps

1. Pick a task with several mechanical steps (for example, "add a field across the schema,
   validation, action, and UI, then run the quality gates").
2. Run it with **reduced prompting** — auto mode if available, otherwise a curated
   `--allowedTools` set or `acceptEdits`.
3. Use a **goal/completion condition** so Claude keeps working until the gates pass.
4. Run the whole thing in an **isolated worktree** (or a container) so your main checkout is
   untouched; review the diff at the end before merging.
5. Identify one point where you deliberately kept a **human in the loop** and explain why.
6. Reflect: which of your real tasks are good candidates for semi-autonomous runs, and which are
   not?

## Success Criteria

- [ ] A multi-step task ran with meaningfully fewer prompts than usual
- [ ] A goal/completion condition kept the agent working toward a stated end state
- [ ] The run happened in an isolated worktree, reviewed before merging
- [ ] You can name a deliberate human-in-the-loop checkpoint

## References

- Claude Code — Permission modes (auto mode): https://code.claude.com/docs/en/permission-modes
- Claude Code — Keep Claude working toward a goal: https://code.claude.com/docs/en/goal
- Claude Code — Run parallel sessions with worktrees: https://code.claude.com/docs/en/worktrees
