## Learning goals

- **Feature:** all building blocks of the week together: CLAUDE.md, context, rules, skills, hooks, deny rules, tests.
- **Concepts:** what goes where? Advising (CLAUDE.md, rules) versus enforcing (hook, deny rule). Less is more in the context.
- **Practice ground:** a fresh clone of `bookmonkey-legacy`, without the files from earlier tasks.
- **Takeaways:** a good setup is small, checked and reasoned. Every group can say what it left out on purpose.

## Flow (60 min)

| Time | What |
| --- | --- |
| 5 min | Form groups (3 to 4 people), clone fresh |
| 7 min | Explore in plan mode |
| 3 min | Table "what goes where?" |
| 20 min | Build, switch roles after each block |
| 5 min | Probe in a new session |
| 20 min | Red-team prompt and present, 3 min per group, then a short round |

## Facilitation notes

- Walk from group to group and ask one question from "Did you think of everything?". Do not give answers, ask for proof: "Show me that this works."
- The `CLAUDE.md` often gets too long or only repeats the README. Then ask: "What in here would Claude get wrong without the file?"
- Hooks are often built but not tested. Ask how they show that the hook blocks.
- In the presentations, pay attention to point 2 (left out on purpose). That is the real decision skill.
- Lead over to block 502 afterwards: André's setup and the starter plugin as a comparison with the groups.
- Do not share solutions or defect locations from `bookmonkey-legacy-trainer`; the groups should explore themselves.
- Only `CLAUDE.md` and one enforcing block (hook or deny rule) are required. Rule and skill are extras if there is time.
- The red-team round before the presentations answers "What if Claude reaches the same result with a different command?" live. One attack prompt per group, no more.
- If someone asks which wins when a rule and the `CLAUDE.md` contradict: no fixed precedence is documented, both end up in the context. Resolve the contradiction.
- With more than 5 groups: only points 1 and 2.

## What to look for on your walkaround

- Do the start and test commands from the `CLAUDE.md` really run? Is the Node version in it?
- Is a script that deletes data guarded, or at least behind a prompt?
- Was the README believed without checking?
- Was the hook tested with a real block?
- Is it clear what goes in `settings.json` and what in `settings.local.json`?
- Is there a review step with fresh eyes (subagent or second session)?
- Is the `CLAUDE.md` under about 30 lines?

**Note:** The task has not yet been run as a whole with a group. The times are a first estimate.
