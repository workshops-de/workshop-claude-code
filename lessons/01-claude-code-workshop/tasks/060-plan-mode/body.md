## Overview

Use **plan mode** as a real steering tool, not just a read-only toggle: get a plan, argue with it,
edit it, and only then decide how much autonomy the agent gets for the execution. You met plan
mode briefly in the fundamentals task; here you use it for a change that actually matters.

## The Feature

In plan mode, Claude Code can read and research but cannot edit files or run changing commands.
Its output is a **plan** you review before anything happens.

- **Enter it** with `Shift+Tab` (cycle until the status line shows plan mode), prefix a single
  prompt with `/plan`, or start a session directly in it: `claude --permission-mode plan`.
- **Iterate on the plan** in conversation: ask why a step is needed, remove steps you don't want,
  add constraints the agent missed. A plan is cheap to change; a scaffold is not.
- **Edit the plan yourself**: when the plan is presented, press `Ctrl+G` to open it in your
  default text editor, change it, and save, and the agent proceeds from your version.
- **Choose how to execute**: the approval prompt offers **Yes, and use auto mode** (or **Yes,
  auto-accept edits** where auto mode isn't available), **Yes, manually approve edits**, and
  **No, keep planning**. Match that choice to how much you trust the plan.

The habit behind it: the cheapest moment to catch a wrong direction is before the first file
changes.

## Apply it to BookMonkey

> **Repo / ports:** a new, empty `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!` (needed from the subagents task on)

Throughout the workshop you build **BookMonkey**, a small book catalogue. The backend already
exists: the ready-made [`bookmonkey-api`](https://github.com/workshops-de/bookmonkey-api) serves
50 books with covers, series links, and a demo login. You build the frontend against it now; later
(in the TDD and autonomous workflows tasks) you replace the API with your own backend that honours the same contract.

The practice ground here is turning an empty repository into a running Next.js App Router project
in TypeScript with Tailwind CSS, a **public area** (catalogue, sign-in later) and an
**authenticated area** (your reading list later) separated by route groups, and one page that
proves the API connection. Scaffolding is repetitive and well documented, ideal to delegate, as
long as you steer.

## Prerequisites

- Node.js 26 (current LTS). `bookmonkey-api` declares `node >=26` in its `engines`.
- Start the API in a separate terminal and leave it running: `npx bookmonkey-api`. It listens on
  `http://localhost:4730`; the interactive docs are at `http://localhost:4730/api`.
- Optional skills (nice to have, not required):
  `npx skills add vercel-labs/agent-skills@vercel-react-best-practices -y` and
  `npx skills add anthropics/skills@frontend-design -y`.

## Steps

1. Create a new, empty repository for your BookMonkey next to the `bookmonkey-legacy` clone
   (`mkdir bookmonkey && cd bookmonkey && git init`). Start Claude Code there in plan mode
   (`claude --permission-mode plan`) and
   ask it to plan the scaffold: stack, route groups for public vs. authenticated areas, styling,
   the API base URL as an environment variable (`NEXT_PUBLIC_API_URL=http://localhost:4730`), and
   one start page that lists the titles of the first five books from `GET /books?_limit=5`.
   The repository is empty except for `.git`, so the plan should scaffold **into the current
   directory** with non-interactive flags, for example
   `npx create-next-app@latest . --ts --tailwind --eslint --app --no-src-dir --import-alias "@/*" --use-npm --yes`.
   The install alone can take several minutes.
2. **Challenge the plan** at least twice: choose **No, keep planning** and question any library
   you didn't ask for (a data-fetching library, a UI kit, a state manager), or ask the agent to
   justify a step you're unsure about. Watch the plan change.
3. When the revised plan is presented, press `Ctrl+G`, edit one detail yourself (for example, a
   route name), and save. Confirm the agent picks up your version.
4. Approve the plan and **deliberately choose** the execution option: auto mode / auto-accept or
   manually approve edits. Watch the commands it runs.
5. **Verify**: start the development server and open the app in a browser: five real book titles
   should appear.
6. Review the changes and make your first commit with a message you reviewed. Commit a
   `.env.example` next to the git-ignored `.env.local`: the template `.gitignore` ignores `.env*`,
   so add `!.env.example` to it.

## Success Criteria

**Feature**

- [ ] You started a session in plan mode and received a plan before any file changed
- [ ] The plan changed at least once because you pushed back
- [ ] You edited the plan in your editor via `Ctrl+G` and the agent continued from your edit
- [ ] You can explain which execution mode you picked after approval, and why

**App still works**

- [ ] `npm run dev` serves the app; a public and an authenticated route group both render
- [ ] The start page shows five book titles loaded from the running `bookmonkey-api`
- [ ] The API base URL comes from an environment variable, not a hard-coded string, and a
      committed `.env.example` documents it
- [ ] Type-check and `npm run build` pass; the scaffold is committed

## References

- Claude Code: Plan mode: https://code.claude.com/docs/en/permission-modes#analyze-before-you-edit-with-plan-mode
- Claude Code: Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code: Interactive mode (shortcuts): https://code.claude.com/docs/en/interactive-mode
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
- Next.js: Route groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups
- Next.js: Environment variables: https://nextjs.org/docs/app/building-your-application/configuring/environment-variables
