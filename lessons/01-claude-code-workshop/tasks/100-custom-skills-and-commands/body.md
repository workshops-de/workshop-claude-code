## Overview

Write your **own skill** and your **own slash command**, so the way your team builds a feature is
encoded once and reused everywhere — without re-explaining it each session. You will build one
feature by hand, capture its shape, and let the next features be built from what you captured.

## The Feature

Both live in the same place and share one format: a `SKILL.md` in `.claude/skills/<name>/`
(legacy command files in `.claude/commands/<name>.md` still work and create the same `/name`).
What differs is **who decides when it runs**.

- **Skill (the agent decides)** — a trigger-friendly `description` lets Claude load it whenever a
  task matches:

  ```markdown
  ---
  name: add-book-feature
  description: Use when adding or changing a book screen or book API call - API client function, page, form, server action, revalidation
  ---

  1. Add or extend the typed API client function (address books by ISBN)
  2. Read in a server component; keep filters and paging in the URL
  3. Write through a server action that validates, calls the API, and maps errors
  4. Signed-in screens: add the route to the `proxy.ts` matcher
  5. Revalidate affected paths, then run type-check and npm run build
  ```

- **Command (you decide)** — add `disable-model-invocation: true` so it only runs when you type
  it, and use `$ARGUMENTS` (or `$0`, `$1`, …) for input:

  ```markdown
  ---
  name: new-book-view
  description: Scaffold a new book screen following the add-book-feature skill
  disable-model-invocation: true
  argument-hint: "[create|edit]"
  ---

  Build the "$ARGUMENTS" book screen following the add-book-feature skill.
  ```

  Save it as `.claude/skills/new-book-view/SKILL.md` and invoke it with `/new-book-view create`.
  (A legacy `.claude/commands/new-book-view.md` works too, but command files don't take the `name`
  field.) Quote `argument-hint`: unquoted square brackets are a YAML list, not a string.

- **Keep bodies short and actionable** — numbered steps beat prose, and a loaded skill stays in
  context for the rest of the session.

## Apply it to BookMonkey

The practice ground is BookMonkey's **book screens** on a server-first architecture: **reads** in
server components through your typed API client, **writes** through server actions that validate,
call the API, and revalidate. You build the read side by hand — catalogue search, sort, and
paging, plus a detail page that navigates a book series — and let the write side (create, edit) be
generated from what you captured. If your skill is good, the second and third screens are mostly
just fields.

## Prerequisites

- The `bookmonkey-api` is running; the catalogue page from the skills task exists.
- **Required:** `find-skills` (`npx skills add vercel-labs/skills@find-skills -y`) — study how
  existing skills are structured before writing your own.
- Optional skills (nice to have, not required): `anthropics/skills@frontend-design`,
  `vercel-labs/agent-skills@vercel-react-best-practices`

## Steps

1. Build the **read side** with the agent: search (`q`), sort (`_sort`/`_order`), and paging
   (`_page`/`_limit`, total from the `X-Total-Count` header) on the catalogue, all kept in the URL;
   and a detail page at `/books/<isbn>` with "previous / next in series" links from
   `predecessorIsbn` / `successorIsbn`. Verify each in the browser before moving on.
2. Look back at what you did and write **`.claude/skills/add-book-feature/SKILL.md`**: the steps in
   order, with a description that leads with trigger words.
3. **Test the skill in a fresh session**: ask for a small, matching change (e.g. "show the page
   count on the detail page") without naming the skill, and confirm Claude loads it. Refine the
   description if it didn't. The sample description above is only a starting point and often is
   not picked up as is: lead with the words your prompts contain (book, detail page, catalogue,
   field names such as page count or price).
4. Write the **`/new-book-view`** command with `disable-model-invocation: true` and `$ARGUMENTS`.
5. Run `/new-book-view create` (`POST /books`) and then `/new-book-view edit` (`PATCH
   /books/<isbn>`). Both are only reachable when signed in, so their routes (for example
   `/books/new` and `/books/<isbn>/edit`) must be in the `proxy.ts` matcher from the subagents
   task. Note what differed between them: ideally only the HTTP call and the form defaults.
6. Reflect: which of your repeated requests are skills, which are commands, and which belong in
   `CLAUDE.md`?

## Success Criteria

**Feature**

- [ ] `.claude/skills/add-book-feature/SKILL.md` exists and Claude loaded it on its own in a fresh
      session
- [ ] You refined the skill's description at least once based on observed behaviour
- [ ] A user-only command accepts an argument and built both the create and the edit screen
- [ ] You can explain skill vs. command vs. `CLAUDE.md` in your own words

**App still works**

- [ ] Search, sort, and paging survive a page reload (state lives in the URL)
- [ ] The detail page navigates through a series (e.g. the Harry Potter books) in both directions
- [ ] Creating a book with an existing ISBN shows a clear message for the API's `409`, not a crash
- [ ] Edit never sends `id`, `createdAt`, or `updatedAt`; type-check and `npm run build` pass

## Pitfalls (current framework)

- `params` and `searchParams` are **Promises** on recent Next.js — `await` them in pages.
- Server-side `fetch` results may be cached — make sure the list reflects a book you just created.
- Bind an ISBN into a Server Action while keeping the `(prev, formData)` signature:
  `action.bind(null, isbn)`.
- Route type helpers such as `PageProps<"/books/[isbn]">` exist only after `next dev` or
  `next build` has generated the route types; until then `tsc` reports `TS2344`.
- `/books/new` (signed-in group) and `/books/[isbn]` (public group) share one URL space. The
  static `new` segment wins, so this works, but keep it in mind when a route seems to vanish.

## References

- Claude Code — Skills: https://code.claude.com/docs/en/skills
- Claude Code — Control who invokes a skill: https://code.claude.com/docs/en/skills#control-who-invokes-a-skill
- Claude Code — Pass arguments to skills: https://code.claude.com/docs/en/skills#pass-arguments-to-skills
- BookMonkey API — Querying guide: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md
- Next.js — Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
