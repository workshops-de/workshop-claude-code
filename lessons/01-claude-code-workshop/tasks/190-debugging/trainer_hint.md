## Learning goals

- **Feature:** evidence-driven debugging with Claude: reproductions, competing hypotheses, git
  history as evidence (optional), regression tests; optional MCP access to data.
- **Concepts:** root cause vs. symptom; "since a while" bugs that need git archaeology (optional).
- **Takeaways:** debugging quality tracks evidence quality; fix the cause once, where all paths
  meet, and prove it with a test.

## Facilitation notes

- Read the ticket out loud and give nothing else. The ticket is deliberately written in user
  language. Resist explaining it.
- The bug is real and reproducible on a fresh `npm run db:reset`. If someone cannot reproduce the
  first sentence, let them reset the database first.
- Watch for the classic failure: Claude patches the page or the one endpoint, the ticket's first
  sentence goes away, and the participant stops. Ask "what about the second sentence?".
- Good results, in general terms: a reproduction as a failing request or test; a root cause that
  explains both sentences; optionally the commit that introduced it with the author's intent; a list of all
  affected paths; a fix in one shared place plus a regression test.
- The root cause, the commit, the affected paths, and a reference fix are in the private trainer
  repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`). Never put them on a shared screen before the
  debrief, and never into this public course repo.
- Participants who built the `legacy-ops` MCP server in the MCP bonus may use it. It is optional.

## Time estimate

~30 minutes: 5 reproduce, 10 check hypotheses, 15 root cause, fix and test. Git history only as an
option in "More".
Debrief 10 more minutes.
