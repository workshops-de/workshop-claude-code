## Overview

Grow your project instructions beyond a single `CLAUDE.md`: split instructions into focused **rule
files**, scope some of them to the files they govern, and pull shared documents in with
**imports**. You will use this to pin down your domain language and the API contract so every
future session speaks them, without bloating the context of every single prompt.

## The Feature

Claude Code loads more than one memory file:

- **`.claude/rules/*.md`**: one topic per file (e.g. `domain.md`, `testing.md`). Rules without
  frontmatter load at launch, just like `CLAUDE.md`. Files are discovered recursively, so
  subfolders like `frontend/` work too.
- **Path-scoped rules**: add a `paths` field and the rule only loads when Claude reads matching
  files:

  ```markdown
  ---
  paths:
    - "lib/api*"
    - "lib/api/**"
  ---

  # API client rules
  - Books are addressed by ISBN, never by `id`
  ```

- **Imports**: `@path/to/file` inside `CLAUDE.md` expands another file into context at launch
  (relative to the importing file, up to four hops deep). Imports organise memory; they don't
  reduce its cost, because imported files load at launch too.
- **`/memory`** lists every memory file in play and opens one in your editor; **`/context`** shows
  which `CLAUDE.md` and rule files actually loaded into the current session.

Rule of thumb: always-relevant facts go in `CLAUDE.md` or an unscoped rule; area-specific
conventions go in a path-scoped rule.

## Apply it to BookMonkey

> **Repo / ports:** your `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!`

The practice ground is BookMonkey's **domain and API contract**. The `bookmonkey-api` looks
simple, but has traps an agent will happily fall into: a book has both a server-generated `id` and
an `isbn`, yet every detail route is addressed by ISBN. `price` is a number with a separate
`currency`. Books in a series point to each other via `predecessorIsbn` / `successorIsbn`.
`createdAt` / `updatedAt` are server-managed and can't be sent. Login hands out a token that no
endpoint checks.

You agree on that language once and store it where every session can read it. The contract itself
is the OpenAPI document the API serves at `/api-json`, the same contract your own backend will
have to honour later.

## Steps

1. With the API running, save the contract: `curl -s http://localhost:4730/api-json >
   docs/openapi.json`.
2. Ask the agent to **restate the domain in its own words** from `docs/openapi.json` and a few real
   responses (`GET /books?_limit=3`, `GET /books/<isbn>`): entities, fields, relationships, and
   what the server manages. Correct any drift.
3. Ask it to list terms that are unclear or could be confused (`id` vs. `isbn`, author vs.
   co-authors, predecessor vs. successor) and resolve each into one agreed definition. Add the
   term **reading list** now, with its states *want to read → reading → finished*; you'll build it
   in the hooks task.
4. Have the agent write the result to **`.claude/rules/domain.md`**: glossary, entity model, and
   constraints such as "ISBN is unique: a duplicate `POST /books` returns `409`". If you probe
   that live, remember the API is shared state: `curl -X POST http://localhost:4730/dev/reset`
   restores the 50 seed books.
5. Have it write a **compact** `docs/api-contract.md` (endpoints, query parameters, status codes;
   one screen, not the full JSON) and **import** it from `CLAUDE.md` with `@docs/api-contract.md`.
   Create `CLAUDE.md` if it is missing, and add `@AGENTS.md` next to that import: `create-next-app`
   wrote an `AGENTS.md`, and Claude Code stops reading it once a `CLAUDE.md` exists.
6. Add a **path-scoped rule** `.claude/rules/api-client.md` with `paths` pointing at your API
   client code (in the scaffold from the plan mode task that is `lib/api.ts`, there is no `src/`), holding the conventions that only matter there (address by ISBN, never send
   server-managed fields, read `X-Total-Count` for paging, `docs/openapi.json` is the source of
   truth).
7. Start a fresh session and run `/context`: confirm `domain.md` and the imported contract loaded
   and `api-client.md` did **not**, then ask a domain question and check the answer uses your
   glossary.

## Success Criteria

**Feature**

- [ ] `.claude/rules/domain.md` exists and loads in a fresh session (visible in `/context`)
- [ ] `CLAUDE.md` imports `docs/api-contract.md` via `@`
- [ ] At least one rule is path-scoped with `paths` frontmatter and stays unloaded until a
      matching file is read
- [ ] You can explain why you imported a compact summary instead of the raw `openapi.json`

**Domain model**

- [ ] The glossary names every core entity (book, user, series, reading list) with one agreed
      definition
- [ ] `id` vs. `isbn` and the server-managed fields are explicitly captured
- [ ] The ISBN uniqueness constraint and the reading-list states are recorded

## References

- Claude Code: Memory, rules and imports: https://code.claude.com/docs/en/memory
- Claude Code: Path-specific rules: https://code.claude.com/docs/en/memory#path-specific-rules
- BookMonkey API (README and querying guide): https://github.com/workshops-de/bookmonkey-api
- Ubiquitous language: https://martinfowler.com/bliki/UbiquitousLanguage.html
