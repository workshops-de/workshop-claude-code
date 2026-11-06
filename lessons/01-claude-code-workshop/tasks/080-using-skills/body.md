## Overview

Put **skills** to work: find and install a ready-made skill for a library that changes fast, watch
Claude Code pick it up on its own, and compare that with invoking it explicitly. You will see why
skills are the right home for procedural, up-to-date know-how that shouldn't sit in context all
the time.

## The Feature

A skill is a folder with a `SKILL.md` (plus optional supporting files). Only its **name and
description** sit in context; the full instructions load when the task matches or when you invoke
it: that's _progressive disclosure_.

- **Where skills live:** project skills in `.claude/skills/<name>/SKILL.md` (commit them for your
  team), personal skills in `~/.claude/skills/<name>/SKILL.md`.
- **Finding and installing third-party skills:** `npx skills find <topic>` searches the community
  catalogue; `npx skills add <owner>/<repo>@<skill> -y` installs one. Look at what lands on disk
  before trusting it.
- **Seeing what's available:** `/skills` lists the skills in the current session. Claude Code
  picks up skill changes live, but only in skill directories that existed when the session
  started: after adding the project's first skill, run `/reload-skills` (or restart).
- **Two ways a skill runs:** Claude invokes it automatically when your prompt matches its
  description, or you invoke it directly with `/skill-name`. The transcript shows when a skill was
  loaded. A skill with `user-invocable: false` in its frontmatter is hidden from the `/` menu and
  typing `/name` does not run it; you invoke it explicitly by asking Claude to use it by name.

Skills vs. memory: `CLAUDE.md` and rules are always (or path-) loaded facts; skills are
procedures loaded on demand.

## Apply it to BookMonkey

> **Repo / ports:** your `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!`

The practice ground is BookMonkey's **catalogue page**: a grid of book cards (cover, title,
author, price with currency) that links to a detail page, built with **shadcn/ui** on top of your
Tailwind scaffold. The shadcn CLI is interactive and its flags change frequently: exactly the kind
of fast-moving knowledge where a maintained skill beats the model's training data. Data still
comes from the running `bookmonkey-api`; your API-client rule from the previous task applies.

## Prerequisites

- The `bookmonkey-api` is running on `http://localhost:4730`.
- Optional skills (nice to have, not required): `vercel-labs/agent-skills@vercel-react-best-practices`,
  `anthropics/skills@frontend-design`.

## Steps

1. Run `npx skills find shadcn` and compare the results: who publishes each one, how many installs,
   what does it claim to do? Install the official one: `npx skills add shadcn-ui/ui@shadcn -y`.
   Check what landed: the files in `.agents/skills/shadcn/`, a symlink `.claude/skills/shadcn`, and
   a `skills-lock.json`. Commit all three together.
2. Open the installed `SKILL.md` and read its frontmatter: the description, and
   `user-invocable: false`. Run `/reload-skills` (or start a new session), then `/skills`, and
   confirm it is listed.
3. Without mentioning the skill, ask the agent to **set up shadcn/ui** in the project and add the
   components a book card needs. Watch the transcript: did it load the skill on its own?
4. Ask for the **catalogue page** at `/books`: one card per book from `GET /books`, showing cover, title,
   author, and formatted price; each card links to `/books/<isbn>`.
5. Invoke the skill **explicitly** for a follow-up. The shadcn skill is `user-invocable: false`, so
   `/shadcn` does not work: name it in the prompt instead, for example "Use the shadcn skill to add
   a skeleton loading state and an empty state to the catalogue". Compare how the result differs
   from the unguided run.
6. Compare: what did the skill know that the agent alone probably would have gotten wrong? Record
   the answer in one line of your project memory.

## Success Criteria

**Feature**

- [ ] You searched the catalogue, picked a skill deliberately, and it shows up in `/skills`
- [ ] You observed at least one automatic skill invocation and invoked the skill explicitly by name
- [ ] You can explain progressive disclosure and why this knowledge belongs in a skill, not in
      `CLAUDE.md`

**App still works**

- [ ] The catalogue page renders the books from the API with covers, titles, authors, and prices
- [ ] Card links use the ISBN (`/books/<isbn>`), not the `id`
- [ ] Type-check and `npm run build` pass

## References

- Claude Code: Skills: https://code.claude.com/docs/en/skills
- Skills catalogue: https://skills.sh
- Agent skills (open format): https://agentskills.io
- shadcn/ui: Installation (Next.js): https://ui.shadcn.com/docs/installation/next
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
