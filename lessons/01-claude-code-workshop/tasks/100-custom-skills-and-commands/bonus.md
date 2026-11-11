## Going further: scoped, forked & shared skills

- **Scope a skill to paths**: the `paths` frontmatter loads it only when Claude works with
  matching files; nested `.claude/skills/` folders load when work reaches that directory.
- **Run a skill in its own context**: `context: fork` runs it in a subagent, so a long procedure
  doesn't fill your main session. Only the result comes back.

  | Frontmatter | Where does the skill run? |
  | --- | --- |
  | without `context` and `agent` | in your main session |
  | `context: fork` | subagent `general-purpose` |
  | `context: fork` + `agent: Explore` | subagent `Explore`, read-only |
  | **only** `agent: Explore` | in your main session, `agent` only applies with `context: fork` (tested with Claude Code 2.1.319, not stated like this in the docs) |

  The subagent does not see your chat, so the SKILL.md needs a clear task. A skill with only
  guidelines ("use these API conventions") gives no useful result in a fork.
- **Package skills as plugins**: bundle skills, subagents, hooks, and MCP servers for versioned,
  team-wide reuse.
- **Keep descriptions discoverable**: with many skills, descriptions get shortened; lead with
  trigger words.

Try scoping your `add-book-feature` skill to your app directory with `paths`, or turn your command into
a small plugin your team could install.
