> **⚠️ Start for step 7:** each in its own terminal, keep it open until the end.
> - API: `npx bookmonkey-api` (http://localhost:4730)
> - App: `npm run dev` (http://localhost:3000)

---

This task is about **hooks**. A hook is a rule that Claude Code applies itself at certain tool calls, even when Claude does not think of it. You use hooks for everything that **must always happen**.

You work in your `bookmonkey` repository with Node.js 26 and only need to write prompts. The demo user is `admin@bookmonkey.api` with `password1!`.

### 1. See what Claude may do without a hook

You already have the file `.env.local`: since the subagents task it contains your `SESSION_SECRET`, and Git ignores it.

```text
Read the file .env.local and show me the contents.
```

The contents appear, secrets included.

### 2. Let Claude build a hook

```text
Set up a hook so that you can no longer read or change .env files. .env.example must stay readable.
```

Start a new session so the setting is loaded, and ask the question from step 1 again. Claude should say that a **hook** blocks the access.

### 3. Check what Claude built

```text
Run exactly this command: git commit --allow-empty -m "docs: mentioned .env.local"
```

The commit is harmless, but in our runs it was blocked because the hook also searches the command text. If this happens to you, tell Claude what should change:

```text
The hook blocks too much: a commit message that only mentions .env.local must go through. File access to .env files must stay blocked.
```

Then repeat the commit command and the question from step 1.

### 4. Let Claude build a second hook

Write one sentence yourself: after every `Edit` or `Write` a type check should run and Claude should see the type errors. For example:

```text
Set up a second hook: after every Edit or Write a type check should run, and you should see the type errors and fix them.
```

### 5. Try the type-check hook

Start a new session and add a deliberate error:

```text
Create the file lib/typfehler-test.ts with exactly this content: export const x: number = "text";
```

Claude should name `TS2322`. If it also reports `PageProps` or `LayoutProps`, run `npx next typegen`. Then clean up:

```text
Delete the file lib/typfehler-test.ts again.
```

### 6. Build the reading list with both hooks

A reading list has states (want to read, reading, finished). A state machine defines which changes between the states are allowed. First you clarify the rules with Claude, then it builds them.

```text
We are building a reading list. Transitions: add leads to want to read, start to reading, finish to finished, start again to reading, remove works from every state. Repeat the allowed and the forbidden transitions before you write anything.
```

Then, in the same chat:

```text
Implement it now: the state machine as a pure function transition(state, action) that rejects forbidden transitions. Also a store per user in localStorage, reading list buttons on the detail page, a page /reading-list in the signed-in area, grouped by state, and a counter in the header. If there is no header yet, create one.
```

Both hooks run on every change.

### 7. Try the reading list in the browser

Start both servers, sign in on http://localhost:3000 as the demo user and put a book on the list. Sign out, register a second account (for example second@example.com with password1!) and open `/reading-list`. The list is empty.

### 8. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

The first hook ran **before** the tool (`PreToolUse`) and stopped it, in our run with `exit 2`. The second ran **after** it (`PostToolUse`) and gave the errors back to Claude. An instruction in `CLAUDE.md` advises, a hook enforces.

**Done when** a hook has denied you access to `.env.local`, Claude has named `TS2322` from the type-check hook, and the reading list shows separate lists for two accounts.

<details>
<summary>More</summary>

Claude puts the hooks in `.claude/settings.json` and `.claude/hooks/`. To see them, open the terminal in the desktop app, start `claude` there and enter `/hooks`. Without `jq` a hook script fails silently and blocks nothing. If you registered users while testing, `curl -X POST http://localhost:4730/dev/reset` removes them again.

[Hooks guide](https://code.claude.com/docs/en/hooks-guide)

</details>
