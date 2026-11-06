## Overview

Use Claude Code as a debugging partner on a bug report from real users. You feed it evidence, not
guesses, let it trace the problem through the Reason → Act → Observe loop, and do not accept a fix
until you know the **root cause**, why it hides, and when it came in. Good debugging with an agent
is mostly about supplying good context and refusing the first plausible patch.

## The Feature

Claude debugs well when it can _observe_: run a reproduction, read logs, inspect state, and dig
through history. Your job is to set up that loop and keep it honest.

- **Evidence in.** Paste the ticket, the exact steps, what you expected, and what you saw. Let
  Claude reproduce it before it reads much code: a failing `curl` or test beats a theory.
- **Hypotheses out.** Ask for two or three competing hypotheses and a cheap test for each. Make
  Claude say which observation would rule each one out.
- **History is evidence.** `git log -- <path>`, `git log -S '<text>'`, `git blame -L`, and
  `git show <sha>` tell you when behaviour changed and why someone changed it. Claude can run all
  of them for you.
- **Root cause, not symptom.** A fix in the one place the ticket names is often the smallest
  diff and the wrong one. Ask: which other paths go through the same code?
- **Prove it.** A regression test that fails before the fix and passes after it.

## Apply it to BookMonkey Legacy

The practice ground is your [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)
clone. This ticket arrived from the library team. It is all you get:

> **Ticket #412: "Next volume" leads nowhere**
>
> Since a while the "next volume" link in The Lord of the Rings leads nowhere. Other series work
> until someone saves a book in the admin.

## Prerequisites

- The `bookmonkey-legacy` clone with `npm install` and a fresh `npm run db:reset`
- API (`npm run dev:api`) and web app (`npm run dev:web`) running in two terminals
- Admin login from the README's test logins table
- Optional: the `legacy-ops` MCP server from the bonus of "MCP: Build Your Own MCP Server"

## Steps

1. **Reproduce the first sentence.** Open "The Fellowship of the Ring", the first volume of The
   Lord of the Rings, in the web app and follow the series links forward and back. Then reproduce it without the browser: let Claude find the API calls behind the
   page and run them with `curl`. Write down the exact request that fails.
2. **Reproduce the second sentence.** Pick a series that works, save one of its books in the admin
   without changing anything meaningful, and check the series again. Capture exactly what you
   see before and after.
3. **Hand over the evidence.** Give Claude the ticket and your two reproductions and ask for
   competing hypotheses plus one cheap check for each, in plan mode, before it touches code.
4. **Narrow it down.** Let Claude run the checks. Every time it states a cause, ask "which
   observation proves that?".
5. **Dig through history.** Ask Claude to find the commit that introduced the behaviour and to
   explain, from the commit and its message, what the author wanted.
6. **Name the root cause** in one or two sentences, with file, line, and commit. Then list every
   code path that the same cause affects, not only the one in the ticket.
7. **Fix with a regression test.** Write the test first (in `api/test/`, run with `npm test`) and
   watch it fail, then fix, watch it pass, and run the full suite. Check the ticket's two
   reproductions again by hand.
8. Try a **rubber-duck** prompt at least once: describe what you did, what you expected, and
   what you observed, and let Claude ask the questions.

## Success Criteria

**Feature**

- [ ] Both sentences of the ticket were reproduced, once in the browser and once with `curl` or a
      test
- [ ] Claude worked from evidence: hypotheses were tested, not guessed
- [ ] You found the commit that introduced the behaviour and can explain the author's intent
- [ ] You can state the root cause and every path it affects, not only the symptom

**App still works**

- [ ] A regression test fails without your fix and passes with it; `npm test` is green
- [ ] The Lord of the Rings series navigates forward and back, and saving a book in the admin
      no longer breaks any series
- [ ] You know whether data that was stored before your fix is affected, and you handled it

## References

- Claude Code: Common workflows (fix bugs): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- Claude Code: Permission modes (plan mode): https://code.claude.com/docs/en/permission-modes
- Git: `git log -S` (pickaxe): https://git-scm.com/docs/git-log#Documentation/git-log.txt--Sltstringgt
- Git: `git blame`: https://git-scm.com/docs/git-blame
