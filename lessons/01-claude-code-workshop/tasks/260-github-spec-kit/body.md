> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about **spec-driven development** with GitHub **Spec Kit**: you first write down what should be built, and Claude derives the plan, the task list and the code from it. Spec Kit ships skills for this, instructions you type into the chat as `/speckit-...`. You build a small habit tracker in a new folder `habits`, not BookMonkey.

You need [uv](https://docs.astral.sh/uv/) (installs Python tools) and Node.js 22 or newer for the tests. The habit tracker is served later at http://localhost:3430.

### 1. Install Spec Kit and create the project

In the terminal (in the desktop app, open it in the folder where `habits` should be created):

```bash
uv tool install specify-cli
specify init habits --integration claude
```

If `specify` is already installed, update it with `uv tool upgrade specify-cli`. This creates the folder `habits` with `.claude/skills/` (the skills) and `.specify/` (templates and scripts). Open `habits` in the desktop app and start a new session there.

### 2. Set the principles

```text
/speckit-constitution Keep it simple and small, data only local in the browser, tests for the logic, usable with the keyboard.
```

Claude writes `.specify/memory/constitution.md`, the **constitution**. Spec Kit checks all later steps against these principles.

### 3. Describe what you want

```text
/speckit-specify A habit tracker: I create habits, tick them off every day and see how many days in a row I managed them. One page, no login.
```

In our run this produced `specs/001-habit-tracker/spec.md` with user stories and requirements, without technology. Read the spec and look at the section with the assumptions Claude made without asking.

### 4. Choose the technology

```text
/speckit-plan Plain HTML, CSS and JavaScript without a build step, data in localStorage, tests with the built-in Node test runner (node --test). The page is served by a small Node server without dependencies on port 3430. In package.json, npm start starts the server and npm test runs the tests.
```

Only now does technology come in. Besides `plan.md`, files like `research.md` and `data-model.md` appear.

### 5. Break the plan into tasks

```text
/speckit-tasks
```

Claude writes `tasks.md`, a numbered list of small tasks grouped by user story. In our run there were 23.

### 6. Implement the tasks

```text
/speckit-implement
```

Claude works through the list and ticks each task off in `tasks.md`. In our run this took just under two minutes. Then check it yourself: `npm test` (37 tests green in our run), `npm start`, and open http://localhost:3430 in the browser. Create a habit and tick it off.

### 7. Change a requirement in the spec first

Find something you want different while trying it out, and write it as a new requirement in the spec without touching the code. Then let Spec Kit find the gap to the code. For example:

```text
New requirement: I also want to tick off yesterday retroactively. Change only this feature's spec.md under specs/, no code.
```

Then:

```text
/speckit-converge
```

`/speckit-converge` compares spec and code and appends the missing work to `tasks.md` as new tasks. In our run there were six, and the code stayed unchanged. You implement them with `/speckit-implement`.

### What just happened

| Step | Result | Content |
|---|---|---|
| constitution | `.specify/memory/constitution.md` | principles |
| specify | `specs/.../spec.md` | what and why |
| plan | `plan.md` and others | how |
| tasks | `tasks.md` | work steps |
| implement | code and tests | implementation |

The spec is the source of truth, the code is derived from it. So a new requirement changes the spec first. Every step produces a file you can read and correct before the next one starts.

**Done when** `spec.md`, `plan.md` and `tasks.md` exist, the habit tracker runs at http://localhost:3430, and after a change in the spec `/speckit-converge` gave you new tasks.

<details>
<summary>More</summary>

- Optional between the steps, per the docs: `/speckit-clarify` (before the plan, asks questions about the spec), `/speckit-checklist` and `/speckit-analyze` (after the tasks, checks spec, plan and tasks for contradictions). We did not run them.
- Spec Kit changes fast. This flow ran with `specify-cli` 1.3.3; older versions have different commands.
- [Repository](https://github.com/github/spec-kit) · [Quickstart](https://github.github.io/spec-kit/quickstart.html) · [Install uv](https://docs.astral.sh/uv/)

</details>
