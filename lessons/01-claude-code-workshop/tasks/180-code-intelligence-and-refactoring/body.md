> **✅ No server needed:** you do not have to start anything before this task.

---

You restructure code without changing its behaviour. The safety net is **characterisation tests**: they record what the code does today. You work in your `bookmonkey-legacy` clone (Node.js 24 or newer).

### 1. Create a branch

```bash
git switch -c refactor/split-routes
```

### 2. Map the ground

New session, Plan mode:

```text
We want to split api/routes.js by resource, the way api/routes/ has already started. Do not change anything yet. Show me a table of every endpoint of the resources books, reviews and cart, with file and line.
```

Only note what Claude reports as odd. The order of the routes is part of the behaviour.

### 3. Write the characterisation tests

New session, Auto mode:

```text
Write characterisation tests for every endpoint in api/routes.js whose path starts with /books, /reviews or /cart. The tests record what the code does today, even if it looks odd: status code and response shape, also for errors, with and without login, as a normal user and as admin. Use the existing node:test setup in api/test/ and do not change production code. Then run npm test, report briefly and commit the tests.
```

In our run: 58 tests, all green, although the codebase has bugs. The net knows nothing about right or wrong, only about same or different.

### 4. Test the net by hand

In the same session:

```text
In api/routes.js, change the status code of GET /books/:isbn for an unknown book from 404 to 410. Do not change any tests and do not run any tests.
```

Claude reports "done". Run `npm test` yourself. In our run one test turned red. If everything stays green, the net is missing this case. Undo: `git restore api/routes.js`.

### 5. Let the tests run automatically

A **Stop hook** runs `npm test` as soon as Claude wants to stop. When red, Claude may not stop (`exit 2`, task 120). Let Claude add it:

```text
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
```

New session, Auto mode, the prompt from step 4. Guess first what will happen. In our run Claude reported "done", the hook tested anyway, and Claude named the red test. Then `git restore api/routes.js`. Do not commit `.claude/settings.local.json`.

### 6. Plan and push back

New session, Plan mode:

```text
Plan the split of api/routes.js. Every endpoint whose path starts with /books, /reviews or /cart should move into its own files in api/routes/, following the pattern of the existing files there. The behaviour must not change. Do not change anything yet.
```

Read the plan and correct it in the same session, for example:

```text
Do not change the order of routes. Anything that looks odd stays and only goes on a list. Each step creates exactly one new file, and afterwards npm test is green.
```

### 7. Carry out the plan

Auto mode, same session:

```text
Carry out the plan step by step. Run npm test after each step and when green commit only the files of this step, never .claude/. Do not change any tests without asking me. If it is red, stop and ask me.
```

In our run: six commits, green after each. The hook makes sure Claude does not report "done" with a red test. If a test turns red, you decide: did the refactoring break something, or did the test record something wrong?

### 8. Clean up

```text
Remove the Stop hook from .claude/settings.local.json and keep all other entries.
```

```bash
git switch main
```

Otherwise the hook runs at every stop in later tasks. Your branch is kept.

**Done when**

- the deliberate change has turned a test red, first with your own `npm test`, then through the hook,
- `refactor/split-routes` has commits with the tests and the new files in `api/routes/` and `npm test` is green there,
- the hook is removed and you are back on `main`.

<details>
<summary>More</summary>

- Diff review at the end: let a new session read `git diff main` and name every change in behaviour.
- Renaming a single symbol or extracting a method is usually faster in the IDE than with an agent. The agent pays off where reading and judgement are needed.
- Hooks in detail: task 120 and [Hooks](https://code.claude.com/docs/en/hooks)
- Code intelligence: with a language server plugin Claude can, according to the docs, jump to definitions and find references instead of searching. This task does not use LSP or such a plugin: [Code intelligence plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Undo: [Checkpointing](https://code.claude.com/docs/en/checkpointing) and git. Refactoring patterns: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
