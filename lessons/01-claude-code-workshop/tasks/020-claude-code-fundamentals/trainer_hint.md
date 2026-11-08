## Learning goals

- **Skills:** launching and steering Claude Code; plan mode as a read-only exploration mode;
  reading agent activity; monitoring context usage; managing permissions.
- **Concepts:** the agent control loop (Reason → Act → Observe); tools vs. text; evidence-backed
  answers; context as the primary resource.
- **Takeaways:** explore before you edit; ask for checkable artefacts; you remain the owner of
  every change, including the decision to make none.

## Facilitation notes

- Confirm everyone finished the installation task first. Cloning needs no `npm install`; running
  the app is optional here and costs time on slow networks.
- Start with a 2-minute live demo: `claude --permission-mode plan`, one question, then `Ctrl+O`
  to show the tool calls behind the answer. That makes the loop visible for the rest of the task.
- Participants sometimes approve the first plan out of habit. That is the teaching moment: plan
  mode only protects you until you say yes. If someone changed a file, let them look at
  `git diff` and `git restore .`.
- Push for evidence. Good answers name files and lines and survive a "show me" follow-up. Weak
  answers repeat documentation without checking it. Encourage at least one cross-check of a
  quoted claim against the code, without telling them what they will find.
- What good results look like, in general terms: an overview that covers both workspaces, how
  each part is started, and where the data lives; a Mermaid map that a participant has checked
  against at least one real import; a request flow that reaches an actual SQL statement; risks
  grouped by kind (security, data, maintainability, knowledge loss) with a concrete reference
  each; a history summary that links people, years, and areas.
- Do not confirm or name specific defects in the plenary. Participants meet several of the
  risks again in the refactoring, debugging, and code review tasks. If they spot one, write it on
  the board as "candidate" and move on. The full list is in the private trainer repo
  (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`), not in this course repo.
- Common issue: answers get vague after many questions. Use `/context` to show how much the
  exploration cost. It is the first live example of "context is king", and the bridge to the
  context task.

## Time estimate

~45 minutes: 5 clone and start, 10 overview and map, 10 request flow, 10 risks and history,
10 debrief. Cut the history step first if the group is slow.

## Discussion points

- Ask two participants to compare their five risks. Where they differ, which evidence was
  stronger?
- Where in the loop did the agent pause for permission, and would they have granted it in a real
  takeover?
