> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about **headless mode**: Claude runs without a chat window. You start it with `claude -p` in a terminal or from a script and get the answer back as text. This is how you build Claude into scripts and, later, into pipelines.

You work in your `bookmonkey-legacy` repository with Node.js 24. Open the terminal in the desktop app. You type all `claude -p` commands there. On Windows use Git Bash. Check with `jq --version` that jq is installed, otherwise `brew install jq` or on Windows `winget install jqlang.jq`.

### 1. Ask a question without a chat

```text
claude -p "How is this project structured? Answer in three sentences."
```

The answer appears in the terminal, then Claude exits.

### 2. Pipe a diff in

```text
git diff origin/main...origin/feature/admin-export-v2 | claude -p "Summarize this diff in three bullet points: what changed and what is risky?" > summary.md
```

Whatever stands before the `|` is Claude's input. The `>` writes the answer into the file `summary.md`. Open it.

### 3. Get an answer a script can read

```text
git diff origin/main...origin/feature/admin-export-v2 | claude -p "Check this diff for problems. Return a verdict and a list of problems." --output-format json --json-schema '{"type":"object","properties":{"urteil":{"type":"string","enum":["ok","bedenklich"]},"probleme":{"type":"array","items":{"type":"string"}}},"required":["urteil","probleme"]}' | jq .structured_output
```

The schema defines which fields the answer has. You get no running text, but a verdict (`urteil`) and a list (`probleme`) that `jq` reads out. The field is called `structured_output`.

### 4. Let Claude build a script from it

Start a new session in the desktop app and enter this prompt:

```text
Write a shell script review.sh in the project folder. It takes a branch as an argument, pipes the diff from origin/main to that branch into claude -p and lets Claude check it for problems. The answer must be JSON with a schema: urteil (ok or bedenklich) and probleme (list). The script prints the problems readably (jq is installed) and ends with exit code 1 if the verdict is bedenklich. Claude may only use Read, Grep and Glob in that run. Make the script executable.
```

Nobody answers questions inside a script. That is why the allowed tools are fixed in advance. Read the script before you run it.

### 5. Run the script

```text
./review.sh origin/feature/admin-export-v2; echo "Exit code: $?"
```

You see the verdict, the problems and finally the **exit code**, a number other programs use to tell whether something succeeded. The script takes a moment.

### 6. Let every push run the check

Now the script goes to work. It helps most when it runs by itself. A **Git hook** is a script that Git starts at a fixed moment, here before every `git push`. If it ends with an exit code other than 0, Git stops the push. It is not a Claude Code hook like in task 120: Git starts it, not Claude.

First prepare a place to test, so nothing reaches your real remote:

```text
git init --bare ../test-remote.git
git remote add test ../test-remote.git
git checkout -b admin-export origin/feature/admin-export-v2
```

`git init --bare` creates an empty repository without a working folder that accepts pushes like a server (not the same as `claude --bare`). Then give Claude this prompt:

```text
I want every push of my branch to run through review.sh first. If the verdict is bedenklich, the push must be stopped, so nobody pushes unchecked code by accident. Set this up in this repo and show me afterwards that it works. To try it, push my branch admin-export to the remote test, never to origin.
```

<details>
<summary>🔑 Technical terms to steer</summary>

If Claude builds something else:

- **Git hook `pre-push`**: runs before the push, not after a commit
- Exit code **not 0** stops the push
- Hooks in `.git/hooks` are **not committed**; a folder in the repo plus `git config core.hooksPath` can be shared, but each person sets `core.hooksPath` themselves
- **`git push --no-verify`** skips the hook

</details>

The push of `admin-export` should stop with the verdict and the list of problems. Then run `git push --no-verify test admin-export` yourself: it goes through. That is why the same check later also runs on the server (task 215). If you have time, let Claude also push a branch without changes to `test` (`git checkout -b clean origin/main`): it goes through. Afterwards go back with `git checkout main`. Never push these test branches to `origin`.

In our run (Claude Code 2.1.323, Sonnet) Claude created the hook in a folder `.githooks` and set `core.hooksPath`. The push of the PR branch stopped, nothing arrived on the test remote, and the unchanged branch went through. If Claude puts the hook somewhere else, that is fine as long as the push stops.

Think about where such a check belongs. A check that takes this long fits `pre-push`, not `pre-commit`, because you commit often and push rarely. And the AI verdict changes from run to run, so you need an exit like `--no-verify`.

### 7. Commit your state

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### What just happened

`claude -p` turns Claude into a command line program: input by pipe, output on the console, and with a schema and an exit code it fits into scripts. With a Git hook, the check runs by itself before every push. The same idea sits in every pipeline that calls Claude. The answers differ in every run, you check the verdict and the problems yourself.

**Done when** `review.sh` prints a verdict with an exit code, a push of the PR branch is stopped by the hook while `--no-verify` lets it through, and the script and the hook folder are committed (if the hook lives in `.git/hooks`, only the script).

<details>
<summary>More</summary>

`claude -p` uses your normal login. Without `-p`, Claude stays interactive. If you want a run without your local settings and `CLAUDE.md` (for example in CI), the docs mention `--bare`; it does not read your login and needs an API key.

[Run Claude Code programmatically](https://code.claude.com/docs/en/headless) and [CLI reference](https://code.claude.com/docs/en/cli-reference)

</details>
