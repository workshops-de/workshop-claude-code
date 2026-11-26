> **⚠️ Setup first:** Clone the repo once, in one of two ways.
>
> **Command line** (any terminal, or the Desktop App's terminal, ``Ctrl+` ``):
>
> ```bash
> git clone https://github.com/andrekovac/bookmonkey-legacy.git
> ```
>
> **In the chat:** start a session in the folder where your projects live and send this prompt. Allow the `git clone` command when Claude asks.
>
> ```text
> Setup for task 020: Clone https://github.com/andrekovac/bookmonkey-legacy.git into this folder. Then check with node -v that Node.js 24 or newer is installed. Give me a checklist with ✅ and ❌ at the end.
> ```

---

In this task you learn how Claude Code works as an **agent**: it reads, searches and runs commands, looks at the result and then decides the next step (**Reason → Act → Observe**). You inherit an unfamiliar codebase and only have to **understand** it. You change no file.

The codebase is [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy): a library app after five years and four developers, an Express API on SQLite, a React web app with Vite, about 15,000 lines. You need Claude Code, Git and a terminal. You meet it again in the tasks on refactoring, debugging and code review. The map you draw today helps you there.

### 1. Start in plan mode

In **plan mode** Claude reads files and runs exploring commands, but changes nothing until you approve a plan. In this task you never approve one.

- **Terminal:** `cd bookmonkey-legacy` and `claude --permission-mode plan`. If a session is already running, press `Shift+Tab` until `plan mode on` shows.
- **Desktop app (the "Code" tab):** start a new session, pick the `bookmonkey-legacy` folder below the input field and set **Plan** in the mode menu next to it.

### 2. Watch the loop once

Run `/context` and note the value. Then ask:

```text
Which parts does this repository have, and how do you start each one?
```

After the answer, open the transcript viewer with `Ctrl+O` (desktop app: arrow next to the session name → **Transcript view** → **Verbose**, or press `Ctrl+O` until **Verbose** is on). Count the tool calls. In the terminal, `Ctrl+O` closes the viewer again. Find a word from one call's result in the input of the next call: that is **Observe** deciding the next **Act**. You do not see the **Reason** step directly, only its effect on the next call.

### 3. Get the architecture explained

```text
Give me an overview of the architecture: parts, how they start, ports, where the data lives. For every statement, name the file it is based on.
```

### 4. Get a dependency map drawn

```text
Draw the main modules of the API and the web app as a Mermaid diagram, with arrows for the imports.
```

Paste it into [mermaid.live](https://mermaid.live) or a Mermaid preview in your editor. Check one arrow yourself by opening the file.

### 5. Follow a request

```text
When I open a book's detail page: which path does the request take from the React page through the API route and the service layer down to the SQL query? With file and line.
```

### 6. Ask for the risks

```text
What are the five biggest risks if we take over this codebase? Give the evidence for each.
```

Push back on at least one: "Show me where" or "Is that still true today?".

### 7. Ask who worked on what

```text
Use git log and git shortlog -sn to find out who touched which areas, in which years, and how the style changed.
```

### 8. Check the context window and the repo

Run `/context` again and compare with step 2: what filled the window? Then run `git status` in the terminal: it must report `nothing to commit, working tree clean`.

### What just happened

| Tool | For |
|---|---|
| Plan mode | Exploring without anything being changed |
| `Ctrl+O` | Seeing what Claude really read and ran |
| `/context` | Seeing how full the context window is |
| Asking for artefacts | A diagram, a file and a line instead of an impression: you can check it |

"What do you think of this code?" cannot be checked. A Mermaid diagram with files can.

**Done when** you have an architecture overview, a dependency map, a request flow and five risks with evidence, can say what filled the context window, can say when you approve a proposed action and when you do not, and `git status` is clean.

<details>
<summary>More on this</summary>

`/help` lists all slash commands, `/permissions` shows what Claude may do without asking (in the desktop app it only works in `claude` in the app's terminal). Docs: [Overview](https://code.claude.com/docs/en/overview), [Permission modes](https://code.claude.com/docs/en/permission-modes), [Common workflows](https://code.claude.com/docs/en/common-workflows), [Interactive mode](https://code.claude.com/docs/en/interactive-mode), [Commands](https://code.claude.com/docs/en/commands), [Mermaid](https://mermaid.js.org/syntax/flowchart.html).

</details>
