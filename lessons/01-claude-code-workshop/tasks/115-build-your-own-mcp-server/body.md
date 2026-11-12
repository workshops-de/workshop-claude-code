> **⚠️ Must be running:** each in its own terminal. Start what is not running yet and keep it open for the whole task.
> - API: `npx bookmonkey-api` (http://localhost:4730)

---

In this task Claude builds your own **MCP server**: a small program that gives Claude a few ready-made tools (Tools) for the BookMonkey catalogue. You do not have to write any code yourself.

You work in your `bookmonkey` repository with Node.js 26.

### 1. Let Claude build the server

```text
Build a small MCP server in tools/bookmonkey-mcp that gives Claude access to the catalogue of the bookmonkey-api (http://localhost:4730). It should have two tools: search_books (search by title or author, returns ISBN, title, author and price) and get_series (follows the series links from an ISBN and returns all volumes in the right order with the total price). The entry point is tools/bookmonkey-mcp/server.mjs. Keep it small, use the official MCP SDK, and test both tools once against the running API.
```

Claude creates the folder, installs the SDK and tests the tools against the API.

### 2. Connect the server to Claude

```text
Register the server bookmonkey as an MCP server in the project scope, so the whole team gets it through .mcp.json.
```

The registration creates the file `.mcp.json` in the project folder, which says how the server is started. Because it lives in the repository, the team has the server after cloning. Then start a new session. Confirm the project server if Claude Code asks. Open the terminal in the desktop app, start `claude` there and enter `/mcp`: `bookmonkey` should be listed as connected.

### 3. Ask a question about the whole catalogue

```text
Which book series has the most volumes, and what does the whole series cost? Use the bookmonkey server for this.
```

In one of our runs Claude loaded the two tools but did not use them and queried the API directly, in another it used them to check only some of the series. `get_series` needs an ISBN, and no tool can tell which series exist at all. Check the output to see which tools Claude called in your run.

### 4. Give Claude the missing tool

Think about which tool would answer the question from step 3 with a single call, and write the prompt yourself. For example:

```text
Add a tool list_series to the bookmonkey server that returns all series of the catalogue, sorted by number of volumes, with the number of volumes and the total price. The description should say that it is meant for questions about all series. Test it once against the API.
```

### 5. Ask again

Start a new session so the server starts with the new tool, and ask the question from step 3 again, this time without the sentence "Use the bookmonkey server for this". In our run Claude called `list_series` once and then answered.

### 6. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

Claude picks a tool by its **name and description**. In our runs Claude either ignored the two tools or used them to check only some of the series, because neither knows all series. A tool that answers exactly the question replaces many single queries. So you build tools for the questions that keep coming back, and describe them so that Claude recognises when to use them.

**Done when** `/mcp` shows the server `bookmonkey` as connected, Claude answered the series question with `list_series`, and `.mcp.json` and `tools/bookmonkey-mcp/` are committed.

<details>
<summary>More</summary>

Team members run `npm install` once in `tools/bookmonkey-mcp` after cloning. `claude mcp add --scope project` in the terminal creates the same `.mcp.json`. The MCP Inspector (`npx @modelcontextprotocol/inspector node tools/bookmonkey-mcp/server.mjs`) lets you try the tools in the browser. The bonus covers resources, prompts and remote servers.

[MCP in Claude Code](https://code.claude.com/docs/en/mcp), [MCP: Build a server](https://modelcontextprotocol.io/docs/develop/build-server)

</details>
