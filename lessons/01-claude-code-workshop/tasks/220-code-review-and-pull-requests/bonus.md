## Going further: deeper and automated review

- **`/code-review ultra`** runs a deep multi-agent review in the cloud (ultrareview). It has a few
  free runs on Pro, Max, and Ultra plans, then needs usage credits.
- **Review your own work**: open a draft pull request for your BookMonkey frontend, let Claude
  draft the description from the diff, and run `/code-review --comment` on it so the findings
  land on the PR.
- **Automate it**: the GitHub Actions task runs Claude from a workflow; the same action can
  review every pull request.
- **Code Review for GitHub** (Team and Enterprise) reviews every PR automatically, configured
  with `REVIEW.md` and your `CLAUDE.md`.
