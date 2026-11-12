## Learning goals

- **Feature:** plan mode for large changes, characterisation tests as a safety net, a Stop hook
  that triggers the net automatically, small verified steps with commits, `/rewind`, optional
  sandbox and code intelligence.
- **Concepts:** refactoring vs. rewriting; behaviour preservation; inventory before change;
  separating "refactor" from "fix"; test a net before you trust it; a request in the prompt vs. a
  hook.
- **Takeaways:** delegate judgement-heavy refactors; pin behaviour before you move code; "the net
  knows nothing about right or wrong, only about same or different"; what must always happen
  belongs in a hook; you own the diff.

## Facilitation notes

- This opens "Quality & Automation". Set the frame: the rest of the block is about making quality
  systematic.
- The codebase has known bugs, and the characterisation tests are green anyway. That is the key
  sentence for step 3: the net reports changes, not bugs. Bugs found go on the list for the
  debugging and code review tasks.
- Step 4 is the aha moment: Claude reports "done", and only your own `npm test` shows the break. If
  everything stays green for someone, the task is not broken, their net has a gap. That insight is
  exactly what is valuable.
- Step 5 builds on task 120: there Claude built hooks, here participants get a finished one.
  Reason: when we let Claude build the Stop hook itself, it wrote a debug file to `/tmp` and added
  no protection against endless loops. The given hook lets the second stop through
  (`stop_hook_active`), so Claude can still ask when red in step 7.
- `.claude/settings.local.json` is not in the repo's `.gitignore`. Make sure nobody commits the
  file and that everyone removes the hook in step 8. Otherwise `npm test` runs at every stop in
  later tasks, including the debugging task.
- The task undoes with `git restore`. Optionally show `/rewind` (or `Esc` twice) once live in step 4
  as the alternative that also works for uncommitted edits by Claude's file tools.
- Do not hand out the list of odd places. The inventory is the learning. The complete list and the
  notes on what the tests should reveal are in the private trainer repo
  (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- Expect the agent to "improve" things on the way. That is the most important discussion: a
  refactor that also changes behaviour is no longer a refactor.
- Participants who work on their own codebase need a test command that runs in under a minute;
  check that before they start. The Stop hook runs it at every stop.
- The sandbox bonus shows two things: it also blocks something harmless (a local port), and hooks
  run outside it. The question in point 3 works well for the debrief.
- If your organization has an LSP plugin available, a live before/after (grep-based vs.
  code-intelligence-based inventory) is a strong demo.

## Tested

On 12 Nov with Claude Code 2.1.319 and Sonnet via `claude -p` in a copy of `bookmonkey-legacy`
on macOS, Node 24.11, without personal settings (`--setting-sources project,local`):

- Step 4: after the change from 404 to 410, exactly the characterisation test for the unknown book
  turned red.
- Step 5: Claude first reported "done", the Stop hook blocked, Claude named the red test with file
  and line and stopped on the second attempt.
- Bonus: sandbox on gives `listen EPERM`, with `allowLocalBinding` all tests are green. The Stop
  hook stayed green inside the sandbox.

Desktop app (12 Nov, Sonnet, copy of the repo): the Stop hook from `.claude/settings.local.json`
fired and blocked when red. The sandbox was active (writing to the home folder failed), and with
`allowLocalBinding` from the file all tests were green. The app uses the shell's default Node
version (with nvm: `nvm alias default`), not the terminal's. When that was Node 22, tests and hook
failed with a `SyntaxError`. Have the group check `node -v` in a session before step 3. A new,
unknown folder with a hook in `.claude/settings.local.json` triggered the app's "Trust this
workspace?" prompt. The participants' own clone is already trusted.

`/rewind` (desktop app, test folder): "Restore code" brought back Edit and Write changes, even on an
already committed file (afterwards an uncommitted change). Bash changes (`sed`, `echo`, `rm`) and the
commit stayed. So it works for step 4, because Claude changes the file with Edit there.

## Time estimate

~70 minutes: 10 inventory, 15 characterisation tests, 15 testing the net and the hook, 25 plan and
refactor, 5 debrief. If time runs short, say out loud that a clean partial step with green tests
counts as success. Groups that finish early take the bonus before step 8.
