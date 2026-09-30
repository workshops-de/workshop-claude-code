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

## Apply it to Clash

The practice ground is **authentication** for your app: registration, login, logout, a signed
session cookie, and a guard for the authenticated area — a custom-session approach with hashed
passwords rather than a third-party provider. Security-sensitive code is exactly where "you push
it, you own it" matters most, so a second, independent pair of eyes is worth its setup.

## Prerequisites

- Recommended skills: `prisma-client-api`, `react-best-practices`
- No dedicated skill covers `jose`/`bcrypt` — rely on the linked docs below.

## Steps

1. Ask Claude (plan first) to implement registration, login, and logout with hashed passwords, a
   signed http-only session cookie, an env-sourced secret, and one guard for the authenticated
   area. Test it end to end in the browser.
2. **Explore with a subagent**: ask a research question about your auth flow ("trace a request to
   a protected page — where is the session checked?") and have it delegated to Explore. Run
   `/context` before and after and note that the main context stayed lean.
3. Create the **`security-reviewer`** subagent in `.claude/agents/` with read-only tools.
4. Invoke it explicitly with `@agent-security-reviewer` on your auth code.
5. **Triage** the findings yourself: fix what's real, discard what isn't, and explain why for at
   least one of each. Re-run the reviewer after your fixes.
6. Reflect: which kinds of work are worth delegating, and which are simpler inline?

## Success Criteria

**Feature**

- [ ] You delegated a research question to a subagent and saw the main context stay lean
- [ ] A custom `security-reviewer` exists in `.claude/agents/` with a restricted `tools` list
- [ ] You invoked it explicitly and triaged its findings (at least one fixed, one rejected with a
      reason)

**App still works**

- [ ] Register, login, and logout work end to end; the session persists across reloads
- [ ] The cookie is httpOnly (secure in production) and the secret is env-sourced
- [ ] The guard redirects every protected page to sign-in; passwords are only stored as hashes
- [ ] `tsc --noEmit` and `npm run build` both pass

## Pitfalls (current framework)

- `cookies()` / `headers()` from `next/headers` are **async** on recent Next.js — `await` them.
- A `redirect()` inside a Server Action works by **throwing** — don't swallow it in `try/catch`.
- A native database driver may need to be marked as a server-external package for the build.

## References

- Claude Code — Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code — Invoke subagents explicitly: https://code.claude.com/docs/en/sub-agents#invoke-subagents-explicitly
- Next.js — Authentication guide: https://nextjs.org/docs/app/building-your-application/authentication
- jose — JWT signing/verification: https://github.com/panva/jose
- OWASP — Authentication cheat sheet: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
