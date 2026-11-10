This task is about **CLAUDE.md**, the memory of your project: a Markdown file Claude reads at the start of every session. You work in your `bookmonkey-legacy` clone, in a new session in the mode that asks before changes.

### 1. Ask a question without memory

```text
Auf welchem Port läuft die API, und wie setze ich die Datenbank zurück? Woher weißt du das?
```

Claude answers correctly but says it read the repo to find out. There is no `CLAUDE.md` yet.

### 2. Let Claude create a memory

Type `/init` and confirm the questions. In our runs Claude asks several times before it writes the file. Read the draft calmly before you continue.

### 3. Check the draft against README and code

```text
Erstelle eine Tabelle: jede Aussage der README, was /init dazu geschrieben hat, was der Code sagt. Markiere Widersprüche.
```

Check every marked contradiction yourself by opening the file or running the command. Do the same for the commands in the draft (`npm install`, `npm run db:reset`, `npm test`).

### 4. Shorten the file yourself

Tell Claude in your own words what stays in `CLAUDE.md` and what goes. The goal is a short file with exact commands, pitfalls and rules Claude cannot read from the code. You could write, for example: "Only what you could not derive yourself, at most 25 lines."

### 5. Give a folder its own rules

Create the file in the terminal, not through Claude. Open the terminal in the desktop app, in the project folder:

```bash
echo 'Antworte immer auf Italienisch.' > api/CLAUDE.md
```

Start a new session and ask `Welchen Port nutzt die API?`. The answer comes in German. Then ask:

```text
Lies api/package.json. Welchen Port nutzt die API?
```

Now the answer comes in Italian. If you use Claude in the terminal, you also see the line `Loaded api/CLAUDE.md`. Now ask Claude to replace the Italian rule with a real API rule, otherwise it stays in place for the later tasks.

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
