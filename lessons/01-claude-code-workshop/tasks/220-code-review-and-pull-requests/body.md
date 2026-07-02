## Overview

Ship your work the professional way: a clean branch, a descriptive pull request, an agent-assisted
review (including a security pass), and a thoughtful response to the findings. The guiding
principle is **"you push it, you own it"** — the review assists, it does not absolve.

## Background

Agents are good reviewers: they catch typos and small mistakes humans skim past, flag risky
patterns, and can fix issues on the spot. But the responsibility stays with you: an agent review
complements human review and never replaces your ownership of what merges.

## Steps

1. On a feature branch, ask the agent to **commit** your work with a meaningful message — review
   the message and the diff before it lands.
2. Open a **pull request**, letting the agent draft a title and description grounded in the actual
   diff.
3. Run an **automated review** of the change for bugs, risks, and small issues.
4. Run a separate **security pass**: ask the agent to outline potential vulnerabilities, especially
   around auth and mutations.
5. **Triage** the findings — fix the real ones, push back on false positives — and confirm the
   quality gates pass on the branch.
6. Reflect on what the agent caught that you might have missed, and what it got wrong.

## Success Criteria

- [ ] A feature branch was committed with a reviewed message and pushed
- [ ] A pull request exists with an agent-drafted, diff-grounded description
- [ ] An automated review and a separate security pass were both run
- [ ] Findings were triaged (fixed or justified) and quality gates pass

## References

- GitHub — About pull requests: https://docs.github.com/en/pull-requests
- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — GitHub Actions: https://code.claude.com/docs/en/github-actions
- OWASP — Top Ten: https://owasp.org/www-project-top-ten/
