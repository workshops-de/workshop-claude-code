<details>
<summary>💡 Hint 1: The description gets the skill picked</summary>

Be specific about _when_ to use it and lead with the words your prompts actually contain
("adding a feature", "new field", "server action").

</details>

<details>
<summary>💡 Hint 2: Test in a clean context</summary>

In the session where you wrote the skill, the agent already knows the pattern. Only a fresh
session proves the skill — not your conversation — did the work.

</details>

<details>
<summary>💡 Hint 3: Who decides, you or the agent?</summary>

If the agent should decide _when_ to act, it's a skill. If you want to trigger it deliberately
(and pass an argument), it's a command — `disable-model-invocation: true`.

</details>

<details>
<summary>💡 Hint 4: Resist special-casing the second entity</summary>

The point is that the shape repeats. If the command needs lots of extra instructions for entity
two, improve the skill instead.

</details>
