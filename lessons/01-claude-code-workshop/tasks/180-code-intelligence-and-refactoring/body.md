> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about **refactoring with a safety net**: you change the structure of code without changing its behaviour. The net is **characterisation tests**, tests that record what the code does today, even when it looks odd. You work in your `bookmonkey-legacy` clone (Node.js 24 or newer).

### 1. Create a branch

In the desktop app, open the terminal in the project folder:

```bash
git switch -c refactor/split-routes
```

Everything else happens on this branch, so `main` stays untouched.

### 2. Map the ground

Start a new session and set the mode to Plan. Claude then only reads and changes nothing.

```text
We want to split api/routes.js by resource, the way api/routes/ has already started. Do not change anything yet. Show me a table of every endpoint of the resources books, reviews and cart, with file and line.
```

You get a table of all endpoints. The order in the file is part of the behaviour. Note anything Claude reports as odd. You do not change it in this task.

### 3. Write the characterisation tests

Start a new session in Auto mode.

```text
Write characterisation tests for every endpoint in api/routes.js whose path starts with /books, /reviews or /cart. The tests record what the code does today, even if it looks odd: status code and response shape, also for errors, with and without login, as a normal user and as admin. Use the existing node:test setup in api/test/ and do not change production code. Then run npm test and report briefly.
```

In our run this produced one new test file with 58 tests, all green. Then ask Claude to commit the tests. Only now do you have a net.

### 4. Have a plan written

Start a new session in Plan mode.

```text
Plan the split of api/routes.js. Every endpoint whose path starts with /books, /reviews or /cart should move into its own files in api/routes/, following the pattern of the existing files there. The behaviour must not change. Give me small steps, each one leaving npm test green. Do not change anything yet.
```

### 5. Push back on the plan

Read the plan and write yourself what should be better, in the same session. The plan is a proposal, and now is the cheapest time to correct it. For example:

```text
The plan is too coarse. Do not change the order of routes, and anything that looks odd stays as it is and only goes on a list. Split the steps so that each step creates exactly one new file, and afterwards npm test is green and a commit is possible.
```

The plan comes back in smaller steps. Route order is part of the behaviour, so it stays the same.

### 6. Carry out the plan

Set the mode to Auto and stay in the same session.

```text
Carry out the plan now, step by step. Run npm test after each step and commit when green. If it is red, stop and ask me.
```

In our run this produced six commits with new files in `api/routes/`, and `npm test` stayed green after each. If a test turns red, you decide: did the refactoring break something, or did the test record something wrong?

### 7. Check the diff

Start a new session so Claude reads without bias.

```text
Read the diff of this branch against main (git diff main). Was anything about behaviour changed besides the moving, including the order of routes? Name every deviation with file, or say clearly that you found none.
```

Check the answer yourself: `git log --oneline` shows the commits, and `npm test` must be green.

### 8. Return to main

```bash
git switch main
```

The later tasks start from `main`. Your branch is kept.

### What just happened

The tests were written before the structure changed, so every green run means the behaviour stayed the same. Plan mode broke the work into steps you could correct beforehand. A refactoring that also changes behaviour is no longer a refactoring. What looked odd therefore belongs on a list, not in the diff.

**Done when** `refactor/split-routes` has several commits with the tests and the new files in `api/routes/`, `npm test` is green there, and you are back on `main`.

<details>
<summary>More</summary>

- Renaming a single symbol or extracting a method is usually faster in the IDE than with an agent. The agent pays off where reading and judgement are needed.
- Code intelligence: with a language server plugin Claude can, according to the docs, jump to definitions and find references instead of searching. This task does not use LSP or such a plugin: [Code intelligence plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Undo: [Checkpointing](https://code.claude.com/docs/en/checkpointing) and git. Refactoring patterns: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
