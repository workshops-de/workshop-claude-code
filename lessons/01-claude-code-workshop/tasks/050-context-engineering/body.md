## Overview

Learn to treat the **context window as your most valuable, finite resource** and to manage it
deliberately. On a real legacy codebase you fill the window on purpose, watch what that does to
the answers, and then condense or reset it so the agent stays accurate on longer pieces of work.

## The Feature

A model's quality drops as its context fills with noise, contradictions, or sheer length. The
"lost in the middle" effect means information buried in a long context gets less attention, so
bigger context is not automatically better. Claude Code gives you the levers:

- **`/context`** shows the window as a coloured grid: system prompt, memory files, tools, and your
  conversation, plus suggestions when something is heavy.
- **`/compact [instructions]`** summarises the conversation so far and continues from the summary.
  Pass focus instructions, for example `/compact keep the list of routes and their files`.
- **`/clear`** starts a new conversation with an empty context. Use it for unrelated work.
- **`/btw <question>`** asks a side question without adding it to the conversation.
- **Delegate the reading.** A subagent (or the built-in Explore agent) reads in its own context and
  returns only the result. You meet subagents properly in a later task.

## Apply it to BookMonkey Legacy

> **Repo / ports:** your `bookmonkey-legacy` clone (Node.js 24 or newer), API on
> http://localhost:4780, web app on http://localhost:5180
>
> **Login:** admin `admin@bookmonkey.example` / `admin2021`

The practice ground is your [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)
clone. Legacy code is where context runs out first: one route file with more than a thousand
lines, a large seed file, a lockfile, five years of `git log -p`, and test and server logs that
nobody trims. Exactly the material that fills a window without anyone noticing.

## Prerequisites

- The `bookmonkey-legacy` clone with dependencies installed (`npm install`, `npm run db:reset`)

## Steps

1. Start a fresh session in Manual or plan mode (`claude --permission-mode default` or
   `claude --permission-mode plan`), so the repository stays clean, and run `/context`. Note the baseline: how much do system prompt, tools,
   and your `CLAUDE.md` take before you typed anything?
2. Ask one precise question you can check later, for example "Which file and function handle
   renewing a loan, and what are the renewal rules?". Write down the answer.
3. Now **pollute** the session on purpose, checking `/context` after each step:
   - ask Claude to read `api/routes.js` completely and summarise every section
   - ask it to read `api/seed/books.json` and `package-lock.json`
   - let it run `git log -p` over the whole history and the full `npm test` output. Claude Code
     may cut such a huge output short or write it to a file and read only parts of it: that is
     the tool protecting your context, not a failure
   - start `npm run dev:api`, click through a few pages of the web app (or run `npm test`), and
     paste a long stretch of the API log into the chat
4. Ask the question from step 2 again, plus one about a detail from the very first file it read.
   Note any drift, vagueness, or forgotten detail.
5. **Condense** with `/compact` and focus instructions of your choice. Ask both questions again and
   compare before and after. What did the summary keep, what did it drop?
6. Start a genuinely **new, unrelated task** (for example "explain the web app's routing") with
   `/clear` instead of continuing the polluted session. Compare `/context` with your baseline.
7. Redo the expensive reading the lean way: ask a subagent to "list every migration file and
   the tables it creates, one line each", and compare what lands in your main context.
8. Rewrite one earlier prompt so the key constraint sits at the very beginning (or end) and observe
   whether the result improves.

## Success Criteria

**Feature**

- [ ] You recorded a baseline with `/context` and watched it grow on the polluted session
- [ ] You compacted a session with focus instructions and continued from the smaller context
- [ ] You started a clean context for an unrelated task with `/clear`
- [ ] You can name at least two context failure modes you triggered, and the habit that fixed each

**Repository still clean**

- [ ] `git status` in `bookmonkey-legacy` shows no changes to tracked files

## References

- Claude Code: Commands (`/context`, `/compact`, `/clear`, `/btw`): https://code.claude.com/docs/en/commands
- Claude Code: Costs and context usage: https://code.claude.com/docs/en/costs
- Claude Code: Best practices (manage context): https://code.claude.com/docs/en/best-practices
- Claude Code: Subagents: https://code.claude.com/docs/en/sub-agents
- "Lost in the Middle" (Liu et al., 2023): https://cs.stanford.edu/~nfliu/papers/lost-in-the-middle.arxiv2023.pdf
