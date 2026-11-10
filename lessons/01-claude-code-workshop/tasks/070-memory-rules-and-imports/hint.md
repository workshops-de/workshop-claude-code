<details>
<summary>💡 Hint 1: Make the agent commit to definitions</summary>

"It depends" is a sign to ask a sharper question. Not every book belongs to a series and not every
field is required. Tell Claude to write this down explicitly instead of assuming.

</details>

<details>
<summary>💡 Hint 2: Importing the raw OpenAPI file?</summary>

Every import loads at launch, on every prompt. A one-screen summary plus a pointer to the full file
usually beats the full file.

</details>

<details>
<summary>💡 Hint 3: Path-scoped rules load on read, not on every prompt</summary>

A scoped rule only loads after Claude has opened a matching file. Ask Claude first whether it knows
the rule, then have it change something in `lib/api.ts`. The difference shows in the answer.

</details>
