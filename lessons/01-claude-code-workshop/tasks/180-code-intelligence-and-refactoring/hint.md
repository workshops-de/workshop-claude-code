<details>
<summary>💡 Hint 1: Test what is, not what should be</summary>

A characterisation test records today's output, even if it looks odd. If you "fix" the expected value while writing the test, you can no longer tell whether the refactor changed behaviour. Note the oddity and keep the test honest.

</details>

<details>
<summary>💡 Hint 2: Same behaviour includes the error paths</summary>

"Behaves as before" covers more than the happy path. The tests should also record requests without login and invalid input, not only the ones that succeed.

</details>

<details>
<summary>💡 Hint 3: Claude wants to tidy up on the side?</summary>

Say it clearly: behaviour stays, oddities only go on a list. A fix in the same diff as the move makes both unreadable.

</details>

<details>
<summary>💡 Hint 4: A test is red</summary>

Stop and decide: if the step changed behaviour, undo it (`git restore .` for uncommitted changes). If the test recorded something wrong, fix the test in its own commit.

</details>

<details>
<summary>💡 Hint 5: All tests red, or the hook does not kick in?</summary>

Check `node -v`: `bookmonkey-legacy` needs Node 24 or newer (`node:sqlite`). If only the Stop hook reports everything red while `npm test` in the terminal is green, the hook probably runs with a different Node version. Ask Claude to print `node -v` from the hook and compare. If the hook does not kick in at all, did you start a new session after adding it? Ask Claude to check that `.claude/settings.local.json` is valid JSON.

</details>
