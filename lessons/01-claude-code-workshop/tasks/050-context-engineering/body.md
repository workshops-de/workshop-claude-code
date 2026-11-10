This task is about the **context window**: everything Claude reads in a session stays in it and takes up space. You fill it on purpose, **compact** it, and then restart with a **new session**.

You work in your `bookmonkey-legacy` clone (Node.js 24). If the project has no `CLAUDE.md` yet, type `/init` in a session.

### 1. Ask a question you can check later

```text
Which file and function extend a loan, and what are the renewal rules? Keep the answer short.
```

Claude names a function with a line reference and the rules. Copy the answer, it is your reference.

### 2. Pollute the session

Stay in the same session and give Claude a lot to read:

```text
Read api/routes.js completely with the Read tool and summarize each section in two sentences.
```

```text
Now read api/seed/books.json and then every file under api/services, api/lib and api/test with the Read tool. Only tell me how many files you read.
```

In our run that was about 40 files. The session is now much bigger than after step 1.

### 3. Ask again

```text
Which file and function extend a loan, and what are the renewal rules? Keep the answer short. And: which lines of api/routes.js belong to the route POST /loans/:id/renew?
```

Compare with step 1. In our runs the answer stayed correct, the session was just much bigger. Errors show up later, in even longer sessions.

### 4. Compact

```text
/compact Keep the renewal rules for loans and the files they are in.
```

Claude summarizes the conversation and continues with the summary. Afterwards ask about something that only existed in the conversation, for example: `How many files under api/test did you read earlier?` Check the answer with `ls api/test`. In one run Claude gave a wrong number before and the right one afterwards; this may differ for you. So you see what the summary keeps, and you must verify details.

### 5. Restart

Start a **new session** for a task that has nothing to do with the old one:

```text
Briefly explain the routing of the web app.
```

The new session begins without the old reading material.

### 6. Keep the reading out of your session

Write a prompt yourself: Claude should go through all migration files in `api/migrations` and give you one line per file, without the full content landing in your session.

### What just happened

| Lever | When |
|---|---|
| `/compact` with focus | The same task continues, the window gets full |
| New session | The next task is independent |
| Subagent | Lots of reading, little result |

A subagent reads in its own context and returns only the answer. In our run it delivered a table with one line per migration.

**Done when** you have polluted, compacted and restarted the session and can say when you use each lever.

<details>
<summary>More</summary>

The fill level is shown by `/context` (we did not test it here, see the docs). `/btw` asks a side question without adding it to the conversation. More in the docs: [Commands](https://code.claude.com/docs/en/commands), [Costs and context usage](https://code.claude.com/docs/en/costs), [Best practices](https://code.claude.com/docs/en/best-practices).

</details>
