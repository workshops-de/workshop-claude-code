## Overview

Write your **own skill** and your **own slash command**, so the way your team builds a feature is
encoded once and reused everywhere — without re-explaining it each session. You will build one
feature by hand, capture its shape, and let the second feature be built from what you captured.

## The Feature

Both live in the same place and share one format: a `SKILL.md` in `.claude/skills/<name>/`
(legacy command files in `.claude/commands/<name>.md` still work and create the same `/name`).
What differs is **who decides when it runs**.

- **Skill (the agent decides)** — a trigger-friendly `description` lets Claude load it whenever a
  task matches:

  ```markdown
  ---
  name: add-feature
  description: Use when adding or changing a feature in this codebase - schema, data helper, server action, page, revalidation
  ---

  1. Add or update the shared Zod schema
  2. Add the data-access helper for reads
  3. Add the validated, authorized server action for writes
  4. Build the page/components, then revalidate affected paths
  5. Run tsc --noEmit and npm run build
  ```

- **Command (you decide)** — add `disable-model-invocation: true` so it only runs when you type
  it, and use `$ARGUMENTS` (or `$0`, `$1`, …) for input:

  ```markdown
  ---
  name: new-entity
  description: Scaffold list, detail, create and edit screens for an entity
  disable-model-invocation: true
  argument-hint: [EntityName]
  ---

  Build the full feature slice for $ARGUMENTS following the add-feature skill.
  ```

  Invoke it with `/new-entity Venue`.

- **Keep bodies short and actionable** — numbered steps beat prose, and a loaded skill stays in
  context for the rest of the session.

## Apply it to Clash

The practice ground is your first full **feature slice** — list, detail, create, and edit — on a
server-first architecture: **reads** in server components via data-access helpers, **writes**
through server actions that validate with a shared schema, authorize, persist, and revalidate.
Clash has two entities with the same shape (activities and venues), which makes it the perfect
test: if your skill is good, the second one is mostly generated from it.

## Prerequisites

- **Required skills:** `shadcn`, `prisma-client-api`
- **Required:** `find-skills` (`npx skills add vercel-labs/skills@find-skills -y`) — study how
  existing skills are structured before writing your own.
- Recommended: `frontend-design`, `react-best-practices`

## Steps

1. Build the slice for **one entity** with the agent: list (with search and sort), detail,
   create, and edit. Verify each screen in the browser before moving to the next.
2. Look back at what you did and write **`.claude/skills/add-feature/SKILL.md`**: the steps in
   order, with a description that leads with trigger words.
3. **Test the skill in a fresh session**: ask for a small, matching change (e.g. "add a
   capacity field to activities") without naming the skill, and confirm Claude loads it. Refine
   the description if it didn't.
4. Write the **`/new-entity`** command with `disable-model-invocation: true` and `$ARGUMENTS`.
5. Run `/new-entity <SecondEntity>` and let it build the second slice. Note what differed from the
   first one — ideally only fields.
6. Reflect: which of your repeated requests are skills, which are commands, and which belong in
   `CLAUDE.md`?

## Success Criteria

**Feature**

- [ ] `.claude/skills/add-feature/SKILL.md` exists and Claude loaded it on its own in a fresh
      session
- [ ] You refined the skill's description at least once based on observed behaviour
- [ ] A user-only command accepts an argument and built the second slice
- [ ] You can explain skill vs. command vs. `CLAUDE.md` in your own words

**App still works**

- [ ] List pages support search and sort; New/Edit write through a validated server action and
      the list/detail refreshes afterwards
- [ ] Only the host sees Edit/Delete on a detail page
- [ ] `tsc --noEmit` and `npm run build` pass

## Pitfalls (current framework)

- `params` and `searchParams` are **Promises** on recent Next.js — `await` them in pages.
- SQLite search via Prisma's `contains` is **case-sensitive** — decide if that matters for you.
- Bind an id into a Server Action while keeping the `(prev, formData)` signature: `action.bind(null, id)`.

## References

- Claude Code — Skills: https://code.claude.com/docs/en/skills
- Claude Code — Control who invokes a skill: https://code.claude.com/docs/en/skills#control-who-invokes-a-skill
- Claude Code — Pass arguments to skills: https://code.claude.com/docs/en/skills#pass-arguments-to-skills
- Next.js — Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
- shadcn/ui — Components: https://ui.shadcn.com/docs/components
