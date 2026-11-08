## Overview

Get comfortable driving Claude Code as an agentic tool on a codebase you have never seen. You
inherit a real, grown application and your only job is to **understand it**: you change no file.
On the way you learn the mental model behind the tool: an agent works in a **Reason → Act →
Observe** loop, proposes tool calls that change your environment, and is only as good as the
context you give it.

You do **not** produce code in this task. You produce understanding, and fluency with the tool.

## The Feature

Claude Code reads, searches, and runs commands in your repository, then reasons about what it saw.
For exploration you want all of that, minus the editing:

- **Plan mode is read-only.** Start a session in it with `claude --permission-mode plan`, or press
  `Shift+Tab` until the status bar shows `plan mode on`. Claude reads files and runs exploring
  shell commands, but edits stay blocked until you approve a plan. For this task you never
  approve one.
- **Watch the loop.** Every tool call (Read, Grep, a `git log`) is an _act_; its output is the
  _observe_ step; the next sentence is the _reason_ step. Open the transcript viewer with `Ctrl+O`
  to see what Claude actually looked at.
- **Slash commands** steer the session: `/help` lists them, `/context` shows how full the context
  window is, `/permissions` shows what Claude may do without asking.
- **Ask for artefacts, not impressions.** "Draw a Mermaid diagram of the modules and their
  imports" is checkable. "What do you think of this code?" is not.

## Apply it to BookMonkey Legacy

> **Repo / ports:** your `bookmonkey-legacy` clone (Node.js 24 or newer), API on
> http://localhost:4780, web app on http://localhost:5180
>
> **Login:** admin `admin@bookmonkey.example` / `admin2021`

In the build tasks you create a fresh BookMonkey. Here you meet its older sibling:
[`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy), the company library and
book shop app as it looks after five years and four developers: an Express API on top of SQLite,
a React web app built with Vite, around 15,000 lines of code that grew feature by feature, and the
git history to go with it. You inherit this codebase again in the refactoring, debugging, and code
review tasks, so the map you draw today pays off later.

## Prerequisites

- Claude Code installed and verified (see "Install Claude Code and Verify It Works")
- Git and a terminal. Node.js 24 or newer only if you want to run the app (optional here).

## Steps

1. Clone the repository and start Claude Code in it, in plan mode:

   ```bash
   git clone https://github.com/andrekovac/bookmonkey-legacy.git
   cd bookmonkey-legacy
   claude --permission-mode plan
   ```

2. **Watch the loop once.** Run `/context`, so you have a baseline. Then ask a first architecture
   question, for example "Which parts does this repository have, and how is each one started?".
   When the answer is there, press `Ctrl+O` to open the transcript viewer and count the tool calls
   Claude made. Pick one call and name its three steps: **Reason** (why Claude chose it), **Act**
   (the call itself), **Observe** (what came back, and how the next step used it). `Ctrl+O`
   again closes the viewer.
3. Ask for an **architecture overview**: the parts of the system, how they are started, which
   ports they use, and where the data lives. Ask Claude to name the files it based each claim on.
4. Ask for a **dependency map** as a Mermaid diagram: the main modules of the API and the web app
   and which one imports which. Paste it into a Mermaid preview (your editor or
   [mermaid.live](https://mermaid.live)) and check one arrow yourself by opening the file.
5. Pick one user action, for example "open the detail page of a book", and ask Claude to trace the
   **request flow** from the React page through the API route and the service layer down to the SQL
   query, with file and line references.
6. Ask for the **five biggest risks** of taking over this codebase, each with the evidence that
   made Claude pick it. Push back on at least one: "show me where", "is that still true today?".
7. Ask **who worked on what**: let Claude use `git log` and `git shortlog -sn` to tell you which
   developers touched which areas, in which years, and how the style changed over time.
8. Run `/context` again and compare with your baseline. Then check the repository:
   `git status` must say `nothing to commit, working tree clean`.

## Success Criteria

**Feature**

- [ ] You explored the whole session in plan mode and never approved a plan
- [ ] You can describe one Reason → Act → Observe cycle from your session, tool call included
- [ ] You checked `/context` at the start and at the end and know what filled the window
- [ ] You can explain when you would approve vs. reject a proposed action

**Codebase understood, nothing changed**

- [ ] You have an architecture overview, a Mermaid dependency map, and one traced request flow,
      each with file references
- [ ] You have five risks with evidence, and you challenged at least one of them
- [ ] You know who worked on which part of the code and when
- [ ] `git status` in `bookmonkey-legacy` is clean

## References

- Claude Code: Overview: https://code.claude.com/docs/en/overview
- Claude Code: Permission modes (plan mode): https://code.claude.com/docs/en/permission-modes
- Claude Code: Common workflows (understand new codebases): https://code.claude.com/docs/en/common-workflows
- Claude Code: Interactive mode: https://code.claude.com/docs/en/interactive-mode
- Claude Code: Commands: https://code.claude.com/docs/en/commands
- Mermaid flowchart syntax: https://mermaid.js.org/syntax/flowchart.html
