## Learning goals

- **Feature:** authoring `SKILL.md` with a trigger-friendly description; user-only commands via
  `disable-model-invocation: true`; arguments with `$ARGUMENTS`.
- **Concepts:** progressive disclosure; skill (agent triggers) vs. command (you trigger) vs.
  memory (always loaded); commands merged into skills.
- **Practice ground:** a server-first feature slice (list, detail, create, edit), then the second
  entity built from the captured pattern.
- **Takeaways:** build it once by hand, encode it, then let the encoding do the second one.

## Facilitation notes

- This is the biggest task — consider live-building the first entity together as a group, so
  participants spend their solo time on the skill and the command.
- Don't let people skip the "fresh session" check; genuine automatic invocation is the proof.
- The skill-vs-command distinction trips people up; have examples ready ("commit message" =
  command, "add a feature the established way" = skill).
- Older material shows `.claude/commands/` as the only way to write commands — both work, skills
  are the current format.
- If the group is behind, trim the second entity to create + list only.

## Time estimate

~60 minutes.
