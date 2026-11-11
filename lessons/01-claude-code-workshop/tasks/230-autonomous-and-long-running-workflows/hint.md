<details>
<summary>💡 Hint 1: Isolation makes mistakes cheap</summary>

Longer autonomous runs amplify both good and bad decisions, a worktree makes a bad run cheap to
discard.

</details>

<details>
<summary>💡 Hint 2: The evaluator only sees the transcript</summary>

It doesn't run commands itself. "The backend is done" can't be judged; "`npm run contract` exits
0" can, because Claude runs it and the output lands in the conversation.
It also prevents nothing: for hard protection use a hook or a deny rule.

</details>

<details>
<summary>💡 Hint 3: A repeated block is a signal</summary>

If the auto-mode classifier blocks the same action repeatedly, that's a signal, not a failure ,
read why before you widen the permissions.

</details>

<details>
<summary>💡 Hint 4: What is not committed is missing in the worktree</summary>

A worktree starts at the last commit. If the new tests are missing there, you did not commit them in step 2. If your repository has a remote, the worktree in our test started at the state of `origin`, not at the local commit: push first.

</details>
