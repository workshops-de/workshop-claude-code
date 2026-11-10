This task is about **CLAUDE.md**, the memory of your project: a Markdown file Claude reads at the start of every session. You work in your `bookmonkey-legacy` clone (Node.js 24 or newer), in a new session in the mode that asks before changes.

### 1. Ask a question without memory

```text
Which port does the API run on, and how do I reset the database? How do you know?
```

Claude answers correctly but says it read the repo to find out. There is no `CLAUDE.md` yet.

### 2. Let Claude create a memory

Type `/init` and answer the questions with yes. In our run Claude asked several times before it wrote the file. Read the draft calmly before you continue.

### 3. Check the draft against README and code

```text
Create a table: every statement in the README, what /init wrote about it, what the code says. Mark contradictions.
```

Check every marked contradiction yourself by opening the file or running the command. Do the same for the commands in the draft (`npm install`, `npm run db:reset`, `npm test`).

### 4. Shorten the file yourself

Tell Claude in your own words what stays in `CLAUDE.md` and what goes. The goal is a short file with exact commands, pitfalls and rules Claude cannot read from the code. You could write, for example: "Only what you could not derive yourself, at most 25 lines. Keep the API port and the command that resets the database."

### 5. Give a folder its own rules

A `CLAUDE.md` in a subfolder is read only when Claude opens a file there. You test that with a rule you notice at once. Create the file in the terminal, not through Claude. Open the terminal in the desktop app, in the project folder:

```bash
echo 'Always answer in Italian.' > api/CLAUDE.md
```

Start a new session and ask `Which port does the API use?`. The answer comes in English, because Claude has not opened a file in `api/` yet. Then ask:

```text
Read api/package.json. Which port does the API use?
```

Now Claude has opened a file in `api/`, and the answer comes in Italian.

Replace the Italian rule now, otherwise it stays in place for the later tasks:

```text
Replace the content of api/CLAUDE.md with this rule: no console.log in the API, logging only through lib/logger.js.
```

### 6. Ask the question from step 1 again

Start a new session and ask the same question. This time Claude should name `CLAUDE.md` as its source.

### 7. Commit both files

```bash
git add CLAUDE.md api/CLAUDE.md && git commit -m "docs: add CLAUDE.md"
```

The later tasks start with these files.

### What just happened

A **CLAUDE.md** is read at every start and sits in the context of every request. So write only what Claude would otherwise get wrong. A `CLAUDE.md` in a subfolder is loaded only when Claude reads a file there, so rules apply only where they are needed.

**Done when** `CLAUDE.md` and `api/CLAUDE.md` are committed in your clone and Claude answers the question from step 1 with `CLAUDE.md` as its source.

<details>
<summary>More</summary>

- Personal notes belong in `CLAUDE.local.md` (add it to `.gitignore`). Claude reads an `AGENTS.md` only if there is no `CLAUDE.md`.
- Open the terminal in the desktop app and start `claude` there: `/memory` shows the loaded files, `/context all` shows them with token counts.
- The docs recommend under 200 lines per file: [Memory](https://code.claude.com/docs/en/memory) · [Best practices](https://code.claude.com/docs/en/best-practices)

</details>
