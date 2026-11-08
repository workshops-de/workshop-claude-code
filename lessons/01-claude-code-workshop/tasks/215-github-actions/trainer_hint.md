## Learning goals

- **Feature:** `anthropics/claude-code-action@v1`, the Claude GitHub App, `CLAUDE_CODE_OAUTH_TOKEN`
  (`claude setup-token`) vs. `ANTHROPIC_API_KEY`, `prompt`, `track_progress`, `claude_args` with
  `--allowedTools` and `--max-turns`, `/install-github-app` as the guided alternative.
- **Concepts:** Claude as a teammate in the issue tracker; unattended runs need tight tool lists;
  cost and blast radius of CI runs.
- **Takeaways:** start with analysis, not implementation; restrict tools per mode; review what
  Claude writes on an issue like any other review.

## Facilitation notes

- Prepare a demo fork before the session, with the app installed and a secret set, and run one
  `analyse` label live. Participants who cannot or may not use a personal token or API key follow
  this demo. Never share a trainer token with the room.
- Costs: each run uses the participant's Claude plan (OAuth token) or their API key. Standard
  GitHub-hosted runners are free for public repositories, and a fork of a public repository is
  public. Mention `timeout-minutes` and `--max-turns` as the caps.
- Typical setup traps, in this order: workflows disabled in the fork; Issues disabled in the fork;
  app not installed on the fork; labels missing; `gh` targeting the original repository instead of
  the fork; a push that changes a workflow file refused until `gh auth refresh -s workflow`.
- `/install-github-app` also works, but it uses the repository of the current clone and prepares
  its own workflow PR. For this task the manual path is clearer; mention the command as the
  everyday shortcut.
- Good discussion for step 1: the issue title and body are text from whoever opened the issue, and
  the workflow puts them into Claude's prompt. Who can trigger a run, and what could a malicious
  issue ask for? The action only runs for users with write access by default; talk about why the
  tool list is the real boundary.
- Do not comment on whether Claude's analysis of the ticket is correct. The debugging task (and
  the private trainer repo, `bookmonkey-legacy-trainer`, `SOLUTIONS.md`) covers that. Here the
  point is the setup and the review of the comment.
- The `implement` label lets Claude push a branch and link a prefilled pull request page; the
  action does not open the PR itself by default. It is optional; it takes longer and costs more.
  Use it in the demo if time allows.
- Step 1 asks where the workflow allows more than the prompt asks for. Collect answers in the
  room without grading them, then let participants tighten one of them in step 9.
- Windows participants: the snippets are Bash. Git Bash works as is; in PowerShell only the
  `FORK=` variable line changes (`$FORK = "..."`).
- Insist on the cleanup step (secret, app access, optional fork deletion). A forgotten secret
  with a one-year token in a public fork is the real risk of this task.

## Time estimate

~40 minutes: 20 fork and setup (fork, Actions and Issues, app, token and secret, labels), 10
first run and reading the comment, 10 workflow change, second run, and cleanup. Add 10 minutes if
many participants need to create a token first.
