<details>
<summary>💡 Hint 1: Read before you trust</summary>

An installed skill is instructions the agent will follow. Skim its `SKILL.md` like you'd skim a
dependency's README, what does it tell the agent to do? Who maintains it?

</details>

<details>
<summary>💡 Hint 2: No automatic invocation?</summary>

Compare your prompt with the skill's description. Automatic invocation happens when the task
matches the description's wording, rephrase, or invoke it explicitly and note the difference.

</details>

<details>
<summary>💡 Hint 3: Covers don't show up?</summary>

Look at what the `cover` field actually contains and where it points. Next.js' `<Image>` only
loads remote hosts you allow in `next.config`, a plain `<img>` is fine for this workshop too.
Covers come from `localhost:4730`, and Next.js refuses to optimise images from private
addresses, so with `<Image>` you also need `unoptimized`.

</details>
