<details>
<summary>💡 Hint 1: The run in step 2 or 3 asks or aborts</summary>

Start the command in the project folder of `bookmonkey-legacy`, in the terminal of the desktop app. On Windows use Git Bash. If a call needs approval and is missing from `--allowedTools`, Claude refuses it. That is intended.

</details>

<details>
<summary>💡 Hint 2: Tighter is better in CI</summary>

On a server nobody approves tool calls. Whatever `--allowedTools` names runs without asking. Ask yourself for each tool in the list: does the `analyse` mode need it?

</details>

<details>
<summary>💡 Hint 3: The answer sounds confident</summary>

Treat it like a first review from a new colleague. Open the files it names. A wrong line range or a cause without evidence is a signal to sharpen the prompt, not to trust it more.

</details>
