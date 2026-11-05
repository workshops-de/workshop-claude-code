## Overview

Put together everything you've learned about permissions, safety, and context to run **longer,
less-supervised** work. Combine auto mode (or a pre-approved tool set) with a **goal** Claude keeps
working toward, in an **isolated worktree**, while keeping a human in the loop where it matters.

## The Feature

"Autonomous" does not mean "unsupervised forever." It means setting the agent up to make routine
decisions on its own within boundaries you define, then reviewing the result.

- **`/goal <condition>`** — after every turn, a separate evaluator model checks the condition; if
  it doesn't hold yet, Claude starts the next turn by itself. Write it as something Claude's own
  output can prove, with one measurable end state, a stated check, constraints, and a bound:

  ```text
  /goal npm run contract against API_URL=http://localhost:3001 exits 0,
  no file under contract-tests/ is modified, or stop after 30 turns
  ```

  `/goal` shows status, `/goal clear` stops it.
- **Auto mode** (or a curated `--allowedTools` set / `acceptEdits`) removes per-tool prompts;
  `/goal` removes per-turn prompts. They're complementary — a goal doesn't change your permission
  mode.
- **Isolation** — `claude --worktree <name>` starts the session in its own git worktree under
  `.claude/worktrees/<name>/` on a new branch, so your main checkout stays untouched until you
  review and merge.

## Apply it to BookMonkey

In the TDD task your NestJS backend learned two endpoints. The practice ground now is **finishing
it against the contract** without hand-holding: the full `GET /books` query surface (`q`,
`_page`, `_limit`, `_sort`, `_order`, the `X-Total-Count` header), `PUT` / `PATCH` / `DELETE`,
`/register` and `/login`, `/dev/reset`, and the 50 seed books. The contract suite is the goal's
measurable end state. When it's green, you point the frontend at your own backend — the moment of
truth for the whole workshop app.

## Prerequisites

- The contract suite and the NestJS backend from the TDD task are committed.
- The reference seed data: `npm i -D bookmonkey-api` and read
  `node_modules/bookmonkey-api/dist/db.json`.

## Steps

1. First, extend the contract suite (in your main checkout, reviewed by you) to cover the remaining
   endpoints. Confirm it is green against the reference API on port 4730 and commit it.
2. Start an isolated session: `claude --worktree backend-contract`, and switch to auto mode — or,
   if auto mode isn't available, start it with a curated `--allowedTools` set.
3. Set the **goal** with a measurable condition, a "don't touch the tests" constraint, and a turn
   bound. Watch the evaluator's verdicts (`Ctrl+O` shows the reasoning).
4. When the goal clears, review the diff in the worktree like a pull request — this is your
   deliberate **human-in-the-loop** checkpoint. Merge only what you'd sign.
5. Point the frontend at your backend (`NEXT_PUBLIC_API_URL=http://localhost:3001`), restart it, and
   re-run the browser journey from the MCP task.
6. Reflect: which of your real tasks are good candidates for a goal-driven run, and which are not?

## Success Criteria

**Feature**

- [ ] A `/goal` with a measurable condition, a constraint, and a bound drove the run to completion
- [ ] The run happened in an isolated worktree with meaningfully fewer prompts than usual
- [ ] You reviewed the diff before merging and can name the human-in-the-loop checkpoint
- [ ] You can explain the difference between auto mode and `/goal`

**App still works**

- [ ] The full contract suite is green against both the reference API and your backend
- [ ] The frontend runs against your own backend; catalogue, series navigation, sign-in, and
      create/edit work unchanged
- [ ] Your backend serves the 50 seed books, and `/dev/reset` restores them

## References

- Claude Code — Keep Claude working toward a goal: https://code.claude.com/docs/en/goal
- Claude Code — Permission modes (auto mode): https://code.claude.com/docs/en/permission-modes
- Claude Code — Run parallel sessions with worktrees: https://code.claude.com/docs/en/worktrees
- BookMonkey API — Querying guide: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md
