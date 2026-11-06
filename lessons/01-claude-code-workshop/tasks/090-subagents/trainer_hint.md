## Learning goals

- **Feature:** built-in vs. custom subagents, `.claude/agents/` files and frontmatter
  (`description`, `tools`, `model`), automatic vs. explicit invocation (`@agent-…`,
  `claude --agent`).
- **Concepts:** context isolation; delegation for noisy work; restricting tools to match the job.
- **Practice ground:** BookMonkey sign-in against the ready-made API, reviewed by a read-only
  security subagent.
- **Takeaways:** push noisy work out of the main context; a reviewer is input, the decision is
  yours.

## Facilitation notes

- The before/after `/context` comparison sells context isolation — make sure people actually run
  it, not just read about it.
- Since v2.1.198 `/agents` no longer opens a creation wizard; participants create subagents by
  asking Claude or writing the file. Older screenshots or blog posts will show the wizard.
- The unenforced token is the planted finding. If no reviewer finds it, ask the room: "what stops
  me from deleting a book without signing in?" — then point forward to tasks 200/230, where the own
  backend closes the gap.
- Second real finding the dry run surfaced: `POST /login` and `POST /register` return the
  **password hash** inside `user`. Good material for the "only the backend can fix it" bucket.
- In the dry run the reviewer was not found right after its file was written (`Agent type
  'security-reviewer' not found`), because `.claude/agents/` did not exist at session start. The
  restart in step 3 fixes it.
- A reviewer with `Bash` is no longer read-only. Keep it at `Read, Grep, Glob` and let the main
  session run the `curl` probe (step 4). The dry-run reviewer with Bash really deleted a book and
  registered a user, so `POST /dev/reset` afterwards is not optional.
- Someone will store the token in `localStorage` because it's quicker. Let the reviewer catch it.
- Resist rubber-stamping in both directions: neither the implementation diff nor the reviewer's
  findings should be accepted unread. Ask one person to walk the room through their triage.
- Deleted seed books: `POST /dev/reset` restores them for everyone on that API instance.

## Time estimate

~50 minutes.
