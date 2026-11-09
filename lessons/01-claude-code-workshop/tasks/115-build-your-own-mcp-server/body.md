## Overview

In the previous task you connected a ready-made MCP server. Now you **build one**: a small server
that gives Claude a few sharp tools for the BookMonkey catalogue instead of raw HTTP. You register
it for the whole team, ask a question that needs several tools in a row, and compare what that
costs with doing the same by `curl`.

## The Feature

An MCP server is a small program that tells Claude which **tools** it offers (name, description,
input schema) and runs them when Claude calls. Servers can also offer **resources** (data you can
`@`-mention) and **prompts** (they appear as slash commands). The **MCP Inspector**
(`npx @modelcontextprotocol/inspector <command>`) lets you call a server's tools in the browser
before Claude ever sees them. The official TypeScript SDK does the protocol work:

```bash
npm install @modelcontextprotocol/sdk zod
```

```js
// tools/bookmonkey-mcp/index.js  (ES module: "type": "module" in its package.json)
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { z } from 'zod';

const server = new McpServer({ name: 'bookmonkey', version: '1.0.0' });

server.registerTool(
  'search_books',
  {
    description: 'Search the BookMonkey catalogue. Returns ISBN, title, author and price.',
    inputSchema: { query: z.string().min(1) },
    annotations: { readOnlyHint: true },
  },
  async ({ query }) => {
    const res = await fetch(`http://localhost:4730/books?q=${encodeURIComponent(query)}`);
    const books = await res.json();
    const rows = books.map(({ isbn, title, author, price }) => ({ isbn, title, author, price }));
    return { content: [{ type: 'text', text: JSON.stringify(rows) }] };
  },
);

await server.connect(new StdioServerTransport());
```

- **Transport.** A **stdio** server is started by Claude Code as a child process and talks over
  stdin/stdout. Never write logs to stdout; use `console.error`. A **Streamable HTTP** server runs
  on its own and Claude Code connects to a URL (see the bonus).
- **Register it** for the whole team with project scope. The `--` separates Claude's options from
  the command that starts the server:

  ```bash
  claude mcp add --scope project bookmonkey -- node tools/bookmonkey-mcp/index.js
  ```

  This writes `.mcp.json` at the project root. Commit it; teammates approve the server on first
  use. `claude mcp list`, `claude mcp get bookmonkey`, and `/mcp` show its status and tools.
- **Descriptions are prompts.** Claude picks tools by their name and description. A precise
  description ("Given any ISBN in a series, returns the whole series in order") is the difference
  between one call and ten.
- **Write tools need an ask rule.** In Manual mode Claude Code asks before an MCP tool call unless
  you allow it, for example with an allow rule `mcp__bookmonkey__search_books`. In auto mode a call
  without a rule can run with no prompt (it did in our test), so add an ask rule for write tools.
  `readOnlyHint` tells Claude Code a tool changes nothing, so it can run those calls in parallel.
- **Results cost context.** Tool definitions are deferred by tool search, but every result lands
  in the conversation. Return only the fields Claude needs.

## Apply it to BookMonkey

> **Repo / ports:** your `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!`

The practice ground is your **BookMonkey** repository and the `bookmonkey-api` it talks to
(`npx bookmonkey-api` on port 4730). You build `tools/bookmonkey-mcp` with four tools:

| Tool | Kind | What it does |
| ---- | ---- | ------------ |
| `search_books` | read | full-text search, returns ISBN, title, author, price |
| `get_series` | read | given any ISBN of a series, walks the series links and returns all volumes in order, with the total price |
| `catalogue_stats` | read | number of books, publishers, price range, and the first volume of each series |
| `create_book` | write | creates a book through the API |

Then you ask Claude a question that no single tool answers.

## Prerequisites

- Your BookMonkey repository from the earlier tasks, and `npx bookmonkey-api` running on
  `http://localhost:4730`
- Node.js 26 (as for the rest of BookMonkey). JavaScript is fine; for TypeScript, Node 26 runs
  `.ts` files with erasable syntax directly.
- **On Windows:** the shell snippets are Bash. Run them in Git Bash (comes with Git for Windows),
  or adapt them for PowerShell: run the commands of step 1 one by one instead of chaining them
  with `&&` (`mkdir` creates the nested folder without `-p`), and call `curl.exe` instead of
  `curl`, which is an alias for `Invoke-WebRequest` in Windows PowerShell

## Steps

1. Set up the package: `mkdir -p tools/bookmonkey-mcp && cd tools/bookmonkey-mcp && npm init -y
   && npm pkg set type=module && npm install @modelcontextprotocol/sdk zod`.
2. In plan mode, ask Claude to build the server with the four tools from the table, against the
   API's OpenAPI document (`http://localhost:4730/api-json`). Review the **tool descriptions and
   input schemas** in the plan as carefully as the code: they are what Claude will see.
3. Back in the repository root (`cd ../..`), try the server before you register it, with the MCP
   Inspector:
   `npx @modelcontextprotocol/inspector node tools/bookmonkey-mcp/index.js`. Call each read tool
   once in the browser UI.
4. Register it from the repository root with
   `claude mcp add --scope project bookmonkey -- node tools/bookmonkey-mcp/index.js`. Start a new
   session, approve the project server, and check `/mcp`: four tools, connected.
5. Ask: **"Which series has the most volumes, and what does the whole series cost?"** Open the
   transcript viewer (`Ctrl+O`) and follow how Claude chains the tools. How many calls did it
   need? Did it guess anything?
6. Improve one tool description or result shape so the same question needs fewer calls or less
   output, start a new session, and ask again.
7. In `/permissions`, add an ask rule `mcp__bookmonkey__create_book`. Ask Claude to **create a
   book** through `create_book` (a test ISBN such as `9990000000002`). Watch the permission prompt,
   then allow the three read tools in `/permissions`. Clean up afterwards: `curl -X POST http://localhost:4730/dev/reset`.
8. **Compare with `curl`.** In a fresh session, without the MCP server (`/mcp` lets you disable
   it), ask the same question and let Claude use `curl` only. Compare the number of steps, the
   correctness of the answer, and `/context` after both runs.
9. Commit `tools/bookmonkey-mcp/` (without `node_modules`) and `.mcp.json`.

## Success Criteria

**Feature**

- [ ] A stdio MCP server with three read tools and one write tool runs from `tools/bookmonkey-mcp`
- [ ] It is registered with `--scope project`; `.mcp.json` is committed and `/mcp` shows it connected
- [ ] Claude answered the series question by chaining your tools, and you followed the calls
- [ ] The write tool has an ask rule and asks before it runs; the read tools are allowed
- [ ] You can explain the difference in steps and context cost between your tools and `curl`

**App still works**

- [ ] `npm run build` of your BookMonkey app still passes with the new folder in the repository
- [ ] The test book is gone again after `POST /dev/reset`

## References

- Claude Code: MCP: https://code.claude.com/docs/en/mcp
- Claude Code: Permissions (MCP tool rules): https://code.claude.com/docs/en/permissions
- MCP: Build a server: https://modelcontextprotocol.io/docs/develop/build-server
- MCP TypeScript SDK: https://github.com/modelcontextprotocol/typescript-sdk
- MCP Inspector: https://modelcontextprotocol.io/docs/tools/inspector
