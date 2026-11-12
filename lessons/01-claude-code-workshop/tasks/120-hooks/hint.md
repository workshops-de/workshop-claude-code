<details>
<summary>💡 Hint 1: The hook does not block?</summary>

Start a new session, because new hook settings are loaded there. If that does not help, tell Claude what you observe and ask it to test the hook with an example call.

</details>

<details>
<summary>💡 Hint 2: The type-check hook reports nothing?</summary>

The hook has to give the errors back to Claude. Tell Claude that it should see the type errors after every Edit or Write. After that, a new session helps.

</details>

<details>
<summary>💡 Hint 3: Keep hooks fast</summary>

They run on every change. One type check is enough, the full test suite does not belong there.

</details>

<details>
<summary>💡 Hint 4: After the rebuild the hook blocks everything?</summary>

Then the hook script itself has a bug. Tell Claude what you see, for example: "Your hook blocks every command, fix it." Claude can still change the script with its file tools.

</details>

<details>
<summary>💡 Hint 5: Technical terms for the reading list</summary>

To steer when Claude builds something else:

- `localStorage`, key with the user ID
- State machine as a pure function, own file without storage and React
- Add `/reading-list` to the proxy matcher in `proxy.ts`
- Read the header counter only after loading (otherwise hydration mismatch)

</details>
