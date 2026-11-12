> **⚠️ Start the API first:** Open a **separate terminal window** and run `npx bookmonkey-api` there. Keep it open for the whole task, so the server runs locally on http://localhost:4730.

This task is about **autonomous runs with `/goal`**: you give Claude a condition that can be checked, and Claude keeps working turn after turn until it holds. It finishes your NestJS backend against the contract tests, inside its own **worktree** (a second working folder with its own branch, so your main folder stays untouched).

You work in your `bookmonkey` repository with Node.js 26. Start the API in one terminal with `npx bookmonkey-api` (http://localhost:4730) and the backend in a second one with `cd backend && npm run start:dev` (http://localhost:3001).

### 1. Write the goal as tests

So far your backend can only read, create and delete single books. Claude should build the list `GET /books`, and you decide beforehand when it is done. Write the prompt yourself: Claude should add contract tests for search (`q`), paging (`_page`, `_limit`), sorting (`_sort`, `_order`) and the `X-Total-Count` header, and check them against the reference API on port 4730.

First reset the API data, because you created books there in the skills task: `curl -X POST http://localhost:4730/dev/reset`.

For example:

```text
Add contract tests for GET /books: search with q, paging with _page and _limit, sorting with _sort and _order, and the X-Total-Count header. The reference API has 50 books, one test should check that. Run the tests against http://localhost:4730. If a new test fails, fix the test, not the API. Do not change the backend.
```

In our run 14 new tests were added, all green against the API.

### 2. Commit and push the tests

A worktree starts at the state of `main` on `origin`, or at the last local commit if there is no remote. Uncommitted or unpushed files are missing there.

```text
Commit the new contract tests on main and push if there is a remote. Read the diff first.
```

### 3. See the tests red

In the root folder run `API_URL=http://localhost:3001 npm run contract` (PowerShell: `$env:API_URL="http://localhost:3001"; npm run contract`). In our run 14 of 31 tests failed.

### 4. Give Claude the goal

Stop the backend in the second terminal, Claude starts its own in the worktree. In the desktop app, open the terminal in the project folder and run `claude --worktree contract-run --permission-mode auto` there. **Auto mode** means Claude does not ask for every command. Send there:

```text
/goal npm run contract with API_URL=http://localhost:3001 exits with code 0. First install the dependencies in backend/ and contract-tests/. Start the backend yourself from this folder with PORT=3001 and stop it afterwards. The data stays in memory: on start the backend loads all books from http://localhost:4730/books. Files under contract-tests/ stay unchanged. Stop after 20 turns.
```

The goal has three parts: a measurable end state, a constraint (the tests stay as they are) and a limit on rounds (turns). After that Claude works without questions. In our run it took 17 steps in just under three minutes. The type-check hook reported `PageProps` and `LayoutProps` from the frontend along the way, which has nothing to do with the backend.

### 5. Read the diff, then save it

First look at what Claude changed yourself. Then send in the same session:

```text
Read the diff in this worktree and summarize in three sentences what changed and what the contract tests do not cover. Then commit the changes on this branch.
```

### 6. Take over the work

This is your checkpoint: only what you have read and would answer for goes into `main`. End the session in the terminal with `/exit`. If Claude Code asks whether to keep the worktree, keep it. Then start a new session in the main folder and send:

```text
Merge the branch worktree-contract-run into main and clean up the worktree afterwards.
```

### 7. Switch the app over

Start the backend again (`cd backend && npm run start:dev`). Set `NEXT_PUBLIC_API_URL=http://localhost:3001` in `.env.local`, restart `npm run dev` and open http://localhost:3000/books. The catalog now shows the books from your own backend. In our run the covers still came from the API on port 4730, because the backend took over their addresses, and `/login` answered 404. Signing in only works again once you set the value back to http://localhost:4730.

### What just happened

The contract tests were the goal, `/goal` kept Claude working until they were green. **Auto mode** removes the question per command, `/goal` removes the question per round. They work independently of each other. Green only means the contract is met: login was not in it, so it is missing. Whoever defines the goal decides what "done" means.

**Done when** `npm run contract` is green against port 4730 and against your backend on port 3001, the branch is merged and the catalog shows books from your backend.

<details>
<summary>More</summary>

According to the [docs](https://code.claude.com/docs/en/worktrees) the desktop app has its own option for worktrees. According to the docs a separate model checks after every round whether the condition holds, and the turn limit is judged from the conversation, not a hard limit. `/goal` shows the status, `/goal clear` stops it. `curl -X POST http://localhost:4730/dev/reset` restores the API data.

- Goal: https://code.claude.com/docs/en/goal
- Worktrees: https://code.claude.com/docs/en/worktrees
- Permission modes: https://code.claude.com/docs/en/permission-modes
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md

</details>
