> **⚠️ Setup before step 7:** Send this prompt to Claude before you start step 7. In the Desktop App, Claude starts missing servers in their own terminal tabs (stop: Ctrl+C in the tab). Without the Desktop App, Claude gives you the commands.
>
> ```text
> Setup for task 120: If node_modules is missing in the project folder, run npm install. Check with curl whether the bookmonkey-api on http://localhost:4730 (command: npx bookmonkey-api) and the app on http://localhost:3000 (command: npm run dev in the project folder) respond. If a server is missing, start it with that command in its own tab in the Desktop App terminal. If you cannot, give me the commands. If a port is already in use, ask me. End with a checklist of ✅ and ❌.
> ```

---

This task is about **hooks**. A hook is a rule that Claude Code applies itself at certain tool calls, even when Claude does not think of it. You use hooks for everything that **must always happen**.

You work in your `bookmonkey` repository with Node.js 26 and only need to write prompts. The demo user is `admin@bookmonkey.api` with `password1!`.

Claude's answers differ on every run. What you read under "in our run" is an example. If something differs, tell Claude what you see and what you expect instead.

### 1. See what Claude may do without a hook

You already have the file `.env.local`: since the subagents task it contains your `SESSION_SECRET`, and Git ignores it.

```text
What is in my .env.local?
```

The contents appear, the secret included. That is how it ends up in the session history. Sometimes Claude refuses even without a hook, because it recognises a secret. The model decides this anew each time, it is no guarantee. That is exactly why you build the hook.

### 2. Let Claude build a hook

A line in `CLAUDE.md` would only ask Claude. A hook always runs, even when Claude forgets. Tell Claude what you want and why. Claude decides how to build the hook.

```text
I don't want you to read or change .env files, not even by accident, because our secrets are in them. Use a hook to make sure this never happens. You may still read .env.example, there is nothing secret in it.
```

<details>
<summary>🔑 Technical terms to steer</summary>

If Claude builds something else:

- **`PreToolUse`** hook: runs **before** the tool
- **`exit 2`** blocks, `exit 1` only reports
- Matcher also covers **`Bash`**, not only `Read`
- Exception for **`.env.example`**

</details>

Start a new session so the setting is loaded, and ask the question from step 1 again. Claude should say that a **hook** blocks the access.

### 3. Let Claude test the hook

A hook that blocks too much gets in the way. A hook with gaps gives false security. Let Claude check it itself, in the same session:

```text
Test your .env hook before we trust it, but without touching real secrets: give the hook script example calls and show me for each one whether it blocks. Include: reading .env.local, reading .env.example, a commit whose message only mentions .env.local (should go through), and a commit that pulls the file contents into the message with $(cat .env.local) (should be blocked). Do not run the commands.
```

Claude shows a table. In our run the hook also blocked the harmless commit message, because it only searches for the text `.env.local`. Claude also found spellings that slip through on its own (for example `cat .e*.local`) and suggested a fix. If your table also shows a false alarm, tell Claude what should change:

```text
The hook blocks too much: a commit message that only mentions .env.local must go through. But the file contents must never end up in a message. Rebuild it and then test all cases again.
```

Then start a new session and ask the question from step 1 again.

### 4. Let Claude build a second hook

```text
Whenever you change a file, the types should be checked right away, not only at the end. Build a second hook for this that reports the type errors back to you, so you fix them straight away.
```

<details>
<summary>🔑 Technical terms to steer</summary>

If Claude builds something else:

- **`PostToolUse`** hook with matcher **`Edit|Write`**
- Type check with **`tsc --noEmit`**
- Errors go **back to Claude**, not only to the terminal

</details>

If the hook reports `PageProps` or `LayoutProps`, the Next types are missing. In our run Claude ran `next typegen` for this itself. Otherwise, ask Claude to do it.

### 5. Try the type-check hook

Start a new session:

```text
Show me that the type-check hook fires: put a small deliberate type error into a new test file, show me what the hook reports to you, and delete the file again afterwards.
```

Claude shows the hook's message, in our run `error TS2322: Type 'string' is not assignable to type 'number'`.

### 6. Build the reading list with both hooks

A reading list has states (want to read, reading, finished). A state machine defines which changes between the states are allowed. The reading list is the practice field: here both hooks should run during real work. First you clarify the rules with Claude, then it builds them.

```text
We are building a reading list. A book on the list is either "want to read", "reading" or "finished". Adding leads to want to read, starting to reading, finishing to finished, and a finished book can be started again. Removing always works. Before you start: explain in your own words which changes are allowed and which are not, so we are sure we mean the same thing. Ask if anything is unclear.
```

Claude lists the allowed and forbidden changes and names its assumptions, in our run for example that a book cannot be on the list twice. Confirm them or object. Then, in the same session:

```text
Build it now. On a book's detail page I want to put it on my reading list and change its state. Under /reading-list I see my books grouped by state, and the header shows how many there are. The page is only reachable for signed-in users, and every user has their own list. The API cannot do reading lists yet, so store them in the browser for now. Keep the rules for the changes in one place and independent of the storage, so we can take them into our own backend later.
```

<details>
<summary>🔑 Technical terms to steer</summary>

If Claude builds something else:

- **`localStorage`**, key with the **user ID**
- **State machine** as a **pure function**, own file without storage and React
- Add `/reading-list` to the **proxy matcher** in `proxy.ts`
- Read the header counter only **after loading** (otherwise **hydration mismatch**)

</details>

Both hooks run on every change. Then ask:

```text
Did the type-check hook report anything to you while building? Show me what it was and how you fixed it.
```

In our run it reported five times. Four were intermediate states (an import only came in the next edit), one was a real error that Claude fixed right away.

### 7. Try the reading list in the browser

Make sure both servers run (setup prompt at the top), sign in on http://localhost:3000 as the demo user and put a book on the list. Sign out, register a second account (for example second@example.com with password1!) and open `/reading-list`. The list is empty. If you see the first account's books, tell Claude so, and that every user should have their own list.

### 8. Commit your state

The hooks live in `.claude/` in the repo. Once committed, they apply to everyone on the team.

```text
Look at what we changed in this task and commit it.
```

### What just happened

The first hook ran **before** the tool (`PreToolUse`) and stopped it, in our run with `exit 2`. The second ran **after** it (`PostToolUse`, matcher `Edit|Write`) and gave the errors back to Claude. Claude tested the hooks by giving the script example calls as JSON, the way Claude Code sends them on a real call. An instruction in `CLAUDE.md` advises, a hook enforces.

A hook that searches command text catches accidents, but not a deliberate detour through the shell. Claude said so itself in our run. For real security, add `permissions.deny` rules and the sandbox.

**Done when** a hook has denied you access to `.env.local`, Claude has shown the type-check hook's message, and the reading list shows separate lists for two accounts.

<details>
<summary>More</summary>

Claude puts the hooks in `.claude/settings.json` and `.claude/hooks/`. To see them, open the terminal in the desktop app, start `claude` there and enter `/hooks`. If a hook script uses `jq` and `jq` is missing, it blocks everything or nothing, depending on how it is built. Check `jq --version` first. `exit 2` blocks a call, `exit 1` only reports an error and lets it through. A block that does not depend on the command text is a rule in `.claude/settings.json`: `{"permissions": {"deny": ["Read(./.env*)"]}}`. If you registered users while testing, `curl -X POST http://localhost:4730/dev/reset` removes them again.

[Hooks guide](https://code.claude.com/docs/en/hooks-guide)

</details>
