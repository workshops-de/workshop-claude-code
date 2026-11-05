## Learning goals

- **Feature:** plan mode as a steering loop — entering it, iterating on a plan, editing it with
  `Ctrl+G`, choosing the execution mode on approval.
- **Concepts:** the cheapest correction happens before the first edit; plan quality sets the
  autonomy you can safely grant.
- **Practice ground:** BookMonkey App Router scaffold with route groups for public vs.
  authenticated areas, wired to the running `bookmonkey-api`.
- **Takeaways:** argue with the plan, then run the app, then commit what you own.

## Facilitation notes

- Participants saw plan mode in the fundamentals task as a read-only toggle — frame this task as
  the "for real" version, where pushing back actually changes the outcome.
- Check that people really challenge the plan; a common failure is accepting the first draft.
  Ask one participant to show how their plan changed.
- `Ctrl+G` opens the editor configured in `$EDITOR`/`$VISUAL`; have a quick fix ready if nothing
  opens.
- `bookmonkey-api` needs Node.js ≥ 26 — check this before the session. Port conflicts on 4730 are
  fixed with `npx bookmonkey-api --port <n>` plus a matching `NEXT_PUBLIC_API_URL`.
- Expect agents to propose shadcn/ui or a data-fetching library unprompted — a good thing to push
  back on here; shadcn arrives deliberately in the skills task.
- Known pitfall: dangling nav links to pages not built yet will 404 until their tasks — expected.

## Time estimate

~45 minutes including install/setup time.
