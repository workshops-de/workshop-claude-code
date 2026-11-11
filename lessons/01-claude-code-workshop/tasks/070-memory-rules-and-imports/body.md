> **⚠️ Start the API first:** Open a **separate terminal window** and run `npx bookmonkey-api` there. Keep it open for the whole task, so the server runs locally on http://localhost:4730.

This task is about **rule files and imports**: you define the domain language and the API contract of BookMonkey once, so every new session knows them. You work in your `bookmonkey` repository with Node.js 26 and start the API with `npx bookmonkey-api` if it is not running yet.

### 1. Let Claude write down the domain language

```text
The BookMonkey API runs on http://localhost:4730. Save its contract from /api-json to docs/openapi.json. Then write .claude/rules/domain.md: a glossary of our domain language (book, ISBN, id, series, author) with the entity model, server-managed fields and constraints. Check statements against real API responses instead of guessing. New is the reading list with the states want to read, reading and finished. Afterwards reset the API with POST /dev/reset.
```

Claude queries the API itself, creates test books and writes the result to `domain.md`. In our runs it recorded, for example, that a duplicate ISBN is rejected with `409` and that detail routes need the ISBN, not the `id`. The reading list does not exist in the API yet, you plan it for later. The reset removes the test books again. Read the file and object if something is wrong.

### 2. Import a compact contract

```text
Write a compact docs/api-contract.md from docs/openapi.json: endpoints, query parameters and status codes, all on one screen. Then create a CLAUDE.md that includes this file and AGENTS.md with an @ import.
```

The `CLAUDE.md` then consists of two lines at its core: `@AGENTS.md` and `@docs/api-contract.md`. `create-next-app` generated the `AGENTS.md`, and Claude Code only reads it through this import once a `CLAUDE.md` exists.

### 3. Ask about the domain language in a new session

Start a new session and ask:

```text
What is the difference between id and isbn in our project, and what is a reading list? Answer in three sentences.
```

Claude answers with your terms without reading a file. The rule file and the contract were already in context at startup.

### 4. Write a rule that applies to one file only

Now ask Claude yourself for a rule in `.claude/rules/api-client.md`. It should apply only when Claude works on the API client `lib/api.ts`. Think of two conventions that matter only there, for example a fixed prefix for error messages. Write the prompt in your own words.

For example:

```text
Create .claude/rules/api-client.md. The rule applies only to lib/api.ts. Error messages start with BookMonkey-API:, and every function returns typed data.
```

### 5. See when the rule applies

Start a new session and ask first:

```text
Which rules apply to the API client in lib/api.ts? Do not read the file, answer from what you already know.
```

Claude does not know your rule yet. Then ask it in the same session:

```text
Add a function getBook to lib/api.ts that loads a book and throws an Error on failure.
```

As soon as Claude opens `lib/api.ts`, the rule loads and the new function follows your conventions. In our run the new error messages followed the prefix we had set in the rule.

### 6. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

| Place | When loaded | For what |
|---|---|---|
| `CLAUDE.md` and imports | at every start | facts that always apply |
| `.claude/rules/*.md` without `paths` | at every start | one topic per file, e.g. the domain language |
| `.claude/rules/*.md` with `paths` | when Claude reads, writes or edits a matching file | conventions for one area |

`paths` is an entry in the frontmatter at the very top of the rule file and names the files the rule applies to. Without it, the rule loads at every start, even if you only forgot it. Your rules from this task look roughly like this.

`.claude/rules/domain.md` has no `paths` and loads at every start:

```markdown
# Domain language
- Detail routes need the ISBN, not the id.
```

`.claude/rules/api-client.md` has `paths` and loads only when Claude reads, writes or edits `lib/api.ts`:

```markdown
---
paths:
  - "lib/api.ts"
---
# API client
- Error messages start with "[api]".
```

This is what it looked like in a run with a rule limited to `lib/api*`:

| What happens in the session | Rule without `paths` | Rule with `paths` |
|---|---|---|
| The session starts | loaded | not loaded |
| Your prompt mentions `lib/api.ts`, but Claude does not open it | loaded | not loaded |
| Claude reads `app/page.tsx` | loaded | not loaded |
| Claude reads `lib/api.ts` or writes a new file `lib/api-extra.ts` | loaded | loaded |

So your domain language goes in a rule without `paths`, because it matters everywhere. The API client conventions go in a rule with `paths`, because they only matter in `lib/api.ts` and cost no context until then.

Imports organise your memory, but they do not save context: everything loaded at startup costs tokens on every prompt. That is why you import a compact summary and not the raw `openapi.json`. The full file stays on disk and Claude reads it when needed.

**Done when** a new session uses your terms from `domain.md`, Claude does not know your rule from `api-client.md` before opening `lib/api.ts`, and `getBook` then follows your conventions.

<details>
<summary>More</summary>

Your `domain.md` also contains the reading list with its states. You build it in the hooks task. You should commit `docs/openapi.json`, because it serves later as the contract for your own backend.

We did not check whether the desktop app shows which files were loaded; to look, open the terminal there, start `claude` and type `/memory`.

- [Memory, rules and imports](https://code.claude.com/docs/en/memory)
- [Path-specific rules](https://code.claude.com/docs/en/memory#path-specific-rules)

</details>
