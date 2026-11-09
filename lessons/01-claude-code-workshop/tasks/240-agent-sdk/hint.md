<details>
<summary>💡 Hint 1: Start read-only</summary>

Set `tools: ['Read', 'Glob', 'Grep']` before you add write or Bash tools. A write task then creates
no file.

</details>

<details>
<summary>💡 Hint 2: Scope your configuration</summary>

The SDK reads your `.claude/` configuration by default — scope `settingSources` for a clean,
reproducible agent.

</details>

<details>
<summary>💡 Hint 3: Authenticate correctly</summary>

Use an API key (or Bedrock/Vertex/Foundry credentials) — claude.ai login is not for third-party
SDK products.

</details>
