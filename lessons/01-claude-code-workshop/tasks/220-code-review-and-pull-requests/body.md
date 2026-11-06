## Overview

Review a colleague's pull request the professional way: an automated review for correctness, a
separate security pass by a specialised subagent, and your own triage of every finding. The
guiding principle is **"you push it, you own it"**, and for a reviewer: **you approve it, you own
it**. The agent review assists, it does not absolve.

## The Feature

- **`/code-review`** reviews changes for correctness bugs. Without a target it reviews your
  current branch; with a target it reviews that instead:

  ```text
  /code-review main...feature/admin-export-v2
  /code-review high main...feature/admin-export-v2
  ```

  An effort level (`low` to `max`) trades confidence for coverage: `low` reports only the findings
  it is most sure about. In a terminal session the review runs as a background subagent with its
  own context, and the findings arrive in your conversation. `--fix` applies them, `--comment`
  posts them on a GitHub PR. `/review` is an alias.
- **`/security-review`** analyses the diff between your current branch and the default branch of
  `origin` for vulnerabilities such as injection, auth issues, and data exposure.
- **A security subagent** is your own reviewer with a focused prompt and no edit tools, in
  `.claude/agents/`. Call it by name (`@agent-security-reviewer`) so the review runs in its own
  context and only the findings come back.
- **Triage** is yours. Every finding gets a verdict: real (with severity), false positive (with
  the reason), or needs discussion.

## Apply it to BookMonkey Legacy

The practice ground is your [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)
clone. Dana has a pull request ready: the branch `feature/admin-export-v2` adds an export of
reviews and loans as CSV, with a new box on the admin loans page and tests. The tests are green,
the description is short, and Dana is in a hurry. You are the reviewer.

## Prerequisites

- The `bookmonkey-legacy` clone with `npm install` done
- The branch locally: `git fetch origin && git switch feature/admin-export-v2`, then
  `npm run db:reset`

## Steps

1. **Understand the change first.** Ask Claude for a summary of
   `git log main..feature/admin-export-v2` and `git diff --stat main...feature/admin-export-v2`:
   what the feature does and which files it touches. Run `npm test`.
2. **Run the correctness review**: `/code-review main...feature/admin-export-v2`. While it runs in
   the background, read the diff yourself and note what you would flag.
3. **Create a security subagent** in the clone, `.claude/agents/security-reviewer.md`, without
   edit tools (or copy the one from the subagents task):

   ```markdown
   ---
   name: security-reviewer
   description: Reviews a diff for security issues.
   tools: Read, Grep, Glob
   ---
   You are a security reviewer. Review only the files and changes you are given, in the context
   of the code they call. For each finding give severity, file and line, an attack scenario in one sentence,
   and a fix. Do not edit files.
   ```

   Restart Claude Code (or wait for it to pick up the file), then ask
   `@agent-security-reviewer review the changes of main...feature/admin-export-v2` (the main session
   passes it the diff). Optionally compare with
   `/security-review` on the branch.
4. **Triage** all findings from both reviews and your own list in one table: finding, source,
   verdict (real / false positive / discuss), severity, and your reason. For every "real", ask
   Claude to show you how to trigger it (a `curl`, a test, a crafted input) and check one yourself.
5. **Write the review** as you would post it for Dana: blocking issues first, each with a
   suggested fix; non-blocking remarks after. Ask Claude to draft it from your table, then edit it
   in your own words.
6. **Fix one blocking finding** on the branch with a test that proves it, and run `/code-review`
   again on the branch to see how the findings change.
7. Reflect: what did the agents catch that you missed, what did you catch that they missed, and
   which finding was wrong?

## Success Criteria

**Feature**

- [ ] `/code-review` ran on `main...feature/admin-export-v2` and you read its findings
- [ ] A security subagent without edit tools reviewed the same diff in its own context
- [ ] Every finding has a verdict and a reason, including at least one false positive or "discuss"
- [ ] You reproduced at least one real finding yourself instead of trusting the report

**Review is useful**

- [ ] A written review exists with blocking issues first and a suggested fix for each
- [ ] One blocking finding is fixed on the branch with a test; `npm test` is green
- [ ] You can say whether you would approve the PR now, and why

## References

- Claude Code: Review locally with `/code-review`: https://code.claude.com/docs/en/code-review-local
- Claude Code: Commands (`/security-review`): https://code.claude.com/docs/en/commands
- Claude Code: Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code: Code Review for GitHub (managed service): https://code.claude.com/docs/en/code-review
- OWASP Top Ten: https://owasp.org/www-project-top-ten/
- GitHub: About pull request reviews: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews
