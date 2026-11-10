<details>
<summary>💡 Hint 1: /mcp does not show the server or shows "failed"</summary>

Did you start a new session after registering? Is the API running on port 4730? Ask Claude: "Start the server from .mcp.json once yourself and tell me what it prints." A server that writes anything to stdout (for example a `console.log`) disturbs the connection; logs belong on stderr (`console.error`).

</details>

<details>
<summary>💡 Hint 2: Claude does not use the new tool</summary>

Start a new session after every change to the server. Then look at the name and description of the tool: does the description say which questions it is meant for? Ask Claude to word it more precisely.

</details>

<details>
<summary>💡 Hint 3: The answer is very long</summary>

Ask Claude to let a tool return only the fields the question needs. Every result ends up in your context.

</details>
