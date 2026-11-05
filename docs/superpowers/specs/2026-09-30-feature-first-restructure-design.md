# Feature-first restructure of the Claude Code workshop

**Date:** 2026-09-30
**Status:** Approved design, pending implementation plan

## Goal

Every task introduces exactly **one Claude Code feature** as its headline. The Clash reference app
(`pawsaw/clash`) remains the practice ground, but it is secondary: each task sets up and exercises
the feature first, then applies it to a Clash step. The workshop gets shorter as a result; freed
time is not refilled with new tasks.

## Problem with the current structure

- Tasks 060–120 (category "Building Clash", ~5.75 h) are project-driven: the headline is an app
  capability (scaffold, database, auth, maps…), and Claude Code features appear only incidentally.
- Tasks 130–170 (skills, custom commands, subagents, hooks, MCP) are feature-based, but only arrive
  **after** the app is built, so they are applied retroactively.

## Decisions

| Question | Decision |
| --- | --- |
| How radical? | Merge "Building Clash" and "Claude Code Building Blocks" into feature-first tasks |
| Freed time (~2.5 h)? | Workshop gets shorter; no new feature tasks |
| Scope | Repository **and** Google Slides in one pass |

## 1. New task list

010–050 (Foundations) stay unchanged. 060–120 become pure feature tasks; 130–170 are merged into
them and deleted.

| Pos. | New folder | Title (draft) | Min. | Absorbs | Category |
| --- | --- | --- | --- | --- | --- |
| 060 | `060-plan-mode` | Plan Before You Build: Scaffold with Plan Mode | 45 | 060 | Steering & Memory |
| 070 | `070-memory-rules-and-imports` | Pin Your Domain Language in Project Rules | 30 | 070 (+ path-scoped rules from 040 bonus) | Steering & Memory |
| 080 | `080-using-skills` | Let Installed Skills Drive Your Database Setup | 45 | 080 | Extending Claude Code |
| 090 | `090-subagents` | Review Your Auth with a Security Subagent | 50 | 090 + 150 | Extending Claude Code |
| 100 | `100-custom-skills-and-commands` | Capture Your Feature Pattern as Skill and Command | 60 | 100 + 130 + 140 | Extending Claude Code |
| 110 | `110-mcp` | Verify Your Map in the Browser via MCP | 45 | 110 + 170 | Extending Claude Code |
| 120 | `120-hooks` | Guard the Participation Flow with Hooks | 50 | 120 + 160 | Extending Claude Code |

- Time for 060–170: **475 → 325 minutes** (−150 min).
- Folders are renamed with `git mv` (history stays traceable: `git status --short` must show `R`).
  Absorbed folders `130-skills`, `140-custom-commands`, `150-subagents-and-multi-agent-workflows`,
  `160-hooks`, `170-mcp-and-external-tools` are deleted after their content is merged.
- Positions 130–170 stay empty; the stepped numbering scheme tolerates gaps.
- The "Building Clash" and "Claude Code Building Blocks" categories disappear.
- 180–270 stay unchanged in content; only cross-references to deleted/renamed tasks are fixed.
- 040 bonus: remove or shorten the path-scoped-rules bullet, since 070 now covers it.

## 2. Structure of every feature task

`body.md`:

1. **Overview** — feature pitch: what this feature gives you, in 2–3 sentences.
2. **The Feature** — what it is, when to reach for it, how it works, with real commands, file
   paths, and config snippets.
3. **Apply it to Clash** — short project context: which Clash step we use as the practice ground
   and what the app should be able to do afterwards. Link to `pawsaw/clash`.
4. **Steps** — first set up/exercise the feature, then apply it to the Clash step.
5. **Success Criteria** — feature criteria first (e.g. "the hook fired and blocked the read"), then
   a short "the app still works" block (`tsc --noEmit`, `npm run build`, key behaviour).
6. **References** — Claude Code docs first, then library docs.

`hint.md`, `trainer_hint.md`, `bonus.md`: merged from the absorbed tasks and trimmed. Hints stay at
2–4 `<details>` blocks. Trainer learning goals are centred on the feature; project pitfalls stay as
facilitation notes. Existing prerequisites (e.g. the `shadcn` and Prisma skills) are kept.

Per-task feature focus:

- **060 Plan Mode** — enter/exit plan mode, reviewing and pushing back on a plan, approving
  execution; practice: scaffold Next.js + Tailwind + shadcn with route groups.
- **070 Memory: rules & imports** — `.claude/rules/` (incl. path-scoped rules), `@`-imports from
  `CLAUDE.md`, `/memory`; practice: domain restatement, glossary and entity model recorded as a
  rule file.
- **080 Using skills** — installing skills, progressive disclosure, observing when a skill is
  invoked, checking which skills are available in a session; practice: Prisma schema, migration, seed with the Prisma
  skills.
- **090 Subagents** — built-in vs. custom subagents (`.claude/agents/`), tool restrictions,
  delegating review/exploration; practice: implement auth, then review it with a custom
  security-reviewer subagent.
- **100 Custom skills & commands** — authoring `SKILL.md` with a trigger-friendly description,
  authoring a custom slash command with arguments; practice: build one feature slice, encode the
  pattern as a skill, then add the second entity via the command/skill.
- **110 MCP** — adding/scoping an MCP server (`claude mcp add`, `.mcp.json`), using browser
  tooling (Playwright) for visual verification; practice: interactive Leaflet map with markers and
  a location picker, verified through MCP.
