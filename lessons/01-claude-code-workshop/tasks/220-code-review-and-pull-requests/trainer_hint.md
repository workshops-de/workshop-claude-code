## Learning goals

- **Feature:** `/code-review` with a branch range and effort level, `/security-review`, a custom
  security subagent without edit tools, triage of agent findings.
- **Concepts:** review as a quality floor; correctness vs. security review; false positives;
  reproducing findings; ownership.
- **Takeaways:** any review beats none; two independent reviewers find more than one; you own
  what you approve.

## Facilitation notes

- Participants review, they do not author. Make that explicit: the branch was written by someone
  else, in a hurry, and looks like a normal feature PR.
- Do not tell anyone what to look for or how many issues there are. The list of what a complete
  review should find, with severities and reproductions, is in the private trainer repo
  (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`). Use it only to check results in the debrief, and
  never copy it into this public repo.
- Good debrief: collect findings from the room on the board and mark which reviewer found each
  (`/code-review`, security subagent, human). Discuss one false positive in detail. Then compare
  with the trainer list and talk about what nobody found and why.
- `/code-review` runs in the background and takes a few minutes. Participants should read the
  diff themselves meanwhile, so they have their own list before they see the agent's.
- `/security-review` compares against `origin`'s default branch; it needs the clone's `origin`
  remote, which `git clone` sets. If it fails with an `ambiguous argument` error, run
  `git fetch origin` and `git remote set-head origin --auto`.
- Before the switch, participants still have changes from the debugging task. Make sure they
  commit or stash them first. The review branch is created from `origin/feature/admin-export-v2`
  and `main` is merged in, so their `CLAUDE.md` is loaded; `main...review/admin-export-v2` still
  shows only the PR's changes. `/security-review` compares with `origin`'s default branch, so it
  also sees the participant's own commits on `main`; point that out if they wonder.
- The optional security pass over `main` (step 9) is for fast groups. Do not confirm or rate
  findings from it in the room; the trainer repo has what to compare with.
- A new subagent file may need a restart of Claude Code to load, as in the subagents task.
- This closes "Quality & Automation" together with the GitHub Actions task. A natural point for
  a wider retrospective before the autonomous workflows task finishes the own backend.

## Time estimate

~45 minutes: 5 understand, 10 reviews (in parallel with own reading), 15 triage, 10 write review
and fix one, 5 reflect.
