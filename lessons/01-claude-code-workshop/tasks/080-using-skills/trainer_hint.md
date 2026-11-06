## Learning goals

- **Feature:** finding (`npx skills find`), installing, and inspecting skills; `/skills`;
  automatic vs. explicit (`/skill-name`) invocation; progressive disclosure.
- **Concepts:** skills carry procedural, fast-moving knowledge on demand; memory carries
  always-relevant facts.
- **Practice ground:** shadcn/ui setup and the BookMonkey catalogue page.
- **Takeaways:** reach for a maintained skill when the library moves faster than the model; still
  verify the result; check who publishes a skill before installing it.

## Facilitation notes

- The catalogue search is a supply-chain moment: several `shadcn` skills exist from different
  publishers. Ask why `shadcn-ui/ui@shadcn` is the one to trust.
- The moment that sells this: point at a shadcn CLI detail the skill handled (interactive `init`
  prompts, changed flags) and ask the room whether the agent would have known it unaided.
- `init` can still prompt even with `--yes` — participants often think the process hung.
- Watch for card links built from `id` instead of `isbn` — the glossary from the rules task should
  prevent it; if it doesn't, that's a good discussion about rule quality.
- The dry run hit two traps: the skill installed mid-session was unknown (`Unknown skill:
  shadcn`) until the skills were reloaded, because `.claude/skills/` did not exist at session
  start; and `/shadcn` cannot work because the official skill is `user-invocable: false`. Both
  are now in the steps; still worth a quick demo of `/reload-skills`.
- The `lib/api.ts` from the plan mode task usually returns only titles; expect the agent to extend
  it (cover, author, price, currency). Card links point at `/books/<isbn>`, which stays a 404 until
  the custom skills task builds the detail page.
- Authoring your own skill comes later (custom skills task) — keep this one about using them.

## Time estimate

~45 minutes.
