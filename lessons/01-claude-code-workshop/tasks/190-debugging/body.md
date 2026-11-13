> **⚠️ Setup first, in your `bookmonkey-legacy` clone:** Send this prompt to Claude. In the Desktop App, Claude starts the servers in their own terminal tabs (stop: Ctrl+C in the tab). Without the Desktop App, Claude gives you the commands.
>
> ```text
> Setup for task 190: Switch to the main branch. If there are uncommitted changes, ask me first. If the Stop hook from task 180 is still in .claude/settings.local.json, remove it. If an API is already running on port 4780, stop it. Then run npm run db:reset so the data is fresh. Check with curl whether the API on http://localhost:4780 (command: npm run dev:api) and the web app on http://localhost:5180 (command: npm run dev:web) respond. If a server is missing, start it with that command in its own tab in the Desktop App terminal. If you cannot, give me the commands. If a port is already in use, ask me. End with a checklist of ✅ and ❌.
> ```

---

This task is about **debugging with Claude**: you get a bug ticket from users and work your way to the cause with evidence instead of guesses. You work in your `bookmonkey-legacy` clone with Node.js 24 or newer.

This is the ticket, and all you know:

> **Ticket BM-412: "Next volume" leads nowhere**
>
> Since a while the "next volume" link in The Lord of the Rings leads nowhere. Other series work until someone saves a book in the admin.

### 1. Reproduce the bug yourself

Open http://localhost:5180 and "The Fellowship of the Ring" in the catalogue. At the bottom of the page there is a box about the series with the link to the next volume. In our run it said "Nächster Band »: nicht gefunden" (not found).

Then log in at http://localhost:5180/login with `admin@bookmonkey.example` and `admin2021`. Open http://localhost:5180/admin/books, pick "A Game of Thrones", enter an x in the "Untertitel" (subtitle) field and click "Speichern" (save). Then look at the other volumes of this series in the catalogue.

### 2. Let Claude check hypotheses without changing anything

Start a new session in **Auto** mode and stay in it until the end. A hypothesis is a guess that can be checked. You want several of them before Claude touches code:

```text
Ticket BM-412 from the library team: The link "next volume" in The Lord of the Rings leads nowhere. Other series work until someone saves a book in the admin.

This is what I observed: On the page of The Fellowship of the Ring it says "Nächster Band: nicht gefunden". After I saved A Game of Thrones in the admin, the navigation in this series no longer works.

Find the cause before you change anything. Come up with two or three hypotheses that could explain both observations, and check each one with a quick check. For every cause, tell me which observation proves it. Do not change any code yet.
```

Check the answer: does every cause have evidence? A cause without evidence is only a guess.

### 3. Fix every place, test first

```text
Name the cause with file and line and list every place in the code that it affects, not only the one from the ticket. Change nothing yet.
```

Count the places: are there more than the one from the ticket? Then:

```text
First write a test in api/test/ that shows the bug, and show me that it fails. After that, fix the cause at every place on your list and run npm test. Read the diff before you commit, and commit when everything is green.
```

Make sure the test was red first. Red before the fix and green after it proves the fix works.

### 4. Check it yourself

Stop the API with Ctrl+C, run `npm run db:reset`, restart it with `npm run dev:api` and repeat step 1 in the browser, including the save in the admin.

### What just happened

You gave Claude a strategy, not only the ticket: reproduce first, then hypotheses with evidence, then every affected place, then a red test. A fix only at the place named in the ticket would hide the symptom, and the cause would stay. That is why you ask for every place in step 3.

**Done when** the "next volume" link of The Fellowship of the Ring works, saving a book in the admin no longer breaks a series, a new test covers the bug, `npm test` is green and everything is committed.

<details>
<summary>More</summary>

- If you start a new session in between, Claude has lost the history. Then include the ticket and your observations again.
- Claude's answers differ from run to run. Check a statement by running the check yourself.
- Time left? Ask the git history: "Find out when this behaviour came into the code, and use the commit message to explain what the author wanted to achieve at the time." It often shows why the code was built this way.
- [Common workflows: Fix bugs](https://code.claude.com/docs/en/common-workflows) · [Best practices](https://code.claude.com/docs/en/best-practices) · [Permission modes](https://code.claude.com/docs/en/permission-modes)

</details>
