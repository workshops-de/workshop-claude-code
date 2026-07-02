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
    ├── lesson.yml     # Lesson metadata, points at the shared Google Slides deck
    └── tasks/
        └── NN-task-slug/
            ├── task.yml          # Metadata (title, position, category, timing)
            ├── body.md           # Main task description (required)
            ├── hint.md           # Progressive, collapsible hints (optional)
            ├── trainer_hint.md   # Facilitator-only notes (optional)
            └── bonus.md          # Stretch/"going further" content (optional)
```

Every knowledge block presented in the slides has exactly one corresponding task folder here,
numbered in teaching order.

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
(`workshop.md`) prepared by the trainer, rebalanced here into 5 half-day sessions. The reference
application the workshop builds towards is [`pawsaw/clash`](https://github.com/pawsaw/clash) — a
guide, not starter code: participants own every line of code they write, there are no prepared
repositories, branches, or checkpoints.

## Git conventions

Commits follow [Conventional Commits](https://www.conventionalcommits.org/).
