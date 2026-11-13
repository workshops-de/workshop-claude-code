> **✅ No server needed:** you do not have to start anything before this task.

---

Your team takes over `bookmonkey-legacy` on Monday. A new colleague starts next week, and everyone works with Claude Code. After cloning you have about 35 minutes to prepare the repo so that Claude writes good code in it from the first session on and breaks nothing.

You use everything from this week for it. There is no model solution. As a group you decide what you build, what you leave out on purpose, and why.

### 1. Form groups and clone fresh

Work in groups of three or four at one computer. One person types, the others steer and check with the questions from "Did you think of everything?". Switch after each building block.

Clone the repo into a new folder, so your files from earlier tasks do not come along. You need Node.js 24 or newer (`node -v`):

```bash
git clone https://github.com/andrekovac/bookmonkey-legacy.git bookmonkey-altbau && cd bookmonkey-altbau && npm install && npm run db:reset
```

### 2. Let Claude explore thoroughly (7 min)

Start a session in plan mode and ask the way you would in a hand-over between colleagues:

```text
We are taking over this repo and want you to work in it safely from Monday on. Explore it thoroughly: how to start and test it, how the data flows, where it is risky. Back every statement with file and line, and do not change anything yet.
```

If Claude asks whether to carry out the plan, say no. This step is only for exploring. Read the result together and check at least two statements yourselves.

### 3. Decide what goes where (3 min)

Collect on paper or in the chat what Claude needs to know or respect in this repo. Give each point a place:

| Place | For |
| --- | --- |
| `CLAUDE.md` | always applies, short, Claude cannot read it from the code |
| Rule in `.claude/rules/` | one topic, maybe only for certain paths |
| Skill | a workflow that comes up again and again in the team |
| Hook or deny rule | must never happen, whatever the prompt says |
| nowhere | Claude finds it in the code itself |

### Did you think of everything?

Pick one or two questions per building block. Whoever is not typing asks one of them to the group before you commit the block.

<details>
<summary>CLAUDE.md and context</summary>

- How do you know that every command in your `CLAUDE.md` works? Did you see it run yourselves?
- What would Claude get wrong without this file? Is only that in it?
- Which source in the repo would Claude believe without checking it? Did you cross-check one of them?
- Does the repo run for the new colleague with her Node version? How does she notice if it does not?
- How much context is already used before you write the first prompt?

</details>

<details>
<summary>Rules, skills and plan mode</summary>

- Which correction would you have to give Claude a second time this week?
- Does a rule contradict your `CLAUDE.md`? What does Claude do then, and how do you prevent the contradiction?
- Which workflow comes up again and again in this team, with the same steps?
- When should Claude pick your skill on its own, and when not? Does the description say so?
- For which tasks should Claude plan first in this repo, before it changes anything? Where does that stand?

</details>

<details>
<summary>Hooks and permissions</summary>

- What must never happen in this repo, whatever the prompt says?
- Are there files Claude should not read at all? How do you make sure of that?
- For which command do you never want to click "Allow" again? And which one must never run without asking?
- How do you show that your hook really blocks, and not only that it exists?
- What if Claude reaches the same result with a different command?

</details>

<details>
<summary>Tests and quality</summary>

- How does Claude itself notice that it broke something?
- How do you know the state of the tests before your first change?
- What if Claude changes code that has no test yet?
- Who reads Claude's diff with fresh eyes, without knowing the history of this session?

</details>

<details>
<summary>Team and daily work</summary>

- What belongs in `.claude/settings.json`, and what in `.claude/settings.local.json` or your personal configuration?
- The new colleague clones the repo tomorrow: does your hook run for her without explanation? Does it need a tool that only you have installed?
- Do you fetch tickets or data by hand from Jira or the browser so far? Does an MCP server for that belong in the repo?
- How will you notice in three months that your `CLAUDE.md` is no longer correct?

</details>

### 4. Build your setup (20 min)

Build the block that helps most first, and check it. The goal is a `CLAUDE.md` and one block that enforces something (hook or deny rule). Build a rule and a skill if there is time left. What is missing goes on your "left out on purpose" list.

For each block, tell Claude what you want to achieve and why, and let it demonstrate the block afterwards. For example:

```text
New colleagues should be able to start and test the project without asking anyone. Write a CLAUDE.md with only what you could not derive from the code, 30 lines at most. Run every command in it once and show me the output.
```

<details>
<summary>🔑 Technical terms to steer</summary>

- **`paths`** in a rule's frontmatter: the rule only loads for matching files.
- **`description`** of a skill: Claude uses it to decide whether to pick the skill on its own.
- **PreToolUse** with matcher **`Bash`** or **`Edit|Write`**: the hook runs before the tool. **`exit 2`** blocks, `exit 1` shows an error but does not block.
- **`permissions.deny`** and **`permissions.allow`** in `.claude/settings.json`: rules without a script of their own.
- **`/memory`** and **`/context`**: show what is loaded and how much space it takes.

</details>

At the end, commit everything that belongs in the repo.

### 5. Run the probe (5 min)

In a new session, give Claude a real ticket, for example BM-412 from task 190 ("next volume" leads nowhere). Stop as soon as you have seen whether your blocks apply: does Claude read your files? Does the rule apply? Does the hook block? The ticket does not need to be finished. Note what did not go as planned.

### 6. Present (3 min per group)

Before you present, another group gives you one single prompt that tries to get around your hook or deny rule. If the block holds, there is applause. If not, you show why.

Then show three things:

1. the block you are most proud of, with the proof that it works,
2. something you left out on purpose, and why,
3. what went differently than planned in the probe.

Each group notes one idea from the others that it will take into its real repo on Monday.

### Done when

- a checked `CLAUDE.md` and a checked hook or deny rule are committed in your clone,
- you saw in a new session that both work,
- `npm test` still runs green in your clone,
- you can say what you left out on purpose and why.

<details>
<summary>More</summary>

- The tasks this builds on: 030 (permissions), 040 (CLAUDE.md), 050 (context), 060 (plan mode), 070 (rules), 090 (subagents), 100 (skills), 110 (MCP), 120 (hooks), 200 (tests), 220 (review).
- Docs: [Memory](https://code.claude.com/docs/en/memory) · [Skills](https://code.claude.com/docs/en/skills) · [Hooks](https://code.claude.com/docs/en/hooks) · [Settings](https://code.claude.com/docs/en/settings) · [Best practices](https://code.claude.com/docs/en/best-practices)

</details>
