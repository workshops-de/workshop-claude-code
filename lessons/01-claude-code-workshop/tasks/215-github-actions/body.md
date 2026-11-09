## Overview

Move Claude from your terminal into your team's workflow. A GitHub Actions workflow starts Claude
Code on a runner when someone labels an issue, and Claude answers on the issue: how hard is it,
which files are affected, what is the likely cause, what are the risks. You set it up on your own
fork, try it with a real ticket, and then tighten what Claude may do in CI.

## The Feature

The [Claude Code GitHub Action](https://github.com/anthropics/claude-code-action)
(`anthropics/claude-code-action@v1`) runs Claude Code inside a workflow job. It needs three things:

- **The Claude GitHub App** installed on the repository (<https://github.com/apps/claude>), so
  Claude can comment and push branches. It does **not** open pull requests by default: when it
  changes code, it pushes a branch and puts a link to a prefilled pull request page in its
  comment. You open the PR yourself.
- **A secret** with your credentials, passed to the matching input:
  - `CLAUDE_CODE_OAUTH_TOKEN` → `claude_code_oauth_token`: a long-lived token for your Claude
    subscription, created with `claude setup-token`
  - or `ANTHROPIC_API_KEY` → `anthropic_api_key`: an API key from the Claude Console
- **A workflow** that decides when Claude runs and what it may do. The main inputs:

  ```yaml
  - uses: anthropics/claude-code-action@v1
    with:
      claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
      track_progress: true        # progress comment on the issue while Claude works
      prompt: |                   # what Claude should do in this run
        Read the issue and reply with feasibility, affected files, likely cause, and risks.
      claude_args: |              # any Claude Code CLI flags
        --max-turns 30
        --allowedTools Read,Grep,Glob,Bash(git log:*)
  ```

  Without `prompt`, the action answers `@claude` mentions in issue and PR comments instead (with
  the matching `on:` triggers in the workflow).

`/install-github-app` in Claude Code does the app, the secret, and a starter workflow in one guided
flow. In this task you set up the parts by hand, because the repository already has a workflow.

**Costs.** Each run uses your Claude plan (OAuth token) or is billed to your API key. GitHub
Actions minutes on standard GitHub-hosted runners are free for public repositories, and your fork
of a public repository is public. Use `--max-turns` and `timeout-minutes` to cap a run.

## Apply it to BookMonkey Legacy

> **Repo / ports:** your GitHub fork of `bookmonkey-legacy`; Claude runs on a GitHub Actions
> runner, so no local ports are needed
>
> **Login:** no app login; `gh auth login` and a Claude token or API key

[`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy) already contains
`.github/workflows/claude-issue.yml`: label an issue `analyse` and Claude comments; label it
`implement` and Claude also pushes a branch and links the prefilled pull request page. It only
needs a fork with Actions, Issues, the app, and a secret. Your test ticket can be the one from the debugging task, in your own words.

Cannot use a personal token or API key in this training? Then do steps 1 and 9 locally (read the
workflow, then tighten it with Claude on a branch) and follow the trainer's live demo for the runs
on GitHub.

## Prerequisites

- A GitHub account and the GitHub CLI, logged in (`gh auth login`)
- **On Windows:** the commands below are Bash. Run them in Git Bash (comes with Git for Windows),
  or adapt them for PowerShell: `$FORK = "<your-github-user>/bookmonkey-legacy"` instead of
  `FORK=...`; the `gh` and `git` commands themselves are the same
- Your `bookmonkey-legacy` clone, and a Claude plan or API key you may use for this

## Steps

1. **Read the workflow first.** Ask Claude in your clone to explain
   `.github/workflows/claude-issue.yml`: when it runs, which permissions it has, what Claude may
   do in each mode, and what could go wrong. You are about to give it your credentials. Compare
   the prompt with the permissions and the tool list: does the workflow allow more than the
   prompt asks for? Write down what you find.
2. **Fork and add the remote** (inside your clone):

   ```bash
   gh repo fork --remote --remote-name fork
   FORK=<your-github-user>/bookmonkey-legacy
   ```

3. **Switch on what forks leave off.** In your fork on github.com: **Actions** tab → enable
   workflows (forks start with workflows disabled), and **Settings → General → Features** → tick
   **Issues**.
4. **Install the Claude GitHub App** on your fork only: <https://github.com/apps/claude> →
   Configure → "Only select repositories".
5. **Add the secret.** With a Claude subscription:

   ```bash
   claude setup-token                                  # prints a long-lived token
   gh secret set CLAUDE_CODE_OAUTH_TOKEN --repo $FORK  # paste it when asked
   ```

   With an API key instead: `gh secret set ANTHROPIC_API_KEY --repo $FORK`.
6. **Create the labels** if your fork has none yet:
   `gh label create analyse --repo $FORK` and `gh label create implement --repo $FORK`.
7. **Open an issue** in your own words, for example the "next volume" ticket from the debugging
   task, and label it:

   ```bash
   gh issue create --repo $FORK --title "Next volume link leads nowhere" --body "..."
   gh issue edit <number> --repo $FORK --add-label analyse
   ```

8. **Watch and read.** Follow the run in the **Actions** tab (or `gh run watch --repo $FORK`),
   then read Claude's comment on the issue. Check one claim from it against the code: is the file
   right, is the line range right?
9. **Change the workflow with Claude.** In your clone, on a new branch from the upstream code
   (`git switch -c ci/tighten origin/main`, so none of your own commits come along), ask Claude to
   tighten the workflow, for example: no `Bash(npm install:*)` for the `analyse` label, a smaller
   `--max-turns`, a shorter `timeout-minutes`, or a prompt that asks for a fixed output format.
   Review the diff, push the branch to `fork` (`git push -u fork <branch>`; if the push is refused
   because it changes a workflow, run `gh auth refresh -s workflow` once), open a PR in your fork
   (`gh pr create --repo $FORK --base main --head <branch>`), and merge it. Workflows for issue
   events run from the default branch.
10. If the first run came back in time: remove the label, add `analyse` again, and compare the new comment with the first one.
11. **Clean up** when you are done:

    ```bash
    gh secret delete CLAUDE_CODE_OAUTH_TOKEN --repo $FORK   # or ANTHROPIC_API_KEY
    ```

    Remove the Claude app from the fork: github.com → your **Settings → Applications → Installed
    GitHub Apps → Claude → Configure**, then remove the fork from the selected repositories (or
    uninstall the app). If you no longer need the fork, delete it:
    `gh auth refresh -s delete_repo` once, then `gh repo delete $FORK`.

    The secret is gone, the credential is not. If you used an API key, delete it in the Claude
    Console. A token from `claude setup-token` stays valid for a year and the docs name no way to
    revoke it, so remove it from your notes and shell history.

## Success Criteria

**Feature**

- [ ] Your fork has Actions and Issues enabled, the Claude GitHub App installed, and one secret set
- [ ] Labelling an issue `analyse` started a run, and Claude commented on the issue
- [ ] You checked at least one claim from Claude's comment against the code
- [ ] You found at least one place where the workflow allows more than the prompt asks for
- [ ] A workflow change made with Claude is merged in your fork and the next run shows its effect
- [ ] You can say where the cost of a run lands, and how you capped it

**Repository still works**

- [ ] Your fork's default branch still passes `npm test`; nothing was merged that you did not review
- [ ] After cleanup, `gh secret list --repo $FORK` shows no Claude secret, and the Claude app no
      longer has access to the fork (or the fork is deleted)
- [ ] The token is gone from your notes and shell history; an API key is deleted in the Console

## References

- Claude Code: GitHub Actions: https://code.claude.com/docs/en/github-actions
- Claude Code GitHub Action: usage and inputs: https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md
- Claude Code: CLI reference (`--allowedTools`, `--max-turns`): https://code.claude.com/docs/en/cli-reference
- Claude Code: Authentication (long-lived token): https://code.claude.com/docs/en/authentication
- GitHub: Billing for GitHub Actions: https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-actions/about-billing-for-github-actions
- GitHub: Using secrets in GitHub Actions: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
