<details>
<summary>💡 Hint 1: Start read-only</summary>

Set `tools: ['Read', 'Glob', 'Grep']` before you add write or Bash tools. A write task then creates
no file.

</details>

<details>
<summary>💡 Hint 2: Scope your configuration</summary>

The SDK reads your `.claude/` configuration by default. Scope `settingSources` for a clean,
reproducible agent.

</details>

<details>
<summary>💡 Hint 3: Authenticate correctly</summary>

On an error like `Not logged in`, sign in to Claude Code first. For products that others use, the
docs call for an API key (or Bedrock/Vertex/Foundry credentials).

</details>
