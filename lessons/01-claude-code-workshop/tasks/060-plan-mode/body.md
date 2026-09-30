## Overview

Use **plan mode** as a real steering tool, not just a read-only toggle: get a plan, argue with it,
edit it, and only then decide how much autonomy the agent gets for the execution. You met plan
mode briefly in the fundamentals task — here you use it for a change that actually matters.

## The Feature

In plan mode, Claude Code can read and research but cannot edit files or run changing commands.
Its output is a **plan** you review before anything happens.

- **Enter it** with `Shift+Tab` (cycle until the status line shows plan mode), prefix a single
  prompt with `/plan`, or start a session directly in it: `claude --permission-mode plan`.
- **Iterate on the plan** in conversation: ask why a step is needed, remove steps you don't want,
  add constraints the agent missed. A plan is cheap to change; a scaffold is not.
- **Edit the plan yourself**: when the plan is presented, press `Ctrl+G` to open it in your
  default text editor, change it, and save — the agent proceeds from your version.
- **Choose how to execute**: the approval prompt offers **Yes, and use auto mode** (or **Yes,
  auto-accept edits** where auto mode isn't available), **Yes, manually approve edits**, and
  **No, keep planning**. Match that choice to how much you trust the plan.

The habit behind it: the cheapest moment to catch a wrong direction is before the first file
changes.

## Apply it to Clash

The practice ground is the first step of your own version of
[`pawsaw/clash`](https://github.com/pawsaw/clash): turning an empty repository into a running
Next.js App Router project in TypeScript, styled with Tailwind CSS and shadcn/ui, with a **public
area** (sign-in/registration later) and an **authenticated application area** separated by route
groups. Scaffolding is repetitive and well documented — ideal to delegate, as long as you steer.

## Prerequisites

- **Required skill:** `shadcn` (`npx skills add vercel/vercel-plugin@shadcn -y`) — the shadcn CLI is
  interactive and its flags change frequently; this skill keeps the agent on current commands.
- Recommended: `react-best-practices`, `frontend-design`.

## Steps

1. Start Claude Code in your empty repository in plan mode (`claude --permission-mode plan`) and
   ask it to plan the scaffold: stack, route groups for public vs. authenticated areas, styling,
   and one sample component.
2. **Challenge the plan** at least twice — choose **No, keep planning** and question any library
   you didn't ask for, or ask the agent to justify a step you're unsure about. Watch the plan
   change.
3. When the revised plan is presented, press `Ctrl+G`, edit one detail yourself (for example, a
   route name), and save. Confirm the agent picks up your version.
4. Approve the plan and **deliberately choose** the execution option — auto mode / auto-accept or
   manually approve edits. Watch the commands it runs.
5. **Verify**: start the development server and open the app in a browser.
6. Review the changes and make your first commit with a message you reviewed.

## Success Criteria

**Feature**

- [ ] You started a session in plan mode and received a plan before any file changed
- [ ] The plan changed at least once because you pushed back
- [ ] You edited the plan in your editor via `Ctrl+G` and the agent continued from your edit
- [ ] You can explain which execution mode you picked after approval, and why

**App still works**

- [ ] `npm run dev` serves the app; a public and an authenticated route group both render
- [ ] A component from the component library renders on a page
- [ ] Type-check and `npm run build` pass; the scaffold is committed

## References

- Claude Code — Plan mode: https://code.claude.com/docs/en/permission-modes#analyze-before-you-edit-with-plan-mode
- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — Interactive mode (shortcuts): https://code.claude.com/docs/en/interactive-mode
- Next.js — Route groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups
- shadcn/ui — Installation: https://ui.shadcn.com/docs/installation
