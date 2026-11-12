> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about **refactoring with a safety net**: you change the structure of code without changing its behaviour. The net is **characterisation tests**, tests that record what the code does today, even when it looks odd. Before you trust the net, you test it, and then you let a hook run the tests every time Claude stops. You work in your `bookmonkey-legacy` clone (Node.js 24 or newer).

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

In our run this produced one new test file with 58 tests, all green. Then ask Claude to commit the tests.

The codebase has bugs, and the tests are green anyway. That is intended: the net knows nothing about right or wrong, only about same or different.

### 4. Test the net by hand

You only know the net holds once you have seen it catch something. In the same session, let Claude change a behaviour on purpose:

```text
In api/routes.js, change the status code of GET /books/:isbn for an unknown book from 404 to 410. Do not change any tests and do not run any tests.
```

Claude reports that it is done. Now run `npm test` yourself in the terminal. In our run exactly one test turned red, the one that records the 404 for an unknown book.

Undo the change: `git restore api/routes.js` (the tests are already committed) or `/rewind` (`Esc` twice on empty input), select the prompt with the 410 change there and choose "Restore code". Afterwards `npm test` is green again.

If everything stayed green before, your net is missing this case. Ask Claude now to add a test for the 404 and commit it, and repeat the step.

### 5. Let the tests run automatically

In step 4 the prompt forbade testing, so only your own run showed the break. In daily work nobody forbids it, but a request like "test afterwards" also gets lost in a long session. A **Stop hook** runs every time Claude wants to stop, whatever the prompt says.

You do not have to read the long line below. It does three things: run `npm test`, block stopping when red (`exit 2`, which you know from task 120) and let the second attempt through (`stop_hook_active`), so Claude can still ask you and does not get stuck in a loop. Give Claude this prompt:

````text
Add exactly this Stop hook to .claude/settings.local.json and keep any existing entries:

{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "input=$(cat); case \"$input\" in *'\"stop_hook_active\":true'*|*'\"stop_hook_active\": true'*) exit 0;; esac; out=$(npm test 2>&1) || { printf '%s\\n' \"$out\" | tail -40 >&2; exit 2; }",
            "timeout": 120
          }
        ]
      }
    ]
  }
}
````

If Claude asks, allow it. The file does not belong in a commit.

Start a new session in Auto mode so the hook is loaded. Send the same prompt as in step 4; it still forbids tests. Predict first: what will happen?

In our run Claude first reported "done". Then the hook ran the tests, and Claude named the red characterisation test with file and line on its own. If the hook does not kick in for you, hint 5 helps. Undo the change again as in step 4, unless Claude already undid it itself.

The prompt forbade tests, the hook ran them anyway. An instruction applies to Claude, a hook applies to Claude Code.

### 6. Have a plan written

Start a new session in Plan mode.

```text
Plan the split of api/routes.js. Every endpoint whose path starts with /books, /reviews or /cart should move into its own files in api/routes/, following the pattern of the existing files there. The behaviour must not change. Give me small steps, each one leaving npm test green. Do not change anything yet.
```

### 7. Push back on the plan

Read the plan and write yourself what should be better, in the same session. The plan is a proposal, and now is the cheapest time to correct it. For example:

```text
The plan is too coarse. Do not change the order of routes, and anything that looks odd stays as it is and only goes on a list. Split the steps so that each step creates exactly one new file, and afterwards npm test is green and a commit is possible.
```

The plan comes back in smaller steps. Route order is part of the behaviour, so it stays the same.

### 8. Carry out the plan

Set the mode to Auto and stay in the same session.

```text
Carry out the plan now, step by step. Run npm test after each step and when green commit only the files of this step, never .claude/. Do not change any tests without asking me. If it is red, stop and ask me.
```

The prompt gives you clean commits between the steps, and the hook secures the end: Claude cannot report "done" with a red test. If Claude stops to ask you when red, the hook blocks that once and lets the second attempt through. If Claude starts fixing things itself instead, interrupt with `Esc`. In our run this produced six commits with new files in `api/routes/`, and `npm test` stayed green after each. If a test turns red, you decide: did the refactoring break something, or did the test record something wrong?

### 9. Check the diff

Start a new session so Claude reads without bias.

```text
Read the diff of this branch against main (git diff main). Was anything about behaviour changed besides the moving, including the order of routes? Name every deviation with file, or say clearly that you found none.
```

Check yourself with `git log --oneline` that the commits are there.

### 10. Clean up and return to main

In later tasks the hook would run `npm test` every time Claude stops. Remove it:

```text
Remove the Stop hook from .claude/settings.local.json and keep all other entries.
```

```bash
git switch main
```

The later tasks start from `main`. Your branch is kept.

### What just happened

The tests were written before the structure changed, so every green run means the behaviour stayed the same. In step 4 you saw that the net really catches a change. In step 5 a hook ran the tests without anyone having to remember, even against the prompt. A refactoring that also changes behaviour is no longer a refactoring. What looked odd therefore belongs on a list, not in the diff.

**Done when**

- the deliberate change has turned a test red, first with your own `npm test`, then through the hook,
- `refactor/split-routes` has commits with the tests and the new files in `api/routes/` and `npm test` is green there,
- the hook is removed and you are back on `main`.

<details>
<summary>More</summary>

- Renaming a single symbol or extracting a method is usually faster in the IDE than with an agent. The agent pays off where reading and judgement are needed.
- Hooks in detail, including `exit 2` and `PreToolUse`/`PostToolUse`: task 120 and [Hooks](https://code.claude.com/docs/en/hooks)
- Code intelligence: with a language server plugin Claude can, according to the docs, jump to definitions and find references instead of searching. This task does not use LSP or such a plugin: [Code intelligence plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Undo: [Checkpointing](https://code.claude.com/docs/en/checkpointing) and git. Refactoring patterns: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
