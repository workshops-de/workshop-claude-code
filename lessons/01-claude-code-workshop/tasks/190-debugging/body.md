> **⚠️ Start first, in your `bookmonkey-legacy` clone:** each in its own terminal, keep it open for the whole task.
> - API: `npm run dev:api` (http://localhost:4780)
> - Web app: `npm run dev:web` (http://localhost:5180)
> - Before that, if you are unsure whether the data is fresh: `npm run db:reset`

---

This task is about **debugging with Claude**: you get a bug ticket from users and work your way to the cause with evidence instead of guesses. You work in your `bookmonkey-legacy` clone with Node.js 24 or newer.

This is the ticket, and all you know:

> **Ticket #412: "Next volume" leads nowhere**
>
> Since a while the "next volume" link in The Lord of the Rings leads nowhere. Other series work until someone saves a book in the admin.

### 1. See the first sentence yourself

Open http://localhost:5180 and "The Fellowship of the Ring" in the catalogue. The book page has a box about the series at the bottom with the link to the next volume. In our run it said "Nächster Band »: nicht gefunden" (not found).

### 2. See the second sentence yourself

Log in at http://localhost:5180/login with `admin@bookmonkey.example` and `admin2021`. Open http://localhost:5180/admin/books, pick "A Game of Thrones", enter an x in the "Untertitel" (subtitle) field and click "Speichern" (save). Then look at the other volumes of this series in the catalogue.

### 3. Give Claude the evidence

Start a new session and set the mode to **Plan**. Stay in this session for steps 3 to 8. A hypothesis is a guess that can be checked. You want several of them before Claude touches code:

```text
Ticket #412 from the library team: The link "next volume" in The Lord of the Rings leads nowhere. Other series work until someone saves a book in the admin.

This is what I observed: On the page of The Fellowship of the Ring it says "Nächster Band: nicht gefunden". After I saved A Game of Thrones in the admin, the navigation in this series no longer works.

Give me two or three competing hypotheses that could explain both observations, and one cheap check for each. Change nothing.
```

Claude reads the code and returns hypotheses with checks. In our run it only read and changed nothing.

### 4. Let the checks run

Set the mode to Auto so Claude may run the checks:

```text
Run the checks now. Do not change any code yet. For every cause you name: which observation proves it, and which one rules out another hypothesis?
```

Claude queries the API and compares data. With the question about the observation you get evidence for every cause. A cause without evidence is only a guess.

### 5. Ask the git history

```text
Use the git history to find out when this behaviour came into the code. Name the commit, read its message and explain what the author wanted to achieve at the time.
```

A commit message and the code around it often tell you what the author wanted to achieve.

### 6. Ask for the cause and every affected place

Write the prompt yourself. What you want to reach: the cause in one or two sentences with file and line, plus every place in the code that the same cause affects, not only the one from the ticket. Claude should not change anything yet.

For example:

```text
Name the cause in one or two sentences with file and line. Then list every place in the code that is affected by the same cause, not only the one from the ticket. Change nothing yet.
```

### 7. Fix it with a test

```text
First write a test in api/test/ that shows the bug from the ticket, and run it. It must fail. Then fix the cause at every place on your list. Afterwards run all tests with npm test.
```

Claude writes the test, shows it red, fixes the bug and shows it green. Then stop the API with Ctrl+C, run `npm run db:reset`, restart it with `npm run dev:api` and repeat steps 1 and 2 in the browser.

### 8. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

You did not guess at a bug, you proved it: first reproduced, then checked hypotheses, then read the history. A test that was red before the fix and green after it shows that the fix works. A fix only at the place named in the ticket would hide the symptom instead. That is why you asked for all affected places in step 6.

**Done when** the "next volume" link of The Fellowship of the Ring works, saving a book in the admin no longer breaks a series, a new test covers the bug, `npm test` is green and everything is committed.

<details>
<summary>More</summary>

- If you start a new session in between, Claude has lost the history. Then include the ticket and your observations again.
- Claude's answers differ from run to run. Check a statement by running the check yourself.
- [Common workflows: Fix bugs](https://code.claude.com/docs/en/common-workflows) · [Best practices](https://code.claude.com/docs/en/best-practices) · [Permission modes](https://code.claude.com/docs/en/permission-modes)

</details>
