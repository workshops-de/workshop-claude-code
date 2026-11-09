<details>
<summary>💡 Hint 1: Where to start</summary>

Start sensitive or unfamiliar work in Manual (`default`) or `plan`; loosen only once you trust the
direction the agent is taking.

</details>

<details>
<summary>💡 Hint 2: Boundaries can be lost</summary>

In auto mode the classifier re-reads a boundary you state from the transcript; in Manual only the
model follows it. Either way it can be lost if context is compacted. For a hard guarantee, add a
deny rule instead of relying on conversation alone.

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
