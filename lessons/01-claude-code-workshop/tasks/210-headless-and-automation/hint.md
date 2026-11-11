<details>
<summary>💡 Hint 1: No human means no prompts</summary>

In scripts, pass `--allowedTools` or a suitable `--permission-mode`. Otherwise anything that needs
approval is refused.

</details>

<details>
<summary>💡 Hint 2: Pipe instead of granting Bash</summary>

Piping the diff avoids granting Bash permission just to read it.

</details>

<details>
<summary>💡 Hint 3: No result in the script?</summary>

Print the full JSON answer once without `jq`. The result that follows the schema is in the `structured_output` field.

</details>
