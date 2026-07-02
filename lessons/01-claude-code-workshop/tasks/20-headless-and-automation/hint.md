<details>
<summary>💡 Hint 1: No human means no prompts</summary>

Always pass `--allowedTools` or a suitable `--permission-mode`, or the run aborts when it hits an
action it can't auto-approve.

</details>

<details>
<summary>💡 Hint 2: Pipe instead of granting Bash</summary>

Piping the diff avoids granting Bash permission just to read it.

</details>

<details>
<summary>💡 Hint 3: JSON output tracks cost too</summary>

`--output-format json` includes `total_cost_usd`, so scripts can track spend per invocation.

</details>
