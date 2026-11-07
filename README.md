# Claude Code Workshop

Content repository for the Workshops.de **Claude Code** training, imported into the
[workshops.de](https://workshops.de) platform following the
[workshop-slides-template](https://github.com/workshops-de/workshop-slides-template) conventions.

## Structure

Slides for this workshop live in Google Slides (not Slidev), so this repository only carries the
platform-synced metadata and the hands-on tasks:

```
lessons/
└── 01-claude-code-workshop/
    ├── lesson.yml     # Lesson metadata, points at the English and German Google Slides decks
    └── tasks/
        └── NNN-task-slug/
            ├── task.yml          # Metadata (title, position, category, timing, translations.de.title)
            ├── body.md           # Main task description (required)
            ├── hint.md           # Progressive, collapsible hints (optional)
            ├── trainer_hint.md   # Facilitator-only notes (optional)
            ├── bonus.md          # Stretch/"going further" content (optional)
            └── *.de.md           # German translations of the files above
```

The workshop is available in English and German. English is the source; German files and the
German deck follow it. See [`docs/translation-de.md`](docs/translation-de.md) for the glossary,
style rules and translation workflow (`scripts/translation-status.sh`, `/translate-task-de`).

Every knowledge block presented in the slides has exactly one corresponding task folder here,
numbered in teaching order.

### Task numbering

Task folders and their `position:` field use a **3-digit, stepped scheme** (`010`, `020`, `030`,
…) instead of consecutive numbers. This leaves gaps to insert a new task between two existing ones
(e.g. `015`) without renaming or renumbering anything else. Only renumber existing tasks if you
run out of room between two neighbours (unlikely below ~9 insertions between them).

## Slides

All slides live in a single Google Slides deck (see `google_slide_id` in `lesson.yml`), one
section per knowledge block. Each knowledge block follows a fixed 7-slide pattern:

| Slide         | Layout          | Purpose                                     |
| ------------- | --------------- | -------------------------------------------- |
| Section title | Section header  | Name of the chapter/topic                    |
| Little What   | Little What     | One-sentence summary of the topic            |
| Why           | Why 1           | Why this matters / problem it solves         |
| How           | Title and body  | How we use it, step by step                  |
| What          | Code            | Concrete example(s)                          |
| Task          | Tasks 1         | Title of the hands-on task for this block    |
| What if       | Title and body  | Edge cases / pitfalls                        |

New slides are always written in English.

## Content source

The curriculum, task structure, and teaching narrative are derived from a canonical 3-day workshop
(`workshop.md`) prepared by the trainer.

The workshop is **feature-first**: every task introduces one Claude Code feature (plan mode,
rules, skills, subagents, MCP, hooks, …) as its headline, and a step of **BookMonkey**, a small book
catalogue, serves as the practice ground for it. Participants build the frontend against the
ready-made [`bookmonkey-api`](https://github.com/workshops-de/bookmonkey-api) (`npx bookmonkey-api`)
and later replace it with their own NestJS backend that honours the same OpenAPI contract (tasks
200 and 230). Participants own every line of code they write; there are no prepared repositories,
branches, or checkpoints.

Tasks are grouped into these categories, in teaching order:

| Category              | Tasks   | Focus                                                  |
| --------------------- | ------- | ------------------------------------------------------ |
| Foundations           | 010–050 | Install, fundamentals, permission modes, memory, context |
| Steering & Memory     | 060–070 | Plan mode, rules and imports                           |
| Extending Claude Code | 080–120 | Skills, subagents, custom commands, MCP, hooks         |
| Quality & Automation  | 180–220 | Refactoring, debugging, TDD, headless, PR review       |
| Autonomy & Methodologies | 230–270 | Autonomous runs, Agent SDK, gateways, Spec Kit, BMAD |

## Git conventions

Commits follow [Conventional Commits](https://www.conventionalcommits.org/).
