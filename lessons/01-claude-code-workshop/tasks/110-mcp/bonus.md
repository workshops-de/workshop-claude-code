## Going further: more servers, governance and scale

- **A second server**: connect a database MCP server and have the agent inspect a table, or an
  issue tracker to read the task you're working on.
- **Share it with the team**: re-add your browser server with `--scope project` and commit
  `.mcp.json`; teammates approve project servers on first use.
- **Managed MCP**: organizations can restrict which servers users may add with allowlists and
  denylists.
- **MCP in the Agent SDK**: wire the same servers into programmatic agents.
- **Browser check on `bookmonkey-legacy`**: start its API (port 4780) and web app (port 5180),
  then let your browser server use the catalogue search and the pager, a few searches and a few
  pages in a row. Do the same again with a slow network (throttling, for example "Slow 4G" in
  the Chrome DevTools, or ask Claude to delay the API responses in the browser). Ask Claude to
  report **observations, not verdicts**: what it typed or clicked, what the page showed, in which
  order, and how long it took. Compare the fast and the slow run yourself.

Try sketching an allowlist policy for MCP servers in your own organization.
