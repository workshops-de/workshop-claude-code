## Overview

Connect Claude Code to an external system through the **Model Context Protocol (MCP)** and use it
to close the feedback loop on something the agent otherwise can't see — such as the running
application in a real browser. You will also weigh the trade-off: MCP extends reach, but tool
schemas cost context.

## Prerequisites

- Recommended: `agent-browser` (`npx skills add vercel-labs/agent-browser@agent-browser -y`)

## Background

MCP is an open standard for discovering and calling external tools and resources. A server can
expose a browser, a database, a project tracker, or your own custom tooling. This lets the agent
observe and act on systems beyond your files.

## Steps

1. Add an MCP server to your Claude Code configuration — a browser-automation server is a good
   choice — and confirm the agent can list its new tools.
2. Start your application's development server.
3. Ask the agent to use the MCP browser tools to **verify the running app**: open it, sign in with
   a seeded account, navigate to a list, and confirm content renders. Have it report what it saw.
4. Consider the **context cost**: identify a simple check where a command-line tool would be
   leaner than an MCP tool, and explain why.
5. Optionally connect a second server relevant to your stack (for example, a database server) and
   have the agent inspect a table.
6. Reflect on which external systems are worth exposing to the agent in your real work.

## Success Criteria

- [ ] An MCP server is connected and its tools are visible to the agent
- [ ] The agent used it to verify something real about the running app
- [ ] You identified at least one check better suited to a CLI tool than MCP

## References

- Claude Code — MCP: https://code.claude.com/docs/en/mcp
- Model Context Protocol — Introduction: https://modelcontextprotocol.io
- MCP — Example servers: https://modelcontextprotocol.io/examples
