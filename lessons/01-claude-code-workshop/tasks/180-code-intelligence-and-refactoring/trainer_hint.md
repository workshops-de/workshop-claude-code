## Learning goals

- **Feature:** plan mode for large changes, characterisation tests as a safety net, small
  verified steps with commits, `/rewind`, optional code intelligence.
- **Concepts:** refactoring vs. rewriting; behaviour preservation; inventory before change;
  separating "refactor" from "fix".
- **Takeaways:** delegate judgement-heavy refactors; pin behaviour before you move code; keep
  mechanical edits in the IDE; you own the diff.

## Facilitation notes

- This opens "Quality & Automation". Set the frame: the rest of the block is about making quality
  systematic.
- Let participants choose freely. Option (a) is about finding all places that do the same thing
  differently; option (b) is about moving code without changing what it does. Both take longer
  than people expect; time-box at 45 minutes of work and accept a partial result if the tests are
  green.
- Do not hand out the list of affected places. The inventory is the learning. The complete list
  for both options and the notes on what the tests should reveal are in the private trainer repo
  (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- Expect the agent to "improve" things on the way. That is the most important discussion: a
  refactor that also changes behaviour is no longer a refactor. Ask participants to list such
  findings instead and keep them for the debugging and code review tasks.
- Some participants will find surprising behaviour while writing characterisation tests. Good.
  Confirm only that surprises are worth writing down, not what they mean.
- Participants who work on their own codebase need a test command that runs in under a minute;
  check that before they start.
- If your organization has an LSP plugin available, a live before/after (grep-based vs.
  code-intelligence-based inventory) is a strong demo.

## Time estimate

~60 minutes: 10 inventory, 15 characterisation tests, 25 refactor in steps, 10 verify and debrief.
