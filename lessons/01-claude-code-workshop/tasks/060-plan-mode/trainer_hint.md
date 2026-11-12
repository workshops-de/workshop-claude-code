## Learning goals

- **Feature:** plan mode as a steering loop — entering it, iterating on a plan, editing it with
  `Ctrl+G`, choosing the execution mode on approval.
- **Concepts:** the cheapest correction happens before the first edit; plan quality sets the
  autonomy you can safely grant.
- **Practice ground:** BookMonkey App Router scaffold with route groups for public vs.
  authenticated areas, wired to the running `bookmonkey-api`.
- **Takeaways:** argue with the plan, then run the app, then commit what you own.

## Facilitation notes

- Participants saw plan mode in the fundamentals task as a switch that blocks edits: frame this task as
  the "for real" version, where pushing back actually changes the outcome.
- Limits of plan mode: shell commands that are not read-only go through the classifier or ask first.
  With bypass permissions available, neither applies and edits are not blocked.
- Check that people really challenge the plan; a common failure is accepting the first draft.
  Ask one participant to show how their plan changed.
- `Ctrl+G` opens the editor from `$VISUAL`, otherwise `$EDITOR`. GUI editors need `--wait` (for
  example `code --wait`). Have a quick fix ready if nothing opens.
- `bookmonkey-api` declares Node.js >=26: everyone should run Node 26 (current LTS). Check this
  before the session. Port conflicts on 4730 are fixed with `npx bookmonkey-api --port <n>` plus a matching `NEXT_PUBLIC_API_URL`.
- Expect agents to propose shadcn/ui or a data-fetching library unprompted. That is a good thing to push
  back on here; shadcn arrives deliberately in the skills task.
- Model: clean dry run on 2026-11-12, tasks 060 to 230: Sonnet 36 min, Opus 67 min, both finished
  everything. Opus took about 13 min instead of 4 to 7 on 080, 100 and 120. So Sonnet is the
  default, Opus for plans and hard bugs. Opus also uses up subscription limits faster.
- Next.js 16 pitfalls seen in the dry run: Cache Components is on by default, so
  `export const dynamic` fails the build with `Route segment config "dynamic" is not compatible
  with nextConfig.cacheComponents` (fix: request-time fetch inside `<Suspense>`, see hint 4).
  After deleting the template `app/page.tsx`, `tsc` can report `Cannot find module
  '../../app/page.js'` from a stale `.next/types`; `rm -rf .next` fixes it.
- `create-next-app` also writes an `AGENTS.md` with Next.js notes. Claude Code reads it only while
  the repo has no `CLAUDE.md`; once there is a `CLAUDE.md`, it stops loading unless `CLAUDE.md`
  imports it with `@AGENTS.md`.
- Known pitfall: dangling nav links to pages not built yet will 404 until their tasks — expected.

## Time estimate

~45 minutes including install/setup time.
