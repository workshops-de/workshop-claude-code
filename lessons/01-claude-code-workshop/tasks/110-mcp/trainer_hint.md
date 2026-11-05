## Learning goals

- **Feature:** `claude mcp add` (stdio vs. remote), scopes and `.mcp.json`, `/mcp` and
  `claude mcp list`, context cost of tool results.
- **Concepts:** closing the loop on a running system; choosing the leanest verification tool.
- **Practice ground:** a browser-verified BookMonkey user journey plus a small client-only cover
  fallback in a server-first app.
- **Takeaways:** state hard constraints up front; let the agent see what it built; connect what
  you need, not everything.

## Facilitation notes

- A vivid demo: let the agent verify the journey by code-reading only, then via the browser — the
  browser run usually catches something (a series link using `id`, a page that loses the search
  term, a card grid that overflows on phone width).
- Network/firewall issues can block MCP server installs in some environments — have a fallback
  recording ready.
- Watch the context meter during the journey: full snapshots are expensive. Good moment to show
  `/context` and discuss when a `curl` would have done.
- The bogus-cover book persists in the shared API; `POST /dev/reset` cleans up.

## Time estimate

~45 minutes.
