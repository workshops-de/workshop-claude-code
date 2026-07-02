<details>
<summary>💡 Hint 1: Still being asked to log in?</summary>

Check for a leftover personal login session — it can take priority over the environment variable.
Sign out of any personal account first, or check the docs for the exact precedence order.

</details>

<details>
<summary>💡 Hint 2: Variable not set in a new terminal</summary>

If `echo $ANTHROPIC_API_KEY` is empty in a fresh terminal, the `export` line didn't make it into
your shell's profile file, or you edited the wrong one (check which shell you're running with
`echo $SHELL`).

</details>

<details>
<summary>💡 Hint 3: Never commit the key</summary>

Keep the key out of any file you might commit to git — environment variables in your shell
profile, never hard-coded in project files.

</details>
