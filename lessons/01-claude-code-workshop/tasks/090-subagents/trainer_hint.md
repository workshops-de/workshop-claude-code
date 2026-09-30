## Learning goals

- **Feature:** built-in vs. custom subagents, `.claude/agents/` files and frontmatter
  (`description`, `tools`, `model`), automatic vs. explicit invocation (`@agent-…`,
  `claude --agent`).
- **Concepts:** context isolation; delegation for noisy work; restricting tools to match the job.
- **Practice ground:** custom-session authentication with a route guard, reviewed by a read-only
  security subagent.
- **Takeaways:** push noisy work out of the main context; a reviewer is input, the decision is
  yours.

## Facilitation notes

- The before/after `/context` comparison sells context isolation — make sure people actually run
  it, not just read about it.
- Since v2.1.198 `/agents` no longer opens a creation wizard; participants create subagents by
  asking Claude or writing the file. Older screenshots or blog posts will show the wizard.
- Resist rubber-stamping in both directions: neither the implementation diff nor the reviewer's
  findings should be accepted unread. Ask one person to walk the room through their triage.
- Common issue on recent Next.js: forgetting to `await cookies()`/`headers()`.

## Time estimate

~50 minutes.
