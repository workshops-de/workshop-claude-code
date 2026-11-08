## Learning goals

- **Feature:** `/init`, curating `CLAUDE.md`, subdirectory memory files and when they load,
  `CLAUDE.local.md`, `/memory`.
- **Concepts:** long-term vs. short-term memory; signal over volume; memory as context cost;
  documentation drift.
- **Takeaways:** memory is curated and verified against the code; keep it lean; prove it changes
  agent behaviour.

## Facilitation notes

- The README of `bookmonkey-legacy` was last maintained years ago. Some parts are current, some
  are not. Do not tell participants which. The point is that they find out by checking, and that
  `/init` can copy outdated claims into the memory file if nobody checks. The list of outdated
  claims is in the private trainer repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- A strong debrief question: "Which line of your `CLAUDE.md` would have cost the next session the
  most time if it were wrong?"
- Participants often keep too much of the `/init` output. Push them to cut aggressively; the "new
  teammate" test is a good prompt to repeat out loud.
- The fresh-session step is the one people skip under time pressure. Don't let them; it's the only
  proof the file works.
- Running `npm install` and `npm run db:reset` takes 1 to 2 minutes. Suggest starting it in a
  second terminal while `/init` runs.
- The committed memory files are reused in the refactoring, debugging, and code review tasks on
  the same repository.

## Time estimate

~30 minutes for an experienced group, 40 if many installs are slow.
