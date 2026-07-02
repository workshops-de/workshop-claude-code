# CLAUDE.md

Guidance for Claude Code (or any agent/human) working in this repository. This file documents
**exactly how this project was built** so new knowledge blocks and tasks can be added the same
way.

## What this repo is

Content repository for the Workshops.de **Claude Code** training, imported into the
[workshops.de](https://workshops.de) platform following the
[workshop-slides-template](https://github.com/workshops-de/workshop-slides-template) conventions.
Slides live in **Google Slides**, not Slidev, so this repo only holds platform-synced metadata and
hands-on tasks — see `README.md` for the high-level structure.

- **Lesson metadata:** `lessons/01-claude-code-workshop/lesson.yml`
- **Google Slides deck:** `google_slide_id: 1voXfvVnvD3zC319A2Q4G78ncF43kSbYX6i592zJgBx4` (one
  shared presentation for the whole workshop)
- **Reference application:** [`pawsaw/clash`](https://github.com/pawsaw/clash) — inspiration/guide
  only, not starter code. Participants own every line they write; there are no prepared
  repositories, branches, or checkpoints.
- **Content source:** curriculum, task structure, and teaching narrative are adapted from a
  canonical workshop document (`workshop.md`) prepared by the trainer (26 topics, originally a
  3-day format), rebalanced here into 6 half-day "mornings" plus foundational setup tasks.

## Task folder conventions

```
lessons/01-claude-code-workshop/tasks/NNN-task-slug/
├── task.yml          # required: title, position, category, timing, lock/prep flags
├── body.md           # required: Overview, Background, Steps, Success Criteria, References
├── hint.md           # optional: collapsible <details> hints, 2-4 per task
├── trainer_hint.md   # optional: facilitator-only notes (learning goals, timing, pitfalls)
└── bonus.md          # optional: "Going further" stretch content
```

`task.yml` shape:

```yaml
title: 'Imperative, GitHub-issue-style title'
position: 20          # matches the numeric folder prefix
category: 'Foundations'  # or the morning's theme, see below
preparation: false     # true only for pure setup tasks done before the session
estimated_time_in_minutes: 30
always_unlocked: false # true only for setup tasks that must work before the trainer unlocks anything
```

No `git_tag_completed` / solution branches: there is no prepared repository for this workshop, so
omit git integration fields entirely.

### Numbering scheme — read this before adding a task

Folders and `position:` use a **3-digit, stepped scheme** (`010`, `020`, `030`, … step 10), **not**
consecutive numbers. This leaves gaps to insert a new task between two existing ones (e.g. `015`)
without renaming or renumbering anything else. Only renumber existing tasks if you run out of room
between two neighbours (unlikely below ~9 insertions at the same spot).

To add a task between `010` and `020`: create `015-new-task-slug/` with `position: 15`. Done — no
other file changes needed for the numbering itself.

### Content style

- Body text: Overview → (Background/Prerequisites) → numbered Steps → Success Criteria checklist
  → References. Keep steps actionable and concrete (real commands, real prompts).
- Hints: 2–4 collapsible `<details>` blocks, each nudging without giving away the solution.
- Trainer notes: learning goals, facilitation notes (common pitfalls, timing, what to watch for),
  time estimate.
- Tone throughout: matches the trainer's canonical material — direct, practical, recurring themes
  like "context is king" and "you push it, you own it".

## Google Slides workflow

All slides live in **one** presentation
(`https://docs.google.com/presentation/d/1voXfvVnvD3zC319A2Q4G78ncF43kSbYX6i592zJgBx4/edit`),
edited via the `user-google-slides-mcp` MCP server (`get_presentation`, `get_page`,
`batch_update_presentation`, `summarize_presentation`).

**New slides are always written in English.** Slide titles: short, single line. Bullet lists: max
4 bullets, max 70 characters each — anything longer overflows the slide.

### The 7-slide pattern per knowledge block

Every task/knowledge block gets exactly these 7 slides, in this order, using these exact layouts:

| # | Purpose                | Layout (`displayName`) | `layoutObjectId`         | Placeholders to fill                                                              |
| - | ----------------------- | ----------------------- | ------------------------- | ---------------------------------------------------------------------------------- |
| 1 | Section title            | Section header 1        | `g90f556b6f5_0_101`        | `TITLE` (block name), `SUBTITLE` index 1 (one-line tagline)                        |
| 2 | Little What               | Little What              | `g90f556b6f5_0_98`         | `BODY` (one sentence: what this is)                                                |
| 3 | Why                       | Why 1                    | `g90f556b6f5_0_104`        | `BODY` (≤4 bullets: why it matters)                                                |
| 4 | How                       | Title and body           | `g90f556b6f5_0_70`         | `TITLE` ("How: …"), `BODY` (≤4 bullets: steps)                                     |
| 5 | What                      | Code                     | `g90f556b6f5_0_76`         | `TITLE` ("What: …"), `BODY` (2 mini-headers), `BODY` idx 1 (code), `BODY` idx 2 (one-line tip) |
| 6 | Task                      | Tasks 1                  | `g90f556b6f5_0_91`         | `TITLE` index 1 ("Task: <task.yml title>")                                         |
| 7 | What if                   | Title and body           | `g90f556b6f5_0_70`         | `TITLE` ("What if: …"), `BODY` (≤4 bullets: pitfalls)                              |

Layout IDs are stable for this presentation (`master` = `g90f556b6f5_0_57`) — re-verify with
`get_presentation` + `fields: "layouts(objectId,layoutProperties)"` if they ever seem wrong.

### Adding a new knowledge block — step by step

1. **Find the current slide count/order first.** Other people can and do edit this deck directly
   (the trainer has added intro/onboarding slides and a "Vibe Coding" section outside this
   workflow). Never assume stale slide indices — call `get_presentation` with
   `fields: "slides(objectId)"` right before inserting, and compute your `insertionIndex` from the
   live result (find the object ID of the slide you want to insert after, take its array index + 1).
2. **Create all 7 slides in one `batch_update_presentation` call** using `createSlide` requests
   with explicit `objectId`s (e.g. `topicNN_title`, `topicNN_little_what`, …) and
   `placeholderIdMappings` per the table above, so every placeholder gets a predictable ID and you
   avoid a round-trip to discover them.
   - `layoutPlaceholder` needs `type` only for placeholders with no explicit index (most of them);
     add `index: 1` / `index: 2` only where the table above says so (subtitle, the 2nd/3rd body on
     the Code layout, the title on Tasks 1).
3. **Fill text in a second `batch_update_presentation` call** using `insertText` at
   `insertionIndex: 0` on each placeholder object ID from step 2. Don't pre-populate text via
   `createSlide` — placeholders are created empty.
4. **When editing existing slide text** (not creating), prefer `deleteText` (`textRange: {type:
   "ALL"}`) + `insertText`. If the text lives inside a slide you didn't create yourself (e.g.
   something the trainer added with custom bullet/list styling), prefer `replaceAllText` scoped
   with `pageObjectIds` instead — it substitutes text in place without disturbing bullet glyphs or
   other formatting you don't fully control.
5. **Verify** with `summarize_presentation` (or `get_page` for a specific slide) before moving on.

### Known pre-existing content to leave alone (for now)

Five legacy slide blocks (`claude_commands_*`, `claude_ide_*`, `claude_subagents_*`,
`claude_cicd_*`, plus assorted intro/"Vibe Coding" slides the trainer added directly) still exist
in the deck and don't map cleanly onto the 26-topic curriculum. They're intentionally left in place
pending a deliberate cleanup pass — don't delete or "fix" them incidentally while adding new
content.

## Git conventions

- Commits follow [Conventional Commits](https://www.conventionalcommits.org/) —
  `type(scope): summary`, imperative mood, no capital first letter, no trailing period.
- Commit directly to `main`; keep commits atomic (one task, one structural change, or one content
  fix per commit).
- When renaming/renumbering task folders, use `git mv` (or let `git add -A` detect the rename) so
  history stays traceable — check `git status --short` shows `R` (rename), not delete+add.

## Quick checklist for "add a new task"

- [ ] Pick a `position`/folder number that fits the stepped scheme between its neighbours
- [ ] Create `tasks/NNN-slug/` with `task.yml`, `body.md`, `hint.md`, `trainer_hint.md` (+ `bonus.md` if there's "going further" content)
- [ ] Re-fetch the live slide order, then create + fill the matching 7-slide block in Google Slides
- [ ] Verify slide text (bullet counts/lengths) and task files render sensibly
- [ ] Commit with a Conventional Commits message and push
