## Learning goals

- **Feature:** building an MCP server with the official SDK (tools with schemas, annotations,
  stdio transport), `claude mcp add --scope project`, `.mcp.json`, `/mcp`, MCP permission rules;
  in the bonus: resources, prompts, Streamable HTTP, and OAuth for remote servers.
- **Concepts:** tools as an interface designed for an agent; descriptions as prompts; result size
  as context cost; read vs. write tools and human approval.
- **Takeaways:** a few sharp tools beat raw HTTP for repeated questions; design tool results for
  the question, not for completeness; keep writes behind a prompt.

## Facilitation notes

- This task covers the agenda items "connect MCP servers, local and remote (OAuth)" together with
  the previous MCP task, and "build your own MCP server". The OAuth part is in the bonus; demo it
  live if most participants skip it.
- A 5-minute live start helps: show the skeleton from the body running in the MCP Inspector, then
  let participants extend it with Claude.
- The most common failure is a server that logs to stdout. The second is a relative path in
  `.mcp.json` while Claude Code was started in a subfolder; start it in the repository root.
- The series question needs several calls: find the series, walk each one, compare. Watch for
  participants who accept an answer without opening the transcript. Ask how many calls it took
  and whether the total price was computed or guessed.
- Good discussion for the `curl` comparison: `curl` needs no code and is fine for a one-off
  check; the MCP server pays off when the same kind of question comes back and when results must
  stay small.
- Reference servers for this task and its bonus (with smoke tests) are in the private trainer repo
  (`bookmonkey-legacy-trainer/mcp/`), with notes in `SOLUTIONS.md`. Do not publish them in this
  course repo; participants should build their own.
- Some corporate networks block `npx` downloads of the MCP Inspector. It is optional; `/mcp` and a
  first question in Claude Code are enough to test.

## Time estimate

~45 minutes: 5 demo, 20 build and inspect, 10 register and chain tools, 10 write tool and `curl`
comparison. The bonus needs another 30 to 45 minutes.
