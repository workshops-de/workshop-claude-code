# German translation: glossary and style rules

Applies to the German slide deck and, later, to the German task translations.

- **English deck (source):** `google_slide_id` in `lessons/01-claude-code-workshop/lesson.yml`
- **German deck:** `google_slide_id_de` in the same file
  (`https://docs.google.com/presentation/d/1zhR5hkMM9ujaZk4zkoUt1WLMBnZ4KSj4WHNGYRcaQYI/edit`)

The English deck stays the source of truth. The German deck is a copy with the same slide order;
when an English slide changes, translate the matching German slide by hand (there is no
automatic sync).

## Address and tone

- Address participants as **„ihr/euch“** (as on workshops.de), never „Sie“ or „du“.
- Bullets: short, preferably infinitive style („Mit /init einen ersten Entwurf erzeugen“) or
  short statements. No full sentences with a trailing period.
- Little-What slides and longer explanations: full sentences.
- Keep the direct, practical tone of the English material. Recurring mottos stay English:
  „context is king“, „You push it, you own it“.
- German typography: „Anführungszeichen“, en dash with spaces ( – ) instead of a hyphen dash.

## Length (slides)

- Same limits as the English deck: max **4 bullets**, max **70 characters** per bullet.
- German runs 20–30 % longer: **shorten instead of translating word for word**. Drop filler words
  and pick the shorter synonym („prüfen“ instead of „überprüfen“).
- Slide titles: one line.

## 4-MAT labels

| English     | German                              |
| ----------- | ------------------------------------ |
| `How: …`    | `How: …` (label stays, rest is German)     |
| `What: …`   | `What: …` (label stays)                    |
| `What if: …`| `What if: …` (label stays)                 |
| `Task: …`   | `Aufgabe: …`                               |

Layout graphics (Little What, Why) are images and stay as they are.

## Code examples

- Commands, flags, file names, paths, config keys, JSON/YAML structure: **unchanged**.
- Translate: code comments (`# …`, `// …`) and prompts in natural language (`> …`) — participants
  prompt in German, Claude understands it.
- Prose inside skill/agent files (`description:`, body text) may be translated; keys stay.

## Speaker notes

Leave trainer speaker notes untouched (partly already German, written by the trainer).

## Glossary

### Stays English

| Term | Note |
| ---- | ---- |
| Claude Code, Agent SDK, Claude Agent SDK | product names |
| CLAUDE.md, SKILL.md, settings.json | file names |
| Plan Mode, Auto Mode, Permission Modes | feature names (`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions` as written) |
| Skills, Subagents (Sub-Agents in legacy slides), Hooks, Commands, Slash Commands | feature names |
| MCP, Model Context Protocol | |
| Rules & Imports | title; in bullets „Regeln“ is fine |
| Context Engineering, Lost in the Middle | concept names |
| Headless, Bare Mode, Worktree | |
| Memory | as the Claude Code feature; „Gedächtnis“ in explanatory text |
| Prompt, Session, Turn, Diff, Branch, PR, Review, Findings | everyday developer jargon |
| Refactoring, Debugging, Repro, Rubber Duck / Rubber Ducking | |
| Contract-Tests, Test-Suite, TDD, „use TDD“ | „use TDD“ is the literal prompt |
| Scaffold, Scope Creep, Library, Allowlist | |
| Spec Kit, Spec, constitution/specify/plan/tasks/implement | command names |
| BMAD, Persona, Party Mode, PRD, Stories, QA | |
| Gateway, Provider, Model Discovery | |
| Vibe Coding, Spec Driven AI Development | |
| BookMonkey | project name |

### Translated

| English | German |
| ------- | ------ |
| context window | Kontextfenster |
| context (in prose) | Kontext |
| permission(s) | Berechtigung(en) |
| boundary (stated in conversation) | Grenze |
| safety / security | Sicherheit (but „Security-Check“, „Security-Subagent“) |
| task (hands-on) | Aufgabe |
| practice ground | Übungsfeld |
| pitfalls | Stolperfallen |
| tool call | Tool-Aufruf |
| completion condition | Abbruchbedingung |
| classifier | Klassifikator |
| source of truth | Quelle der Wahrheit |
| reading list | Leseliste |
| book series | Buchreihe |
| sign-in | Anmeldung |
| catalogue | Katalog |
| API contract | API-Vertrag |
| reference API | Referenz-API |
| evidence | Belege |
| root cause | Ursache |
| intent | Absicht |
| AI (in prose) | KI (but „AI & Agentic Engineering“, „AI Pair Programming“ as names) |
