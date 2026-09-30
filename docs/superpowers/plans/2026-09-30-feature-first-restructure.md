# Feature-first Restructure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn tasks 060–170 into seven feature-first tasks (060–120), delete the absorbed tasks,
and bring the Google Slides deck and repo docs in line.

**Architecture:** Content-only change. Task folders are renamed with `git mv`, their Markdown is
rewritten around one Claude Code feature each, and absorbed folders are removed with `git rm`. The
matching slide blocks (`topic05`–`topic11`) are rewritten in place; `topic12`–`topic16` are deleted.

**Tech Stack:** Markdown/YAML task files, git, Google Slides API via `user-google-slides-mcp`.

**Spec:** `docs/superpowers/specs/2026-09-30-feature-first-restructure-design.md`

## Global Constraints

- Task content in English; tone direct and practical ("context is king", "you push it, you own it").
- `body.md` sections, in order: Overview → The Feature → Apply it to Clash → (Prerequisites if
  any) → Steps → Success Criteria (feature first, then "App still works") → References (Claude
  Code docs first).
- `hint.md`: 2–4 `<details>` blocks, `<summary>💡 Hint N: …</summary>`, nudges not solutions.
- `trainer_hint.md`: `## Learning goals` / `## Facilitation notes` / `## Time estimate`; no
  "Morning N" / "Day N" references.
- `task.yml`: keep the existing comment style; no git integration fields.
- Slides: English, single-line titles, ≤4 bullets, ≤70 chars per bullet.
- Commits: Conventional Commits, imperative, lower-case, no trailing period, directly on `main`.
- `git status --short` must show `R` for renamed folders before committing.

## Slide map (verified live on 2026-09-30)

| Task | Block | Action |
| --- | --- | --- |
| 060 | `topic05_*` | rewrite |
| 070 | `topic06_*` | rewrite |
| 080 | `topic07_*` | rewrite |
| 090 | `topic08_*` | rewrite |
| 100 | `topic09_*` | rewrite |
| 110 | `topic10_*` | rewrite; move trainer slide `g4099a12ada7_0_257` after `topic10_why` |
| 120 | `topic11_*` | rewrite |
| 130–170 | `topic12_*`–`topic16_*` | delete (35 slides) |

Placeholder IDs per block `NN`: `topicNN_title_ph`, `topicNN_subtitle_ph`,
`topicNN_littlewhat_ph`, `topicNN_why_ph`, `topicNN_how_title_ph`, `topicNN_how_body_ph`,
`topicNN_what_title_ph`, `topicNN_what_body0_ph`, `topicNN_what_body1_ph`,
`topicNN_what_body2_ph`, `topicNN_task_title_ph`, `topicNN_whatif_title_ph`,
`topicNN_whatif_body_ph`.

---

### Task 1: 060 Plan Mode

**Files:** `git mv tasks/060-project-initialization tasks/060-plan-mode`; rewrite `task.yml`,
`body.md`, `hint.md`, `trainer_hint.md`.

- [ ] `task.yml`: title `Plan Before You Build: Scaffold with Plan Mode`, category
  `Steering & Memory`, 45 min.
- [ ] `body.md` feature: plan mode in depth (enter via `Shift+Tab` / `claude --permission-mode
  plan`, iterate on the plan, edit it in your editor, choose how to proceed on approval), building
  on the 020 intro. Clash: Next.js + Tailwind + shadcn scaffold with route groups. Keep shadcn
  prerequisite and route-group/commit criteria.
- [ ] Hints: push back on the plan; keep scope minimal; shadcn CLI prompts.
- [ ] Commit: `refactor(plan-mode): make scaffolding task feature-first`

### Task 2: 070 Memory — rules & imports

**Files:** `git mv tasks/070-domain-modelling tasks/070-memory-rules-and-imports`; rewrite all.

- [ ] `task.yml`: `Pin Your Domain Language in Project Rules`, `Steering & Memory`, 30 min.
- [ ] Feature: `.claude/rules/*.md`, path-scoped rules via `paths` frontmatter, `@`-imports from
  `CLAUDE.md`, `/memory`. Clash: domain restatement, glossary + entity model stored as a rule file.
- [ ] Commit: `refactor(memory-rules-and-imports): make domain modelling task feature-first`

### Task 3: 080 Using skills

**Files:** `git mv tasks/080-database-design tasks/080-using-skills`; rewrite all.

