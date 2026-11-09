<details>
<summary>💡 Hint 1: Isolation makes mistakes cheap</summary>

Longer autonomous runs amplify both good and bad decisions — a worktree makes a bad run cheap to
discard.

</details>

<details>
<summary>💡 Hint 2: The evaluator only sees the transcript</summary>

It doesn't run commands itself. "The backend is done" can't be judged; "`npm run contract` exits
0" can — because Claude runs it and the output lands in the conversation.
It also prevents nothing: for hard protection use a hook or a deny rule.

</details>

<details>
<summary>💡 Hint 3: A repeated block is a signal</summary>

If the auto-mode classifier blocks the same action repeatedly, that's a signal, not a failure —
read why before you widen the permissions.

</details>
