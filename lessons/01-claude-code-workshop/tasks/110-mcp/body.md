> **⚠️ Start the API first:** Open a **separate terminal window** and run `npx bookmonkey-api` there. Keep it open for the whole task, so the server runs locally on http://localhost:4730.

This task is about **MCP** (Model Context Protocol): it gives Claude extra tools, here a real browser. With it, Claude does not only check the code, it looks at the BookMonkey pages, clicks through them and reports what it found.

You work in your `bookmonkey` repository with Node.js 26. Two servers must run: the API with `npx bookmonkey-api` (http://localhost:4730) and the app with `npm run dev` (http://localhost:3000).

### 1. Connect a browser server

In the desktop app, open the terminal in the project folder and add the Playwright server. The list then shows whether it runs:

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest
claude mcp list
```

The list shows `playwright` with `Connected`. Now start a new session so Claude knows the browser tools. If Claude asks before the first browser call, allow it.

### 2. Let Claude walk through a journey

```text
Open http://localhost:3000/books in the browser. Search for "of", go to page 2 and back, open a Harry Potter book from the middle of the series and follow the links to the previous and next book in the series. At each step report what you see on the page: title, number of cards and address bar. Observations only, no verdict.
```

Claude drives the browser itself. In our run a table appeared afterwards, step by step. Asking for observations instead of a verdict gives you something you can check.

### 3. Check the phone view

```text
Open http://localhost:3000/books in a browser window of phone size (390 × 844). Go through the catalogue and open a book. Report what is cut off, overlapping or too small to tap. For each observation name the page and the element.
```

In our run this found cut-off titles and links under 44 px height, among other things. Your list can look different.

### 4. Fix one finding and check it again

Pick a finding from step 3. Claude should fix it and then measure in the browser whether it worked. You write the prompt yourself.

For example, if the "Next" link in the paging was also reported for you:

```text
Make the "Next" link in the catalogue paging bigger so it is easy to tap on a phone (at least 44 px high). Then check in the browser at 390 × 844 on http://localhost:3000/books how high the link is now and report the measured value.
```

### 5. Compare with curl

```text
How many books does the API at http://localhost:4730 have in total, and does /books?q=harry return status 200 there? Answer with curl only, without the browser.
```

curl is enough here: two calls, a short answer, and no browser window whose content ends up in the context.

### 6. Commit your state

The browser tools put screenshots into `.playwright-mcp/` in your project. They do not belong in the repository.

```text
Add .playwright-mcp/ to the .gitignore because the browser tools store their screenshots there. Then commit all changes from this task. Read the diff first.
```

### What just happened

| | Browser via MCP | curl |
|---|---|---|
| Shows | what a user sees: layout, clicks, navigation | status, headers, numbers |
| Cost in context | large, every page arrives as text or image | small |

The MCP server gives Claude tools it does not have by itself. The **results** of these tools end up in your conversation. So use the browser where what you see matters, and curl for everything a number or a status answers.

**Done when** `claude mcp list` shows the server `playwright` as connected, Claude has walked through a journey and the phone view in the browser, you fixed one finding and measured again, and `.playwright-mcp/` is in the `.gitignore`.

<details>
<summary>More on this</summary>

By default `claude mcp add` stores the server only for you and this project. With `--scope project` it goes into the `.mcp.json` in the project folder, so your team gets it through Git. By default Playwright opens a visible browser window, according to its docs.

[MCP in Claude Code](https://code.claude.com/docs/en/mcp), [Playwright MCP](https://github.com/microsoft/playwright-mcp)

</details>
