## Overview

Grow your project memory beyond a single `CLAUDE.md`: split instructions into focused **rule
files**, scope some of them to the files they govern, and pull shared documents in with
**imports**. You will use this to pin down your domain language so every future session speaks
it — without bloating the context of every single prompt.

## The Feature

Claude Code loads more than one memory file:

- **`.claude/rules/*.md`** — one topic per file (e.g. `domain.md`, `testing.md`). Rules without
  frontmatter load at launch, just like `CLAUDE.md`. Files are discovered recursively, so
  subfolders like `frontend/` work too.
- **Path-scoped rules** — add a `paths` field and the rule only loads when Claude reads matching
  files:

  ```markdown
  ---
  paths:
    - "prisma/**"
    - "lib/validation/**"
  ---

  # Data model rules
  - Status fields are documented strings, never free text
  ```

- **Imports** — `@path/to/file` inside `CLAUDE.md` expands another file into context at launch
  (relative to the importing file, up to four hops deep). Imports organise memory; they don't
  reduce its cost, because imported files load at launch too.
- **`/memory`** lists every memory file in play and opens one in your editor; **`/context`** shows
  which `CLAUDE.md` and rule files actually loaded into the current session.

Rule of thumb: always-relevant facts go in `CLAUDE.md` or an unscoped rule; area-specific
conventions go in a path-scoped rule.

## Apply it to Clash

The practice ground is the **domain model** of [`pawsaw/clash`](https://github.com/pawsaw/clash):
activities happening at a place and time, hosted at reusable venues, joined by request/approval.
Ambiguity is a context hazard — synonyms and vague terms lead the agent to merge things that
should stay distinct. You agree on the language once and store it where every session can read
it. No schema or code yet.

## Steps

1. Give the agent the brief and ask it to **restate the domain in its own words** — core entities,
   how they relate, and the lifecycle of a join request. Correct any drift.
2. Ask it to list terms that are unclear or could be confused, and resolve each into one agreed
   definition.
3. Have the agent write the result to **`.claude/rules/domain.md`**: glossary, entity model
   (entities, key attributes, relationships incl. optional ones, states), and constraints such as
   "one request per person per activity".
4. Add a **path-scoped rule** (for example `.claude/rules/data-model.md` with `paths` pointing at
   where your schema and validation will live) holding the conventions that only matter there.
5. If you keep the brief as a file (e.g. `docs/brief.md`), **import** it from `CLAUDE.md` with
   `@docs/brief.md`.
6. Start a fresh session and run `/context`: confirm `domain.md` loaded and the path-scoped rule
   did **not** — then ask a domain question and check the answer uses your glossary.

## Success Criteria

**Feature**

- [ ] `.claude/rules/domain.md` exists and loads in a fresh session (visible in `/context`)
- [ ] At least one rule is path-scoped with `paths` frontmatter and stays unloaded until a
      matching file is read
- [ ] You can explain when to use `CLAUDE.md`, an unscoped rule, a path-scoped rule, or an import

**Domain model**

- [ ] The glossary names every core entity with one agreed definition
- [ ] The entity model covers attributes, relationships (incl. optional ones), and states
- [ ] Any uniqueness constraint is explicitly captured

## References

- Claude Code — Memory, rules and imports: https://code.claude.com/docs/en/memory
- Claude Code — Path-specific rules: https://code.claude.com/docs/en/memory#path-specific-rules
- Clash brief (reference domain): https://github.com/pawsaw/clash
- Ubiquitous language: https://martinfowler.com/bliki/UbiquitousLanguage.html
