<details>
<summary>💡 Hint 1: The description decides delegation</summary>

Claude picks subagents by their `description`. Say _when_ to use it ("after changes to
authentication code"), not just what it is.

</details>

<details>
<summary>💡 Hint 2: Ask for exactly what you need back</summary>

The value of delegation is the small, clean answer. Tell the subagent the format you want —
e.g. findings by severity with file and line.

</details>

<details>
<summary>💡 Hint 3: A finding is a claim, not a verdict</summary>

Check each finding against the code. Cookie flags and secret handling deserve your review time
most; if something sensitive is hard-coded, that's a real one.

</details>