- [ ] `task.yml`: `Let Installed Skills Drive Your Database Setup`, `Extending Claude Code`, 45 min.
- [ ] Feature: installing skills, where they live, progressive disclosure, observing automatic vs.
  explicit (`/skill-name`) invocation. Clash: Prisma schema/migrate/seed; keep Prisma 7 pitfalls.
- [ ] Commit: `refactor(using-skills): make database task feature-first`

### Task 4: 090 Subagents (absorbs 150)

**Files:** `git mv tasks/090-authentication tasks/090-subagents`; rewrite all; add `bonus.md`
(multi-agent content from 150); `git rm -r tasks/150-subagents-and-multi-agent-workflows`.

- [ ] `task.yml`: `Review Your Auth with a Security Subagent`, `Extending Claude Code`, 50 min.
- [ ] Feature: built-in subagents (Explore), custom subagents in `.claude/agents/` via `/agents`,
  frontmatter (`name`, `description`, `tools`, `model`), context isolation. Clash: auth, then a
  read-only `security-reviewer` subagent reviews it; you triage. Keep auth pitfalls.
- [ ] Commit: `refactor(subagents): merge auth and subagent tasks feature-first`

### Task 5: 100 Custom skills & commands (absorbs 130, 140)

**Files:** `git mv tasks/100-ui-development tasks/100-custom-skills-and-commands`; rewrite all;
`bonus.md` merged from 130/140; `git rm -r tasks/130-skills tasks/140-custom-commands`.

- [ ] `task.yml`: `Capture Your Feature Pattern as Skill and Command`, `Extending Claude Code`, 60 min.
- [ ] Feature: authoring `SKILL.md` (trigger-friendly description), user-triggered commands with
  `$ARGUMENTS` (`.claude/commands/` or a skill with `disable-model-invocation: true`), skill vs.
  command. Clash: build one feature slice, encode it, build the second entity via skill/command.
- [ ] Commit: `refactor(custom-skills-and-commands): merge ui, skills and commands tasks`

### Task 6: 110 MCP (absorbs 170)

**Files:** `git mv tasks/110-maps tasks/110-mcp`; rewrite all; `bonus.md` from 170;
`git rm -r tasks/170-mcp-and-external-tools`.

- [ ] `task.yml`: `Verify Your Map in the Browser via MCP`, `Extending Claude Code`, 45 min.
- [ ] Feature: `claude mcp add`, scopes / `.mcp.json`, `/mcp`, context cost. Clash: Leaflet map
  (client-only constraint), verified through Playwright MCP.
- [ ] Commit: `refactor(mcp): merge maps and mcp tasks feature-first`

### Task 7: 120 Hooks (absorbs 160)

**Files:** `git mv tasks/120-participation-and-notifications tasks/120-hooks`; rewrite all;
`bonus.md` from 160; `git rm -r tasks/160-hooks`.

- [ ] `task.yml`: `Guard the Participation Flow with Hooks`, `Extending Claude Code`, 50 min.
- [ ] Feature: events, matchers, stdin JSON (`tool_input.file_path`), exit code 2 blocks, `/hooks`,
  `.claude/settings.json`. Clash: participation state machine built with format/type-check and
  secrets-guard hooks active.
- [ ] Commit: `refactor(hooks): merge participation and hooks tasks feature-first`

### Task 8: Cross-references

- [ ] `040-claude-md/bonus.md`: drop path-scoped rules from the first bullet (now in 070).
- [ ] Re-grep for `Building Clash`, `Building Blocks`, removed folder slugs; fix any hit.
- [ ] Commit: `docs(claude-md): point path-scoped rules to the memory rules task`

### Task 9: README.md + CLAUDE.md

- [ ] README: feature-first framing, categories, reference app as practice ground.
- [ ] CLAUDE.md: categories, feature-first `body.md` structure, merged-topic note, known
  pre-existing slide content (duplicate install blocks, stale API-key block, moved empty slide).
- [ ] Commit: `docs: document feature-first task structure`

### Task 10: Google Slides

- [ ] Re-fetch `slides(objectId)`; confirm the slide map above still holds.
- [ ] One batch per block: `deleteText` (ALL) + `insertText` on all 13 placeholders.
- [ ] `updateSlidesPosition` for `g4099a12ada7_0_257` to just after `topic10_why`.
- [ ] `deleteObject` for all 35 `topic12_*`–`topic16_*` slides.
- [ ] Verify via `get_presentation` text extraction: titles single-line, ≤4 bullets, ≤70 chars.

### Task 11: Push

- [ ] `git status` clean, `git log` shows atomic commits, `git push`.
