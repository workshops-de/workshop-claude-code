<details>
<summary>💡 Hint 1: Keep hooks fast</summary>

They run on every edit. Format one file and type-check — don't run the full test suite on each
keystroke of the agent.

</details>

<details>
<summary>💡 Hint 2: Your guard doesn't block?</summary>

Check the exit code. Only `exit 2` blocks a `PreToolUse` call; `exit 1` just logs an error and lets
the action through.

The same goes for the type-check hook: if Claude never reacts to type errors, your `PostToolUse`
script probably exits `0` or `1`. Only `exit 2` puts its stderr in front of Claude.

</details>

<details>
<summary>💡 Hint 3: Make hooks debuggable by hand</summary>

Pipe a sample JSON into your script (`echo '{"tool_input":{"file_path":".env"}}' | ./guard.sh`)
and check its exit code with `echo $?`.

</details>

<details>
<summary>💡 Hint 4: Decide legal transitions before coding</summary>

Write the state diagram down first and reject everything else in the domain function. Hiding a
button is not a rule — call the function with an illegal move and check that it refuses.

</details>
