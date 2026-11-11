This task is about the **BMAD Method**. It gives you skills that take an idea through fixed steps (brief, requirements, architecture, build), and each step has its own named role. You build a small, new packing-list app.

You work in a **new, empty folder** with Node.js 22 or newer. No server needs to run.

### 1. Install BMAD

Create the folder, open it in the desktop app and open the terminal there:

```text
git init
npx bmad-method@6.12.4 install
```

In the installer choose **Claude Code** as the tool and the module **BMad Method**. Accept the defaults for the rest. Afterwards `.claude/skills` holds the BMAD skills and `_bmad` the configuration. Then start a new session in this folder so the skills are loaded.

### 2. Ask the help

```text
/bmad-help I have a new idea: a packing-list app. What is the first step?
```

The help looks at the folder, sees that nothing exists yet, and recommends the next skill. In our run it was the brief, with the order brief, PRD, architecture, epics and stories, build.

### 3. Write the product brief

```text
/bmad-product-brief A reusable packing-list app: templates, trips generated from templates, check-off progress. Runs locally in the browser.
```

The skill asks you questions, for example who uses the app and what it must do. Answer briefly in your own words, made-up answers are fine. If you do not know something, say "You decide". At the end a brief is in `_bmad-output/planning-artifacts/briefs/`.

From here on we did not run the flow ourselves; the skills exist in version 6.12.4.

### 4. Turn it into the PRD

The PRD (product requirements document) states what the app must do. Start a new session for this step.

```text
/bmad-prd Create the PRD from the brief in _bmad-output/planning-artifacts/briefs/.
```

### 5. Decide the architecture

Again a new session. The skill records the decisions that keep all parts of the app consistent later.

```text
/bmad-architecture Create the architecture for the PRD in _bmad-output/planning-artifacts/.
```

### 6. Plan and build yourself

Ask `/bmad-help` what comes after the architecture and run the skills it names in that order, each in a new session. Then tell the developer (the role Amelia) what to build. You write the prompt yourself and want to reach: the first story is implemented and the app runs in the browser.

For example:

```text
/bmad-build Implement the first story from the epics. Start the app with npm run dev on port 3440 and tell me what I can check in the browser.
```

### 7. Commit your state

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### What just happened

BMAD consists of **skills**, each guiding one step and writing a document to `_bmad-output`. The next document builds on the previous one. That is why you may start new sessions between steps: the knowledge lives in the files. In the installation the roles are called Mary (analyst), John (product manager), Winston (architect) and Amelia (developer).

**Done when** BMAD is installed, brief, PRD and architecture exist as files in `_bmad-output`, the first story is implemented and the app runs in the browser.

<details>
<summary>More</summary>

The skills `bmad-party-mode` (several roles discuss a decision) and `bmad-qa-generate-e2e-tests` (generates API and end-to-end tests) also exist. Try them if time is left. With `--yes --tools claude-code --modules bmm` the installer runs without questions.

[BMAD Method, version 6.12](https://github.com/bmad-code-org/BMAD-METHOD/tree/V6.12)

</details>
