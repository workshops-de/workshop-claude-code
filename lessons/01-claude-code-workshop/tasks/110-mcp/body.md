## Overview

Connect Claude Code to a real browser through the **Model Context Protocol (MCP)** and let the
agent verify what it built by looking at it — clicking, reading, and reporting back. Some things
can't be verified by reading code: whether a cover actually shows, whether paging feels right on a
phone, whether a series link lands on the right book.

## The Feature

MCP is an open standard for connecting agents to external tools and data: a browser, a database,
an issue tracker, or your own tooling.

- **Add a server** — local (stdio) servers run a command after `--`; remote servers take a URL:

  ```bash
  claude mcp add playwright -- npx -y @playwright/mcp@latest
  claude mcp add --transport http notion https://mcp.notion.com/mcp
  ```

- **Scopes** — the default is local (just you, this project). `--scope project` writes the server
  to `.mcp.json` at the project root so your team gets it via git; `--scope user` makes it
  available in all your projects.
- **Check status** — `claude mcp list` shows health per server; `/mcp` inside a session shows
  connected servers, their tools, and handles sign-in.
- **Context cost** — tool search (on by default) defers tool definitions until needed, but tool
  **results** still land in your context. A full browser snapshot is big; a `curl` status check
  is tiny.

## Apply it to BookMonkey

The practice ground is the **catalogue experience** you've built so far — covers, search, paging,
series navigation, sign-in, and the create/edit forms — plus one small client-only addition: a
**cover fallback**. Some covers may fail to load (a missing file, a host your app doesn't allow, a
book created without one); the card should then show a placeholder instead of a broken image.
Image `onError` handling runs only in the browser, so it lives in a client component — state that
constraint up front, then let the agent prove the result in a real browser rather than trusting
that it compiles.

## Steps

1. Add a browser-automation MCP server (e.g. Playwright), start a session, and confirm with `/mcp`
   that it's connected and its tools are listed.
2. Tell the agent the **constraint** first — the fallback is a small client component, the rest of
   the card stays server-rendered — and let it implement the cover fallback. Create one book with a
   bogus cover URL to have a test case.
3. Start the dev server and ask the agent to **walk a user journey through the browser tools**:
   search for "harry", go to page 2 and back, open a book, follow the series links forward and
   back, sign in as the demo user, try to create a book with an existing ISBN, and find your
   bogus-cover book. Ask it to report concrete observations, not a verdict.
4. Repeat the catalogue part at a **phone-sized viewport** (e.g. 390 × 844) and have it report
   layout problems.
5. Fix whatever the browser check found, then run the check again.
6. Find one verification where a CLI command beats the browser (e.g. "does `/books?q=harry` return
   200?" or "how many books does the API have?") and explain why it's the leaner choice.

## Success Criteria

**Feature**

- [ ] An MCP server is connected and its tools show up in `/mcp`
- [ ] The agent used it to walk the user journey and reported concrete observations
- [ ] You know which scope you used and when you'd pick `--scope project` instead
- [ ] You named at least one check that's better done with a CLI tool than via MCP

**App still works**

- [ ] Books without a loadable cover show a placeholder, not a broken image
- [ ] Search, paging, and series navigation behave as the agent reported, on desktop and phone width
- [ ] Only the fallback is a client component; `npm run build` passes

## References

- Claude Code — MCP: https://code.claude.com/docs/en/mcp
- Claude Code — MCP quickstart: https://code.claude.com/docs/en/mcp-quickstart
- Playwright MCP server: https://github.com/microsoft/playwright-mcp
- Next.js — Server and Client Components: https://nextjs.org/docs/app/getting-started/server-and-client-components
