<details>
<summary>💡 Hint 1: Labelled, but nothing happens</summary>

Check the **Actions** tab of your fork. No run at all usually means workflows are still disabled
in the fork, or the label name does not match the `if:` condition exactly. A run that fails
early usually means the secret is missing or the Claude GitHub App is not installed on the fork.

</details>

<details>
<summary>💡 Hint 2: The issue or the PR lands in the wrong repository</summary>

With two remotes, `gh` may pick the original repository. Pass `--repo $FORK` to every `gh`
command, or run `gh repo set-default` once and choose your fork.

</details>

<details>
<summary>💡 Hint 3: Tighter is better in CI</summary>

Nobody approves tool calls on a runner. Whatever `--allowedTools` permits, Claude may do. Ask
yourself for each tool in the list: does the `analyse` mode need it?

</details>

<details>
<summary>💡 Hint 4: The comment sounds confident</summary>

Treat it like a first review from a new colleague. Open the files it names. A wrong line range
or a cause without evidence is a signal to sharpen the prompt, not to trust it more.

</details>
