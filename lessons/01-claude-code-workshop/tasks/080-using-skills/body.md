> **⚠️ Start first:** each in its own terminal, keep it open for the whole task.
> - API: `npx bookmonkey-api` (http://localhost:4730)
> - App: `npm run dev` (http://localhost:3000)

---

This task is about **skills**: ready-made instructions for Claude, for example for a library that changes quickly. You install a skill for **shadcn/ui** and use it to build the BookMonkey catalogue page.

You work in your `bookmonkey` repository with Node.js 26.

### 1. Install the shadcn skill

Open the terminal in the desktop app and run this in the project:

```text
npx skills add shadcn-ui/ui@shadcn -y
```

The output shows safety ratings. A skill is text Claude follows, so take a quick look. Afterwards the project contains the folder `.agents/skills/shadcn`, a symlink `.claude/skills/shadcn` and the file `skills-lock.json`. Open the `SKILL.md` and read the first lines: they say what the skill is for.

### 2. Build the catalogue page without mentioning the skill

Start a new session so that Claude knows the skill, and give this prompt:

```text
Set up shadcn/ui in this project and build a catalogue page at /books: one card per book from GET /books with cover, title, author and price. Each card links to /books/<isbn>.
```

Look in the transcript to see whether Claude loaded the skill. In our run, `Skill shadcn` was the first call, before Claude read the project. The links to `/books/<isbn>` still lead nowhere; you build the detail page in a later task.

### 3. Ask what the skill changed

```text
Name three places in the catalogue page that you built this way because of the skill. Do not change anything.
```

In our run Claude named rules from the skill: the full card structure (`CardHeader`, `CardDescription`, `CardFooter`), `Badge` for the price, only semantic colours.

### 4. Call the skill explicitly

```text
Use the shadcn skill to add a skeleton loading state and an empty state to the catalogue.
```

Claude fetches `skeleton` and `empty` with the shadcn CLI and builds both states with these components, not with hand-made `div`s. The `SKILL.md` says `user-invocable: false`, so you name the skill in the prompt instead of typing `/shadcn`.

### 5. Give your own task with the skill

Write your own prompt that names the skill and extends the page with a search field that filters the books by title. One sentence is enough, for example: "Use the shadcn skill and add a search field above the grid that filters the books by title." Then check the page in the browser.

### 6. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

A skill is a folder with a `SKILL.md`. Claude first sees only the **name and description**. If your task matches the description, Claude loads the full instructions. This keeps the context small.

| | Skill | `CLAUDE.md` and rules |
| --- | --- | --- |
| Content | a procedure that fits a task | facts that always apply |
| Loaded | on demand | always or by path |

A skill is a good home for knowledge that changes quickly, like the shadcn CLI. A skill is text that Claude follows. So read it before you install it and check who publishes it.

**Done when** `/books` shows the books as cards with cover, title, author and price, the skill lives in `.claude/skills/shadcn`, and you have seen in the transcript that Claude loaded it.

<details>
<summary>More</summary>

Find skills: `npx skills find <topic>` or https://skills.sh. Commit the folder `.agents/skills/` and `skills-lock.json` so your team has the same skill. In our runs Claude loaded the skill without a hint; with other wording this can differ.

- [Claude Code: Skills](https://code.claude.com/docs/en/skills)
- [shadcn/ui: Installation for Next.js](https://ui.shadcn.com/docs/installation/next)

</details>
