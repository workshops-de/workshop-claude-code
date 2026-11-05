<details>
<summary>💡 Hint 1: The description decides delegation</summary>

Claude picks subagents by their `description`. Say _when_ to use it ("after changes to
authentication code"), not just what it is.

</details>

<details>
<summary>💡 Hint 2: Ask for exactly what you need back</summary>

The value of delegation is the small, clean answer. Tell the subagent the format you want —
e.g. findings by severity with file and line, and whether the fix belongs in the frontend or the
backend.

</details>

<details>
<summary>💡 Hint 3: A finding is a claim, not a verdict</summary>

Check each finding against the code and against the running API. "The guard can be bypassed" is
only a real finding if you can show what an attacker gets — try it.

</details>
