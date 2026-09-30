## Overview

Connect Claude Code to a real browser through the **Model Context Protocol (MCP)** and let the
agent verify what it built by looking at it — clicking, reading, and reporting back. Some things
can't be verified by reading code, and an interactive map is one of them.

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

## Apply it to Clash

The practice ground is an **interactive map** (Leaflet + OpenStreetMap tiles) with distinct
markers for your two main entity types and a location picker for create/edit. Leaflet touches the
browser's `window` and DOM, so the map must be a **client-only** component loaded dynamically
without server rendering. State that constraint up front — then let the agent prove the result in
a real browser rather than trusting that it compiles.

## Steps

1. Add a browser-automation MCP server (e.g. Playwright), start a session, and confirm with `/mcp`
   that it's connected and its tools are listed.
2. Tell the agent the **constraint** first — client-only, dynamic import, no SSR — and ask it to
   plan the map within it.
3. Implement the map with distinct markers and popups linking to detail pages, plus a **location
   picker** that captures coordinates when creating or editing.
4. Start the dev server and ask the agent to **verify through the browser tools**: sign in with a
   seeded account, open the map, confirm markers render, follow a popup link, pick a location on a
   form, and report what it saw.
5. Fix whatever the browser check found, then run the check again.
6. Find one verification where a CLI command beats the browser (e.g. "does the page return 200?")
   and explain why it's the leaner choice.

## Success Criteria

**Feature**

- [ ] An MCP server is connected and its tools show up in `/mcp`
- [ ] The agent used it to verify the running map and reported concrete observations
- [ ] You know which scope you used and when you'd pick `--scope project` instead
- [ ] You named at least one check that's better done with a CLI tool than via MCP

**App still works**

- [ ] The map renders distinct markers per entity type; popups link to detail pages
- [ ] The location picker stores the right coordinates on create/edit
- [ ] The map loads client-only (dynamic import, no SSR); `npm run build` passes

## References

- Claude Code — MCP: https://code.claude.com/docs/en/mcp
- Claude Code — MCP quickstart: https://code.claude.com/docs/en/mcp-quickstart
- Playwright MCP server: https://github.com/microsoft/playwright-mcp
- React Leaflet — Getting started: https://react-leaflet.js.org/docs/start-introduction/
- Next.js — Lazy loading / dynamic import: https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading
