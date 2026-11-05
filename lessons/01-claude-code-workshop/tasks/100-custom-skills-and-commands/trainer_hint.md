## Learning goals

- **Feature:** authoring `SKILL.md` with a trigger-friendly description; user-only commands via
  `disable-model-invocation: true`; arguments with `$ARGUMENTS`.
- **Concepts:** progressive disclosure; skill (agent triggers) vs. command (you trigger) vs.
  memory (always loaded); commands merged into skills.
- **Practice ground:** BookMonkey's read side (search, sort, paging, series navigation) by hand,
  then the create and edit screens built from the captured pattern.
- **Takeaways:** build it once by hand, encode it, then let the encoding do the next ones.

## Facilitation notes

- This is the biggest task — consider live-building the read side together as a group, so
  participants spend their solo time on the skill and the command.
- Don't let people skip the "fresh session" check; genuine automatic invocation is the proof.
- The skill-vs-command distinction trips people up; have examples ready ("commit message" =
  command, "add a book screen the established way" = skill).
- Older material shows `.claude/commands/` as the only way to write commands — both work, skills
  are the current format.
- Paging needs the `X-Total-Count` response header — agents often compute "has next page" from
  the array length instead. Good review moment.
- Created books persist in the shared API instance; `POST /dev/reset` cleans up between groups.
- If the group is behind, trim the command run to the create screen only.

## Time estimate

~60 minutes.
