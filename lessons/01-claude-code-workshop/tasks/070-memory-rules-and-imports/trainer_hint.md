## Learning goals

- **Feature:** `.claude/rules/`, path-scoped rules via `paths` frontmatter, `@`-imports, `/memory`
  and `/context` to inspect what loaded.
- **Concepts:** memory is layered; scoping keeps context lean; imports organise but don't save
  context.
- **Practice ground:** the BookMonkey domain and API contract — glossary, entity model, a compact
  contract summary, and API-client conventions.
- **Takeaways:** align on meaning before code; put it where the agent re-reads it every session.

## Facilitation notes

- This builds directly on the `CLAUDE.md` task — frame it as "what to do when one file isn't
  enough anymore".
- The `/context` check in a fresh session is the proof moment; make sure people see a scoped rule
  appear only after a matching file was read.
- Someone will import the raw `openapi.json` — let them, then compare `/context` token usage with
  a neighbour who imported the summary. Strong teaching moment.
- `id` vs. `isbn` is the trap that bites later (wrong detail URLs, broken edit forms). If it isn't
  in the glossary, ask the group why it should be.
- `docs/openapi.json` comes back in task 200 as the contract the own backend must satisfy — mention
  that it should be committed.

## Time estimate

~30 minutes.
