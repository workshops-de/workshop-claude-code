---
name: translate-task-de
description: Translate a workshop task folder (body.md, hint.md, bonus.md, trainer_hint.md, title) into German as *.de.md files and translations.de.title in task.yml, following docs/translation-de.md. Use when asked to translate tasks to German, to update stale German translations, or to work through scripts/translation-status.sh.
argument-hint: "[task folder, e.g. 120-hooks | --todo | all]"
---

# Translate a task to German

Translate tasks in `lessons/01-claude-code-workshop/tasks/` into German. English stays the source
of truth; German lives next to it and the platform imports it as `translations.de.*`.

## Target format

| English source            | German file / field                        | Platform field                            |
| ------------------------- | ------------------------------------------ | ----------------------------------------- |
| `body.md`                 | `body.de.md`                               | `translations.de.body_markdown`           |
| `hint.md`                 | `hint.de.md`                               | `translations.de.hint_markdown`           |
| `bonus.md`                | `bonus.de.md`                              | `translations.de.bonus_markdown`          |
| `trainer_hint.md`         | `trainer_hint.de.md`                       | `translations.de.trainer_hint_markdown`   |
| `task.yml` → `title`      | `task.yml` → `translations.de.title`       | `translations.de.title`                   |

Only translate files that exist in English. Never touch the English files, `position`,
`category`, timing or flags — they are shared by both languages.

`task.yml` gets this block appended at the end (keep everything else as is):

```yaml
translations:
  de:
    title: 'Hooks: Den Leselisten-Flow absichern'
```

## Which tasks

- `$ARGUMENTS` is a folder name (`120-hooks`) → that task.
- `--todo` or no argument → run `scripts/translation-status.sh --todo` and work through the
  listed tasks, one task at a time.
- `all` → every task, one at a time.
- For a **STALE** file: diff the English file since the German one was last committed
  (`git log -1 --format=%H -- <file>.de.md`, then `git diff <hash> -- <file>.md`) and update only
  the changed passages in the German file instead of re-translating everything.

## Before translating

1. Read `docs/translation-de.md` completely — glossary, address, typography, code rules. It is
   binding; the slides were translated with it.
2. Read all English files of the task, so terms are consistent between body, hints and trainer
   notes.
3. If the German slide block for this task already uses a phrasing (title, „Aufgabe: …“), reuse
   it. The task title in German is the slide's „Aufgabe:“ title with the feature prefix kept:
   slide `Aufgabe: Den Leselisten-Flow absichern` → title `Hooks: Den Leselisten-Flow absichern`.

## Translation rules (short form — details in docs/translation-de.md)

- Address participants as **„ihr/euch“**; trainer notes may address the trainer directly („du“)
  only if the English does — otherwise neutral.
- Keep the **Markdown structure 1:1**: same headings (translated), same lists, same order, same
  tables, same `<details>`/`<summary>` blocks (translate the summary text, keep the emoji).
- Section headings: Overview → Überblick, The Feature → Das Feature, Apply it to BookMonkey →
  Anwendung auf BookMonkey, Prerequisites → Voraussetzungen, Steps → Schritte, Success Criteria →
  Erfolgskriterien, References → Referenzen, Background → Hintergrund, Learning goals → Lernziele,
  Facilitation notes → Hinweise zur Durchführung, Going further → Weiterführend.
  For any other heading, translate it and add it to the glossary in `docs/translation-de.md`.
- **Code stays code**: commands, flags, file names, paths, JSON/YAML keys, identifiers unchanged.
  Translate comments and natural-language prompts (`> …`) inside code blocks.
- Inline code (`` `…` ``) is never translated.
- Links: keep URLs. Claude Code docs links stay on the English docs.
- Bold/italic emphasis stays on the corresponding German words.
- Mottos stay English: „context is king“, „You push it, you own it“.
- Feature names from the glossary stay English (Plan Mode, Skills, Hooks, Subagents, MCP, …).
- Prefer natural German over literal translation; keep it as concise as the original.

## After translating

1. Self-check each German file against its English source:
   - same number of headings, list items, code blocks and `<details>` blocks
   - code blocks byte-identical except comments and prompts
   - no English sentences left over (feature names and mottos excepted)
2. Run `scripts/translation-status.sh` and confirm the task shows `ok` for every file.
3. Commit one task per commit:
   `docs(tasks): translate <folder> to german` (or `… update german translation of <folder>`).
