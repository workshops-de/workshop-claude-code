> **⚠️ Start the API first:** Open a **separate terminal window** and run `npx bookmonkey-api` there. Keep it open for the whole task, so the server runs locally on http://localhost:4730.

This task is about a **custom skill** (a guide that Claude loads on its own when it fits the job) and a **custom command** (a slash command that only you start). You build one page by hand, record how it was built, and let the next pages come from that.

You work in your `bookmonkey` repository with Node.js 26. The API (`npx bookmonkey-api`) runs on http://localhost:4730, and you start the app with `npm run dev` on http://localhost:3000. The demo user is `admin@bookmonkey.api` with `password1!`.

### 1. Build the read page by hand

```text
Build the read side of the catalogue. On /books: a search field (q), sorting by title or price (_sort, _order) and paging with 12 books per page (_page, _limit, total count from the X-Total-Count header). Everything stays in the URL. Also a detail page at /books/<isbn> with links to the previous and next book of the series, from predecessorIsbn and successorIsbn. Check with npm run build.
```

Then open `/books`, search, sort and page, and open a book from a series (for example Harry Potter). The previous and next links lead to the neighbouring books.

### 2. Record the pattern as a skill

```text
From what you just built, write a skill at .claude/skills/add-book-feature/SKILL.md. It describes how a book feature is built in this project: API client, page, URL state, checks. At most 8 numbered steps. The description starts with the words that would appear in a request (book, detail page, catalogue, field) and says when the skill is loaded.
```

Read the file. Claude first sees only the `description` of each skill, so it decides whether the skill gets loaded.

### 3. Test the skill in a new session

Start a new session and ask for a small change without naming the skill. You write the prompt yourself. It should touch a book feature that the skill covers. For example:

```text
Show the publisher on every book card in the catalogue as well.
```

Look in the transcript whether Claude loaded `add-book-feature`. If you do not see it, ask Claude: "Which skills did you load for this task?" In our run it did. If not, add the words from your prompt to the `description`.

### 4. Create a command

```text
Create a command /new-book-view at .claude/skills/new-book-view/SKILL.md that only I can call (disable-model-invocation: true). It takes one argument, create or edit, and builds the screen following the add-book-feature skill. create: form at /books/new, sends POST /books, shows a clear message on 409 that the ISBN already exists. edit: form at /books/<isbn>/edit with the values of the book, sends PATCH /books/<isbn> without id, createdAt, updatedAt. Both share one form, only the action and the default values differ. Both routes are reachable only when signed in.
```

### 5. Build the create screen

Type `/new-book-view create`. The argument ends up in the text of the command. Then sign in in the browser and create a book at http://localhost:3000/books/new with the ISBN 9990000000001. Then try it with the existing ISBN 9780747532699.

### 6. Build the edit screen

Type `/new-book-view edit`. In our run Claude reused the form from the first call instead of building a second one. Open http://localhost:3000/books/9990000000001/edit and change the book.

### 7. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

| | Skill | Command | `CLAUDE.md` |
|---|---|---|---|
| Who starts it | Claude, based on the `description` | you, with `/name` | always loaded |
| What for | a procedure that comes up often | a job with an argument | facts that always apply |

Skill and command are both a `SKILL.md`. `disable-model-invocation: true` turns the skill into a command that only you start.

**Done when** `/books` shows search, sorting and paging, `/books/<isbn>` leads through the series, a new book can be created and edited when signed in, Claude loaded `add-book-feature` by itself in a new session, and everything is committed.

<details>
<summary>More</summary>

- Older commands in `.claude/commands/<name>.md` still work and create the same `/name`.
- More fields such as `paths` (skill only for certain files) and `context: fork` are in the docs: [Skills](https://code.claude.com/docs/en/skills)
- Remove books you created while testing with `curl -X POST http://localhost:4730/dev/reset`.

</details>
