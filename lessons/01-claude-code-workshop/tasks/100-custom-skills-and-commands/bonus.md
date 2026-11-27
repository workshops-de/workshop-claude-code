## Going further: scoped, forked & shared skills

- **Decide who may start a skill**: two frontmatter fields set who can load it.

  | Frontmatter | Claude loads it by itself | You can type `/name` |
  | --- | --- | --- |
  | neither field | yes | yes |
  | `disable-model-invocation: true` | no | yes |
  | `user-invocable: false` | yes | no |

  With `disable-model-invocation: true` the `description` is not put into Claude's context, so
  Claude does not know the skill exists. Use it for jobs with side effects or a timing you want to
  control (deploy, commit, your `/new-book-view`). It also saves context in every session.
  `user-invocable: false` is the opposite: the skill is hidden from the `/` menu, like the shadcn
  skill from task 080.
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

## After the discussion: from a book recipe to a project skill

`add-book-feature` loads when a request sounds like a book feature. A skill pays off when the same
procedure comes back in different jobs. Widen yours in three steps.

1. **Sort before you rewrite.** Ask Claude for the list, then sort it yourself:

   ```text
   List the 10 most important decisions behind the read page and the forms we built (where files go, how the API is called, URL state, auth, checks, project facts). One line each. Do not change anything.
   ```

   | Bucket | Where it belongs |
   | --- | --- |
   | comes back in every screen | the skill |
   | always true in this project | `CLAUDE.md` |
   | a job I start myself | a command |
   | only this one feature | nothing, it is in the code |

   Ask yourself: would the skill also help for a sign-in page or a series overview? If not, it is a
   recipe, not a skill.

2. **Rewrite the skill from the first bucket only.**

   ```text
   Turn add-book-feature into a skill at .claude/skills/api-screens/SKILL.md that describes how any screen against the bookmonkey-api is built here: list, detail page, form. Use only the "comes back in every screen" decisions, with the book pages as an example, not as the rule. Delete the old skill and point /new-book-view to the new one. The description starts with words from real requests (screen, page, list, detail page, form, search, paging, API).
   ```

3. **Test it with a job that never says "book feature".** In a new session:

   ```text
   Add a page /series that lists every series with its books in order.
   ```

   Look in the transcript whether Claude loaded `api-screens`. If not, add the words from your
   prompt to the `description`.
