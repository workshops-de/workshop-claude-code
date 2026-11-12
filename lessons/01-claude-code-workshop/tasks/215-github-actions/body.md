> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about the **GitHub Action for Claude Code**: a workflow starts Claude on a GitHub server as soon as someone puts a label on an issue, and Claude replies in the issue. The trainer shows the run on GitHub live. You rebuild it locally, see what Claude may do there, and restrict it.

You work in your `bookmonkey-legacy` clone with Node.js 24. You type the `claude -p` commands in the terminal of the desktop app (on Windows in Git Bash).

### 1. Let Claude explain the workflow

Start a new session and send:

```text
Explain .github/workflows/claude-issue.yml: when does the workflow run, which permissions does it have, what may Claude do per label? Where does the workflow allow more than the prompt asks for?
```

Anyone using this workflow on GitHub gives it credentials, so it pays to look. In our run Claude named several places. Read them and remember one.

### 2. Replay the run locally

The action calls Claude with a prompt and a list of allowed tools. You can reproduce that. The prompt and tool list roughly match what the workflow makes of an issue:

```text
claude -p 'Issue #1: "Download the wishlist as CSV". Read the codebase. Answer with: 1. Feasibility (easy, medium, hard) and why. 2. Affected files with line ranges. 3. Likely cause, if the issue describes a defect, use the git history where it helps. 4. Risks and what to test. Do not change any files.' --max-turns 30 --allowedTools "Read,Grep,Glob,Bash(git log:*),Bash(git show:*),Bash(git blame:*),Bash(npm test:*)"
```

In our run this took just under a minute and changed nothing. Check one statement of the answer against the code: is the file right, is the line range right?

### 3. Test the boundary

On the server nobody is asked what Claude may do. Anything that would need approval and is not on the list is refused:

```text
claude -p 'Create a file hallo.txt with the content "Hallo". Then read git log -1.' --max-turns 15 --allowedTools "Read,Grep,Glob,Bash(git log:*)"
```

In our run `hallo.txt` was not created, `git log -1` ran.

### 4. Restrict the workflow

Tell Claude in your own words what the workflow should get less of. Goal: a run that may only do, and costs only, what it needs. Take a place from step 1.

For example:

```text
The workflow gives an analyse run more than it needs. Remove the tool you just named as unnecessary and halve --max-turns and timeout-minutes. Change nothing else, then show me the diff.
```

Read the diff. In our run Claude pointed out that the change also applies to the label `implement`, because both labels use the same job. Only a real run shows whether the change works on GitHub. Here you check the diff.

### 5. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

The action is a `claude -p` call on a GitHub server: the prompt comes from the issue, `--allowedTools` sets what runs without asking, `--max-turns` and `timeout-minutes` limit duration and cost. Title and text of the issue end up in the prompt, so the list should contain only what the mode needs. You check what Claude writes in an issue like any review.

**Done when** you replayed the run locally, checked one statement of Claude against the code, and your workflow change is committed.

<details>
<summary>More</summary>

- On GitHub the workflow needs, according to the docs, the Claude GitHub App in the repository and a secret (`CLAUDE_CODE_OAUTH_TOKEN` from `claude setup-token`, or `ANTHROPIC_API_KEY`). `/install-github-app` sets this up in a guided way. Every run uses your Claude plan or is billed to your API key. If you want to try it yourself, fork the repository, enable Actions and Issues in the fork and create the labels `analyse` and `implement`. Clean up the secret and the app access afterwards.
- [GitHub Actions](https://code.claude.com/docs/en/github-actions) · [Action inputs](https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md) · [Authentication](https://code.claude.com/docs/en/authentication)

</details>
