## Overview

Use **subagents** to hand focused work to a separate context: first a built-in one for noisy
exploration, then your own **security reviewer** with restricted tools. You delegate the digging,
you keep a lean main session — and you still own every finding you act on.

## The Feature

A subagent runs with its **own context window**, its own system prompt, and optionally a
restricted set of tools. The main session hands it a task; it works elsewhere and returns only a
summary. Its intermediate reading doesn't pollute your context.

- **Built-in subagents** — e.g. **Explore**, which Claude uses for read-only codebase research.
- **Custom subagents** — Markdown files in `.claude/agents/` (project, commit them) or
  `~/.claude/agents/` (personal). Ask Claude to create one, or write the file yourself:

  ```markdown
  ---
  name: security-reviewer
  description: Reviews auth, session, and secret handling for security issues. Use proactively after changes to authentication code.
  tools: Read, Grep, Glob
  model: inherit
  ---

  You are a security reviewer. Report findings by severity with file and line.
  Never edit files.
  ```

- **Invocation** — Claude delegates automatically based on the `description`; to force a specific
  one, @-mention it (`@agent-security-reviewer`), or run a whole session as it with
  `claude --agent security-reviewer`.
- **Tool restriction** — `tools` is an allowlist, `disallowedTools` a denylist. A reviewer that
  can't write can't "helpfully" fix things behind your back.

## Apply it to BookMonkey

The practice ground is **sign-in** for BookMonkey. The `bookmonkey-api` already offers
`POST /register` and `POST /login`, both returning `{ accessToken, user }` — your job is the
frontend side: forms, storing the token safely, sign-out, and a guard for the authenticated area.
There is a catch worth finding: **the API does not check the token on any endpoint**. Your guard
protects pages, not data. That is exactly the kind of gap an independent reviewer should surface —
and it is the reason you'll build your own backend later.

## Prerequisites

- The `bookmonkey-api` is running; demo user `admin@bookmonkey.api` / `password1!`.
- Recommended skill: `react-best-practices`.

## Steps

1. Ask Claude (plan first) to implement sign-up, sign-in, and sign-out against the API: the token
   ends up in a signed or encrypted **http-only cookie** set on the server (not in `localStorage`),
   and one guard redirects the authenticated area to sign-in. Test it end to end in the browser.
2. **Explore with a subagent**: ask a research question about your auth flow ("trace a request to
   a protected page — where is the token checked, and by whom?") and have it delegated to Explore.
   Run `/context` before and after and note that the main context stayed lean.
3. Create the **`security-reviewer`** subagent in `.claude/agents/` with read-only tools.
4. Invoke it explicitly with `@agent-security-reviewer` on your auth code, and ask it to include
   the API's behaviour in its review (`curl -X DELETE http://localhost:4730/books/<isbn>` without a
   token is a fair test).
5. **Triage** the findings yourself: fix what's real in your code, record what only the backend can
   fix (in `docs/backlog.md` or similar), and reject what isn't a problem — with a reason for at
   least one of each. Re-run the reviewer after your fixes.
6. Restore the seed if you deleted a book: `curl -X POST http://localhost:4730/dev/reset`.

## Success Criteria

**Feature**

- [ ] You delegated a research question to a subagent and saw the main context stay lean
- [ ] A custom `security-reviewer` exists in `.claude/agents/` with a restricted `tools` list
- [ ] You invoked it explicitly and triaged its findings (at least one fixed, one rejected with a
      reason)

**App still works**

- [ ] Sign-up, sign-in, and sign-out work end to end; the session persists across reloads
- [ ] The token lives in an http-only cookie (secure in production), never in `localStorage`
- [ ] The guard redirects every page of the authenticated area to sign-in
- [ ] The unenforced token on the API side is documented as a known backend gap
- [ ] Type-check and `npm run build` pass

## Pitfalls (current framework)

- `cookies()` / `headers()` from `next/headers` are **async** on recent Next.js — `await` them.
- A `redirect()` inside a Server Action works by **throwing** — don't swallow it in `try/catch`.
- Setting a cookie works in Server Actions and Route Handlers, not in Server Components.

## References

- Claude Code — Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code — Invoke subagents explicitly: https://code.claude.com/docs/en/sub-agents#invoke-subagents-explicitly
- BookMonkey API — Auth: https://github.com/workshops-de/bookmonkey-api#auth
- Next.js — Authentication guide: https://nextjs.org/docs/app/building-your-application/authentication
- OWASP — Session management cheat sheet: https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html
