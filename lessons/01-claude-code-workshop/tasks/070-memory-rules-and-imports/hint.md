<details>
<summary>💡 Hint 1: Make the agent commit to definitions</summary>

"It depends" is a sign to ask a sharper question. Not every book belongs to a series and not every
field is required — check the contract and say so explicitly instead of assuming.

</details>

<details>
<summary>💡 Hint 2: Importing the raw OpenAPI file?</summary>

Run `/context` before and after. Every import loads at launch, on every prompt. A one-screen
summary plus a pointer to the full file usually beats the full file.

</details>

<details>
<summary>💡 Hint 3: Path-scoped rules load on read, not on every prompt</summary>

A scoped rule only shows up after Claude reads a matching file. If `/context` doesn't list it yet,
ask the agent to open a file under that path and check again.

</details>
