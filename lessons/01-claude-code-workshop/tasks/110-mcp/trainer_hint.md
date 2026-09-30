## Learning goals

- **Feature:** `claude mcp add` (stdio vs. remote), scopes and `.mcp.json`, `/mcp` and
  `claude mcp list`, context cost of tool results.
- **Concepts:** closing the loop on a running system; choosing the leanest verification tool.
- **Practice ground:** a client-only Leaflet map with markers, popups, and a location picker in a
  server-first app.
- **Takeaways:** state hard constraints up front; let the agent see what it built; connect what
  you need, not everything.

## Facilitation notes

- A vivid demo: let the agent verify the map by code-reading only, then via the browser — the
  browser run usually catches something (missing marker icons, a popup link to the wrong route).
- Network/firewall issues can block MCP server installs in some environments — have a fallback
  recording ready.
- Leaflet's default marker icons often break under bundlers; if it shows up, it's a great example
  of a bug only the browser check finds.
- Note OpenStreetMap tile-usage etiquette if anyone asks about production use.

## Time estimate

~45 minutes.