- **120 Hooks** — hook events, matchers, blocking via exit code; post-edit format/type-check hook
  and a secrets guard; practice: the participation state machine and notifications built with the
  hooks active.

## 3. Google Slides

- Before editing, read the live deck (`get_presentation` + `get_page`/`summarize_presentation`) to
  map `topicNN_*` blocks to tasks by their content — the deck order is not strictly numeric
  (`topic04` precedes `topic03`).
- **Blocks for 060–120:** rewrite all 7 slides around the feature (section title = feature name,
  Little What / Why / How / What / What if about the feature; the Task slide carries the new
  `task.yml` title). Use `deleteText` (`ALL`) + `insertText` on the existing placeholders. Respect
  the slide limits (single-line titles, ≤4 bullets, ≤70 chars each).
- **Blocks for 130–170:** delete their 5 × 7 = 35 slides (`deleteObject`). Useful content from them
  moves into the rewritten 090–120 blocks.
- **Leave alone:** legacy blocks (`claude_commands_*`, `claude_ide_*`, `claude_subagents_*`,
  `claude_cicd_*`), trainer-added intro/"Vibe Coding" slides, and — noted but out of scope — the
  duplicate install blocks (`task01install_*` / `claude_install_*`) and the stale
  `task015apikey_*` block whose task folder was already removed.
- Verify with `summarize_presentation` after the changes.

## 4. Documentation and commits

- `README.md`: structure/content-source section reflects the feature-first approach and new
  session split.
- `CLAUDE.md`: category list, the "Building Clash" framing, the feature-first `body.md` structure
  (The Feature → Apply it to Clash), and the "known pre-existing content" section (add the duplicate
  install / stale API-key blocks).
- Commits: Conventional Commits, atomic, directly on `main`:
  - one commit per new feature task (e.g. `refactor(plan-mode): make scaffolding task feature-first`),
    including deletion of the folders it absorbs
  - one commit for cross-reference fixes in 040 and 180–270
  - one commit for `README.md` + `CLAUDE.md`
  - Slides are not versioned in git.

## Out of scope

- Content changes to 010–050 (except the 040 bonus trim) and 180–270 (except cross-references).
- New feature tasks (checkpoints, plugins, worktrees, …).
- Cleanup of legacy/duplicate slide blocks.

---

## Revision 2026-11-05: BookMonkey instead of Clash, feature-prefixed titles

### Decisions

| Question | Decision |
| --- | --- |
| Title format | `<Feature>: <Action>` as in the React/PHP/SQLite fork (`lessons/12-claude-code-workshop`) |
| Practice project | BookMonkey, against the ready-made [`bookmonkey-api`](https://github.com/workshops-de/bookmonkey-api) first |
| Own backend | **Sequential**: everyone starts on the ready-made API; tasks 200 and 230 build an own **NestJS** backend against the same OpenAPI contract |
| State machine in 120 | Frontend **reading list** (want to read → reading → finished), persisted locally — the API has no checkout |
| Task slide title | `Task: <action>` without the feature prefix (the section slide already names the feature) |

### The ready-made API (verified 2026-11-05, v5.0.1)

- `npx bookmonkey-api` (Node ≥ 26), default port **4730**, Swagger UI `/api`, OpenAPI JSON `/api-json`.
- Books CRUD addressed by `:isbn`; `id` is a server GUID; `price` number + `currency` enum;
  series via `predecessorIsbn` / `successorIsbn`; server-managed `createdAt` / `updatedAt`.
- `GET /books` supports `_page`, `_limit`, `_sort`, `_order`, `q`, field filters, `_gte/_lte/_ne/_like`;
  `X-Total-Count` header when paging.
- `POST /register` / `POST /login` return `{ accessToken, user }`, but **no endpoint enforces the
  token**. Demo user `admin@bookmonkey.api` / `password1!`. `POST /dev/reset` restores the seed.
- Duplicate ISBN on `POST /books` → `409 Conflict`.

### Storyline

| Task | Title | BookMonkey step |
| --- | --- | --- |
| 060 | Plan Mode: Scaffold BookMonkey from a Reviewed Plan | Next.js + Tailwind frontend, API running on 4730 |
| 070 | Rules & Imports: Pin the Book Domain and API Contract | glossary, `docs/openapi.json` from `/api-json`, path-scoped rule for the API client |
| 080 | Skills: Build the Catalogue UI with an Installed Skill | shadcn skill builds the book list (shadcn moves from 060 to here) |
| 090 | Subagents: Review Your Login with a Security Subagent | login via `/login`, token handling, guard; reviewer flags the unenforced token |
| 100 | Custom Skills & Commands: Capture Your Book Feature Pattern | slice 1 list with search/sort/paging; slice 2 via `/new-book-view` create/edit |
| 110 | MCP: Verify the Catalogue in the Browser | Playwright checks covers, paging, series navigation |
| 120 | Hooks: Guard the Reading List Flow | reading-list state machine, hooks active |
| 200 | Testing & TDD: Drive Your Own Backend with Contract Tests | contract tests green against `bookmonkey-api`, then NestJS backend test-first |
| 230 | Autonomous Workflows: Finish Your Backend Against the Contract | `/goal` until all contract tests pass in a worktree, then switch `API_URL` |

All other tasks only get fork-format titles and Clash → BookMonkey wording. Slides: `topic05`–`topic11`
plus the blocks for 200 and 230 are updated; `lesson.yml` `github_code_url` points to `bookmonkey-api`.
