## Overview

Use Claude Code **without an interactive UI** — as a scriptable, composable command-line tool you
can drop into build scripts, pipelines, and automation. Learn non-interactive print mode
(`claude -p`), bare mode, structured output, and pre-approving tools for unattended runs.

## Background

Claude Code follows the Unix philosophy: add `-p` (`--print`) to run any command
non-interactively, read `stdin`, and write the result to `stdout`. `--bare` skips auto-discovery of
hooks, skills, plugins, MCP servers, and `CLAUDE.md` so a script gets the same result on every
machine. Because there is no human to answer prompts, you pre-approve tools with `--allowedTools`
or pick a permission mode.

## Steps

1. Run a one-off non-interactive query: ask a question about the codebase with `claude -p "..."`.
2. **Pipe** data through Claude: feed a build log or a `git diff` into `claude -p` and redirect the
   explanation to a file.
3. Get **structured output**: run a query with `--output-format json`, then again constrained with
   `--json-schema`, and parse a field with `jq`.
4. Add a **project script** that pipes the diff against the main branch into `claude -p` and asks
   it to report issues. Pre-approve only the tools it needs.
5. Try `--bare` and explain what stops loading; discuss why that matters for CI reproducibility.
6. Reflect on which repetitive checks in your workflow could become headless Claude steps.

## Success Criteria

- [ ] A non-interactive `claude -p` query ran successfully
- [ ] Structured JSON output was produced and a field parsed from it
- [ ] A project script wraps a headless Claude check with pre-approved tools
- [ ] You can explain what `--bare` changes and why it matters for CI

## References

- Claude Code — Run Claude Code programmatically: https://code.claude.com/docs/en/headless
- Claude Code — CLI reference: https://code.claude.com/docs/en/cli-reference
- Claude Code — GitHub Actions: https://code.claude.com/docs/en/github-actions
