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
- The `/context all` check in a fresh session shows the unscoped rule. A scoped rule did not appear
  there in our test (2 of 2), even after the read: the proof is the line `Loaded .claude/rules/...`
  in the conversation.
- Someone will import the raw `openapi.json` — let them, then compare `/context` token usage with
  a neighbour who imported the summary. Strong teaching moment.
- `id` vs. `isbn` is the trap that bites later (wrong detail URLs, broken edit forms). If it isn't
  in the glossary, ask the group why it should be.
- The served `openapi.json` is not the whole truth: it lists only `200`/`400` for `PUT`, `PATCH`,
  and `DELETE`, while the running API answers `404` for an unknown ISBN on `PATCH` and `DELETE`
  (`PUT` answers `400`). Good proof that a few real responses belong in step 2.
- In zsh, quote URLs with `?` (`curl "localhost:4730/books?_limit=3"`), or zsh fails with
  `no matches found`.
- `docs/openapi.json` comes back in task 200 as the contract the own backend must satisfy — mention
  that it should be committed.

## Time estimate

~30 minutes.
