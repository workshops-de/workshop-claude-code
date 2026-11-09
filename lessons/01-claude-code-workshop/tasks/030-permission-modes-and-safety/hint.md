<details>
<summary>💡 Hint 1: Where to start</summary>

Start sensitive or unfamiliar work in Manual (`default`) or `plan`; loosen only once you trust the
direction the agent is taking.

</details>

<details>
<summary>💡 Hint 2: Boundaries can be lost</summary>

In auto mode a second model (the classifier) checks each action. In Manual you decide at each
prompt. A boundary you state lives only in the conversation and nothing enforces it. For a hard
guarantee, add a deny rule.

</details>

<details>
<summary>💡 Hint 3: bypassPermissions</summary>

`bypassPermissions` belongs only in throwaway, isolated environments, never in a repository that
matters.

</details>

<details>
<summary>💡 Hint 4: A rule seems to do nothing</summary>

A deny rule beats an allow rule, in the same file or any other. Rules are not sorted by how
specific they are. `/permissions` shows which settings file each rule comes from.

</details>
