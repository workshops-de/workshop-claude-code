## Bonus: the refactoring in the sandbox

In Auto mode Claude runs commands without asking. A sandbox limits what those commands may access (task 030, step 7). Here you see what it blocks in a real project and how to allow exactly that one thing. Do the bonus before step 8, while the Stop hook is still in place.

1. **Turn the sandbox on for this repo only.** This works the same in the desktop app and in the terminal, through the file from step 5. We tested both: both read the sandbox entries from this file, including `allowLocalBinding` from point 4. Write:

   ```text
   Add this entry to .claude/settings.local.json and keep any existing entries: "sandbox": { "enabled": true, "allowUnsandboxedCommands": false }
   ```

   The desktop app also has the switch **Settings → Local sandbox**. It applies to all new sessions in all projects, though, and it does not have the network setting from point 4. That is why you use the file here.

2. **Run the tests in the sandbox.** Predict what happens first. Then start a new session and write:

   ```text
   Run npm test exactly once and give me the lines with tests, pass and fail, plus every line with EPERM. Do not change anything.
   ```

   In our run the tests failed with `listen EPERM: operation not permitted`: they start a server, and the sandbox forbids opening a port.

3. **Look at the hook.** Claude's `npm test` just failed with `EPERM`. Did the Stop hook still let Claude stop? Hooks run outside the sandbox: in our run the hook's `npm test` was green, and Claude was allowed to stop. What does that mean for a hook you trust with safety?

4. **Allow exactly that.** Add `"network": { "allowLocalBinding": true }` to the sandbox entry, start a new session and send the same prompt. In our runs on macOS, in the desktop app and in the terminal, all tests were green afterwards, as without the sandbox. According to the docs `allowLocalBinding` only works on macOS. On Linux and WSL2 use `excludedCommands` instead (see [Sandboxing](https://code.claude.com/docs/en/sandboxing)).

5. **Clean up:** remove the sandbox entry from `.claude/settings.local.json` again, or it also applies in the later tasks. If you turned on the **Local sandbox** switch, turn it off again: it applies to all new sessions, and tests that start a server fail there with `EPERM`.

Native Windows has no sandbox, WSL2 does.

## Going further: code intelligence (Language Server Protocol)

Large or unfamiliar refactors are where **code intelligence** earns its keep. A code-intelligence
plugin connects Claude to a **language server** so it can jump to a symbol's definition, find all
references, and surface type errors directly instead of reading and grepping through files.

Try installing the language-server plugin for your stack (for example
`/plugin install typescript-lsp@claude-plugins-official`), then ask Claude to find every caller of
a function and rename it and compare the experience to a grep-and-read refactor.
