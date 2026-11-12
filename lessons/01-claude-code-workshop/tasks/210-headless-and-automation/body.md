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

### 6. Build your own script

Think of a check or task you repeat in daily work and let Claude write a script for it that uses `claude -p`. Then try it out.

For example:

```text
Write a script commit-vorschlag.sh that pipes the staged changes (git diff --staged) into claude -p and suggests a short commit message. Make it executable.
```

For this example you need a staged change (`git add review.sh`).

### 7. Commit your state

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### What just happened

`claude -p` turns Claude into a command line program: input by pipe, output on the console, and with a schema and an exit code it fits into scripts. The same idea sits in every pipeline that calls Claude. The answers differ in every run, you check the verdict and the problems yourself.

**Done when** `review.sh` prints a verdict with an exit code, you have built and tried your own script with `claude -p`, and both are committed.

<details>
<summary>More</summary>

`claude -p` uses your normal login. Without `-p`, Claude stays interactive. If you want a run without your local settings and `CLAUDE.md` (for example in CI), the docs mention `--bare`; it does not read your login and needs an API key.

[Run Claude Code programmatically](https://code.claude.com/docs/en/headless) and [CLI reference](https://code.claude.com/docs/en/cli-reference)

</details>
