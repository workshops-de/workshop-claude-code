## Overview

Give a project a durable, curated memory that steers every Claude Code session. You generate a
`CLAUDE.md` for the codebase you explored in the fundamentals task, cut it down to what matters,
and prove in a fresh session that it works. The lesson is that **long-term memory is curated, not
dumped**: every line costs context on each turn.

## The Feature

`CLAUDE.md` is a Markdown file Claude Code reads at the start of every session: your project's
long-term memory.

- **Bootstrap it** with `/init`. Claude analyses the codebase and writes a first draft with build
  commands, test instructions, and the conventions it found. If a `CLAUDE.md` already exists,
  `/init` suggests improvements instead of overwriting it.
- **Curate it.** Keep what Claude cannot infer by itself: exact commands, architectural rules,
  traps, a short glossary, a review checklist. Delete what it already knows.
- **Scope it.** A `CLAUDE.md` in a subdirectory (for example `api/CLAUDE.md`) is not loaded at
  launch. It loads once Claude reads or edits a file in that directory.
- **Personal notes** go into `CLAUDE.local.md` (add it to `.gitignore`). `/memory` shows and edits
  the loaded memory files.

## Apply it to BookMonkey Legacy

The practice ground is the [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)
clone from the fundamentals task. It has no `CLAUDE.md` yet, only a README that several people
edited over the years. A new teammate (human or agent) would read both, so both had better be
right. Your memory file should hold the facts the next session needs, checked against the code.

## Prerequisites

- The `bookmonkey-legacy` clone from the fundamentals task
- Node.js 24 or newer, so you can run the commands you write down

## Steps

1. Start Claude Code in `bookmonkey-legacy` and run `/init`. Read what it produced before you
   change anything.
2. **Compare `/init` with the README.** Ask Claude for a table: each claim the README makes,
   what `/init` wrote about it, and what the code says. Check every row where they disagree yourself (open the file, run the command).
3. **Run the commands** your draft lists (`npm install`, `npm run db:reset`, `npm test`, the two
   dev servers) and keep only the ones that work exactly as written.
4. **Curate** the file to high-value facts: stack and versions, how to start each part, the
   commands, architectural rules, a short domain glossary (loan, copy, reservation, waitlist, ...),
   traps you confirmed in step 2, and a review checklist. Delete anything generic.
5. Add a **subdirectory** memory file, for example `api/CLAUDE.md` with rules for the API only.
   Verify it loads only when Claude works in `api/` (ask about it before and after Claude has read
   an API file, or check `/memory`).
6. Open a **fresh** session (`/clear` or a new terminal) and ask a question whose answer depends on
   your file, for example "How do I reset the database and run the tests?" or "Which port does the
   API use?". Confirm the answer comes from your memory, not from a new exploration.
7. Commit the memory files in your clone (`git add CLAUDE.md api/CLAUDE.md && git commit`), so the
   later tasks in this repository start with them.

## Success Criteria

**Feature**

- [ ] `/init` ran, and you can name at least two things you removed from its draft and why
- [ ] A concise `CLAUDE.md` covers stack, commands, architectural rules, a glossary, and a review
      checklist
- [ ] A subdirectory memory file exists and loads only in its own area
- [ ] A fresh session demonstrably answered from the memory file

**Memory is true**

- [ ] Every command in `CLAUDE.md` runs as written on your machine
- [ ] You compared README and `/init` against the code, and the memory file follows the code
- [ ] The memory files are committed in your clone

## References

- Claude Code: Memory and CLAUDE.md: https://code.claude.com/docs/en/memory
- Claude Code: Commands (`/init`, `/memory`): https://code.claude.com/docs/en/commands
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- AGENTS.md convention (related idea): https://agents.md
