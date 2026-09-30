## Going further — scoped, forked & shared skills

- **Scope a skill to paths** — the `paths` frontmatter loads it only when Claude works with
  matching files; nested `.claude/skills/` folders load when work reaches that directory.
- **Run a skill in its own context** — `context: fork` runs it in a subagent, so a long procedure
  doesn't fill your main session.
- **Package skills as plugins** — bundle skills, subagents, hooks, and MCP servers for versioned,
  team-wide reuse.
- **Keep descriptions discoverable** — with many skills, descriptions get shortened; lead with
  trigger words.

Try scoping your `add-feature` skill to your app directory with `paths`, or turn your command into
a small plugin your team could install.
