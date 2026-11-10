This task is about **subagents**. A subagent is a second Claude with its own context. It does a task apart from your conversation and hands back only the result. You build the sign-in for BookMonkey and let your own security reviewer check it.

Work in your `bookmonkey` repository with Node.js 26. The API (`npx bookmonkey-api`) runs on http://localhost:4730, the demo user is `admin@bookmonkey.api` with `password1!`.

### 1. Build the sign-in

```text
Build sign-in, sign-up and sign-out against the bookmonkey-api (POST /login and POST /register). The token goes into a signed http-only cookie set on the server, not into localStorage. If .env.local has no SESSION_SECRET, generate one and add it there, and without a value to .env.example. A guard in proxy.ts redirects the area under /library to /login. Keep it small, check with npm run build.
```

The cookie stores the sign-in so that JavaScript in the browser cannot read it. The guard sends everyone who is not signed in to `/login`.

Stop any dev server that is still running and start the app with `npm run dev`, so it reads the new `.env.local`. Open http://localhost:3000/library: without signing in you land on `/login`. Sign in there.

### 2. Let Claude create a reviewer

```text
Create a subagent security-reviewer in .claude/agents/. It checks sign-in, session cookie and guard for security problems, may only read and must never change files. Its description should say that it is used after changes to the sign-in code.
```

Then open the new file `.claude/agents/security-reviewer.md`. In our runs, `tools` lists only `Read`, `Grep` and `Glob`. Without `Edit`, `Write` and `Bash` the reviewer cannot change anything.

### 3. Start a new session

A new session makes sure the reviewer is loaded.

### 4. Call the reviewer

```text
@agent-security-reviewer Review the sign-in. List the findings by severity with file and line, and say for each whether the spot is in our code or in the bookmonkey-api, which we cannot change.
```

Claude starts the subagent, the reviewer reads the files and your conversation stays small. At the end there is a list of findings. The details differ from run to run.

### 5. Judge the findings yourself

Pick one finding that seems plausible to you and one you think is exaggerated. Tell Claude in your own words what you want to do with each: fix it, do it later or reject it. You write the prompt yourself.

### 6. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

| | Main session | Subagent |
|---|---|---|
| Context | your conversation | its own, empty context |
| Tools | all | only those in `tools` |
| Returns | | a summary |

Everything the reviewer reads along the way stays with it. Claude picks subagents by their `description`, with `@agent-name` you force one. Whether a finding is true is for you to check.

**Done when** you have called the `security-reviewer`, seen its findings and decided what happens with at least one of them.

<details>
<summary>More</summary>

If the reviewer is reported as unknown, start a new session. If you registered users while testing, `curl -X POST http://localhost:4730/dev/reset` removes them again.

[Subagents](https://code.claude.com/docs/en/sub-agents)

</details>
