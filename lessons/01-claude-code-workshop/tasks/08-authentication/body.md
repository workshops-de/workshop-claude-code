## Overview

Add real authentication — registration, login, logout, sessions, and a route guard — and practise
the most important habit for security-sensitive work: **reviewing the agent's output yourself**.
You delegate the implementation, but you own the security properties of what ships.

## Prerequisites

- Recommended skills: `prisma-client-api`, `react-best-practices`
- No dedicated skill covers `jose`/`bcrypt` — rely on the linked docs below.

## Background

A custom-session approach (rather than a third-party provider) uses hashed passwords, a signed
token in an http-only cookie, and a guard enforcing authentication for the protected area.
Security-sensitive code is exactly where "you push it, you own it" matters most.

## Steps

1. Ask the agent — in planning mode first — to implement registration, login, and logout with
   hashed passwords, a signed session cookie, and a guard for the authenticated area.
2. **Review the diff line by line.** Confirm the cookie is http-only (secure in production) with a
   sensible same-site setting, the signing secret comes from the environment, and passwords are
   never logged or returned to the client.
3. Verify the guard actually blocks every protected page when logged out, redirecting to sign-in.
4. Ask the agent to **explain its choices** for the token and cookie, then challenge at least one
   of them and adjust if warranted.
5. Test end to end: register, log out, log back in, and confirm protected pages redirect when
   signed out.
6. As a final pass, ask the agent to outline potential weaknesses in the implementation and triage
   what it finds.

## Success Criteria

- [ ] Register, login, and logout work end to end; the session persists across reloads
- [ ] The session cookie is httpOnly (secure in production) and the secret is env-sourced
- [ ] The guard redirects every protected page to sign-in when signed out
- [ ] Passwords are stored only as hashes and never logged or returned to the client
- [ ] `tsc --noEmit` and `npm run build` both pass

## Pitfalls (current framework)

- `cookies()` / `headers()` from `next/headers` are **async** on recent Next.js — `await` them.
- The signing secret must come from an env var; document it since `.env` is usually gitignored.
- A `redirect()` inside a Server Action works by **throwing** — don't swallow it in `try/catch`.
- A native database driver may need to be marked as a server-external package for the build.

## References

- Next.js — Authentication guide: https://nextjs.org/docs/app/building-your-application/authentication
- jose — JWT signing/verification: https://github.com/panva/jose
- bcrypt.js — password hashing: https://github.com/dcodeIO/bcrypt.js
- OWASP — Authentication cheat sheet: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
