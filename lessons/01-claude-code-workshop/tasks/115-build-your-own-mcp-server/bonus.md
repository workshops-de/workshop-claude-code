## Going further: an ops server for the legacy app, remote over HTTP

Build a second server for [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy),
the kind a support or ops team would want while working on tickets. It gives Claude **read-only**
access to the app's SQLite database (`api/data/bookmonkey.db`, created by `npm run db:reset`).

1. **Tools**, all read-only:
   - `query` runs one SQL `SELECT` and returns at most a limited number of rows
   - `list_tables`, `recent_mails` (the newest rows of the outbox), `feature_flags`

   Make the guarantee structural, not a regex on the SQL: open the database read-only, for
   example `new DatabaseSync(file, { readOnly: true })` from `node:sqlite` (Node 24 or newer).
2. **A resource** with the database schema, so you can attach it to a prompt with `@`
   (`@legacy-ops:` shows what the server offers). Use `server.registerResource(...)`.
3. **A prompt** that turns a ticket text into an investigation plan, so it shows up as
   `/legacy-ops:investigate-ticket (MCP)` in the `/` menu. Use `server.registerPrompt(...)`.
4. **Run it remotely over Streamable HTTP** instead of stdio: start it as its own process (for
   example `node index.js --http 4790`, using `StreamableHTTPServerTransport` from the SDK) and
   connect Claude Code to its URL:

   ```bash
   claude mcp add --transport http legacy-ops http://localhost:4790/mcp
   ```

   Now the server could run on another machine, shared by a team. Think about what it would need
   before you expose it beyond `localhost`: authentication, a row limit, and which tables it may
   read at all.
5. Keep it connected for the debugging task, as one more tool you may use.

## Going further: a remote server with OAuth

Hosted MCP servers usually sign you in with OAuth. Add one you have an account for, for example:

```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

Then sign in with `/mcp` inside a session (or `claude mcp login <name>` in your shell). Claude
Code stores and refreshes the token; `claude mcp logout <name>` revokes it where the provider
supports that. Compare: who holds the credentials for your own HTTP server, and who for the hosted
one?

## Going further: always ask for a dangerous tool

For a tool whose approval is the whole point, set `_meta: { 'anthropic/requiresUserInteraction':
true }` on it. Claude Code then asks on every call, even in auto mode and with allow rules.
