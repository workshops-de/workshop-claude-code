<details>
<summary>💡 Hint 1: The draft from /init is long</summary>

That's normal. Your job is to cut it to what matters, not to keep everything. A good test for each
line: would a new teammate need this, and would Claude get it wrong without it?

</details>

<details>
<summary>💡 Hint 2: Two sources, one truth</summary>

`/init` reads the README too, so it can inherit what the README says. For each claim, ask where it
comes from: the README, a config file, or the code itself. Only the last two are evidence.

</details>

<details>
<summary>💡 Hint 3: Keep commands exact</summary>

Keep commands exact and copy-pasteable, and run each one once. The agent will use them
verbatim.

</details>

<details>
<summary>💡 Hint 4: Proving the subdirectory file</summary>

Start a new session and ask something that needs no file in `api/`: the answer stays in your language. Then let it read a file in `api/` and ask again.

</details>

<details>
<summary>💡 Hint 5: All tests red at once?</summary>

Check `node -v`: `bookmonkey-legacy` needs Node 24 or newer (`node:sqlite`).

</details>
