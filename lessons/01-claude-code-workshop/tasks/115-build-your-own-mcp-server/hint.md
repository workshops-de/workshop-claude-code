<details>
<summary>💡 Hint 1: The server starts but /mcp says failed</summary>

Run the exact command from `.mcp.json` yourself in the repository root. A stdio server that
prints anything to stdout (a `console.log` at startup) breaks the protocol; log to stderr with
`console.error`. Also check that the API on port 4730 is running.

</details>

<details>
<summary>💡 Hint 2: Claude calls the same tool again and again</summary>

Look at the tool descriptions and results, not at Claude. Does a description say what the tool
returns? Does `get_series` really return the whole series, or only the next volume? A tool that
answers a whole question saves many calls.

</details>

<details>
<summary>💡 Hint 3: Results that are too big</summary>

If a tool returns full book objects with long abstracts, every call fills your context. Return
only the fields the question needs, and let Claude ask for details with a second tool if it must.

</details>

<details>
<summary>💡 Hint 4: The app build complains about the new folder</summary>

If your Next.js type check or lint picks up `tools/bookmonkey-mcp`, exclude the folder in
`tsconfig.json` (`"exclude"`) and in your ESLint config. The server is its own package with its own
`package.json`.

</details>
