## Overview

Give your project a durable, curated memory that steers every Claude Code session. You will create
and refine a `CLAUDE.md` so the agent consistently knows your stack, conventions, commands, and
review expectations — without you re-explaining them each time. The lesson is that **long-term
memory is curated, not dumped**: every line costs context on each turn.

## Background

`CLAUDE.md` is a Markdown file Claude Code reads at the start of every session — your project's
long-term memory. It is where you encode the decisions and conventions you want honoured every
time. Because it is loaded on each turn, it must be high-signal: state what the model can't infer
and delete what it already knows. Subdirectory memory files load only when working in that area,
and the agent can also accumulate its own memory of useful facts as it works.

## Steps

1. Use `/init` to generate a first-draft `CLAUDE.md`, then read what it produced.
2. **Curate** it down to high-value facts: your stack and versions, architectural rules, the
   commands that matter (run, build, lint, type-check), a short domain glossary, and a review
   checklist.
3. Delete anything generic the model already knows. Aim for signal over volume.
4. Open a **fresh** session and ask a question whose answer depends on your memory file. Confirm
   the agent follows your conventions.
5. Add a **subdirectory** memory file for one area of your project and verify it loads only when
   working there.
6. Reflect on what belongs in memory versus what belongs in a one-off prompt.

## Success Criteria

- [ ] A concise `CLAUDE.md` exists at your project root
- [ ] It covers stack, architectural rules, key commands, a glossary, and a review checklist
- [ ] A fresh session demonstrably follows a convention from the file
- [ ] At least one subdirectory memory file exists and loads only in its own area

## References

- Claude Code — Memory & CLAUDE.md: https://code.claude.com/docs/en/memory
- Claude Code — Settings: https://code.claude.com/docs/en/settings
- AGENTS.md convention (related idea): https://agents.md
