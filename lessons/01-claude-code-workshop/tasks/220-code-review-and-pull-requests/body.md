In this task you review a colleague's pull request with **/code-review** and your own **security subagent**, a helper with its own context that may only read. Dana's branch `feature/admin-export-v2` adds a CSV export, the tests are green, and Dana is in a hurry.

You work in your `bookmonkey-legacy` clone (Node.js 24 or newer). If `git status` is not clean, run `git stash` first. If the API is still running from the debugging task, stop it first with Ctrl+C.

### 1. Get Dana's branch

```bash
git fetch origin
git switch -c review/admin-export-v2 origin/feature/admin-export-v2
git merge --no-edit main
npm run db:reset
```

The merge pulls your `CLAUDE.md` and settings from `main` into the review branch. The diff `main...review/admin-export-v2` with three dots still shows only what Dana changed. In a second terminal start the API with `npm run dev:api` (http://localhost:4780). You do not need the web app.

### 2. Create the security subagent

Start a new session in this folder and send:

```text
Create a subagent security-reviewer as the file .claude/agents/security-reviewer.md. It may only read (Read, Grep, Glob), never change anything. It reviews a diff for security problems and gives, for each finding, the severity, file and line, how to exploit it, and a suggested fix.
```

Claude writes the file. A session loads subagents at start, so you need a new session afterwards.

### 3. Let Claude explain the change

Start a new session and send:

```text
Explain the changes of main...review/admin-export-v2 to me: what does the feature do, who uses it, which files are affected? Also run npm test.
```

You get a summary, and the tests are green. Green only means that what is tested passes.

### 4. Start the correctness review

```text
/code-review main...review/admin-export-v2
```

This takes a while. Meanwhile read the diff yourself (`git diff main...review/admin-export-v2` in the terminal) and note what you would object to.

### 5. Call the security subagent

```text
@agent-security-reviewer review the changes of main...review/admin-export-v2. Give it the diff.
```

The subagent reads in its own context, and only its report comes back.

### 6. Check on the running code yourself

A diff shows what changes, not how the feature is used. Write a prompt yourself that makes Claude test Dana's assumptions on the running code, not only in the diff, and that forbids changing anything.

For example:

```text
Which assumptions does Dana's code make? Check each one on the running code, not only in the diff. Change nothing.
```

### 7. Triage and reproduce

**Triage** means giving every finding a verdict: real, false positive or discuss. Send:

```text
Put all findings from this session into a table: finding, source, verdict (real, false positive or discuss), severity, reason. Only say "real" if you proved it on the running code.
```

Add your own list and anything missing from the table. For the most serious "real" one send:

```text
Show me, for the most serious real finding, a call that I can run myself in the terminal so I can see it with my own eyes. The API is already running. Run it once and show the output.
```

Run the call yourself in the terminal. Claude may create test data on the way. Stop the API and run `npm run db:reset`, then they are gone.

### 8. Write the review for Dana

```text
From the table, write a review for Dana the way I would post it in the pull request: blocking points first, each with a suggested fix, then non-blocking remarks. End with one sentence: approve or not, and why. Do not change any code.
```

Rework the draft in your own words.

### What just happened

Three reviewers read the same diff: `/code-review`, the subagent and you. Each finds something different, and each can claim something wrong. A finding is only a hint, the reproduction turns it into a verdict. Whoever approves the pull request is responsible for it afterwards.

**Done when** you have a written review with blocking points first, have reproduced at least one finding yourself in the terminal, and can say whether you would approve the PR.

<details>
<summary>More</summary>

- `/code-review` (effort levels, `--fix`, `--comment`): https://code.claude.com/docs/en/code-review-local
- `/security-review` (according to the docs, against the default branch of `origin`): https://code.claude.com/docs/en/commands
- Subagents: https://code.claude.com/docs/en/sub-agents
- OWASP Top Ten: https://owasp.org/www-project-top-ten/

</details>
