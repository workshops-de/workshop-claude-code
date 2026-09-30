## Overview

Put **skills** to work: install ready-made skills for a library that changes fast, watch Claude
Code pick them up on its own, and compare that with invoking one explicitly. You will see why
skills are the right home for procedural, up-to-date know-how that shouldn't sit in context all
the time.

## The Feature

A skill is a folder with a `SKILL.md` (plus optional supporting files). Only its **name and
description** sit in context; the full instructions load when the task matches or when you invoke
it — that's _progressive disclosure_.

- **Where skills live:** project skills in `.claude/skills/<name>/SKILL.md` (commit them for your
  team), personal skills in `~/.claude/skills/<name>/SKILL.md`.
- **Installing third-party skills:** community catalogues ship skills you add with one command,
  e.g. `npx skills add prisma/skills@prisma-cli -y`. Look at what lands on disk before trusting it.
- **Seeing what's available:** `/skills` lists the skills in the current session.
- **Two ways a skill runs:** Claude invokes it automatically when your prompt matches its
  description, or you invoke it directly with `/skill-name`. The transcript shows when a skill was
  loaded.

Skills vs. memory: `CLAUDE.md` and rules are always (or path-) loaded facts; skills are
procedures loaded on demand.

## Apply it to Clash

The practice ground is turning your domain model from the previous task into a real, migrated
**Prisma + SQLite** database with seed data. Prisma's setup changed notably in recent versions —
exactly the kind of fast-moving knowledge where a maintained skill beats the model's training data.
SQLite has no native enums, so status- and type-like fields are stored as documented strings.

## Prerequisites

- **Required skills:** `prisma-cli`, `prisma-database-setup`
  (`npx skills add prisma/skills@prisma-cli -y`, `npx skills add prisma/skills@prisma-database-setup -y`)
- Recommended: `prisma-next`, `prisma-client-api`

## Steps

1. Install the required skills, then open one `SKILL.md` and read its description. Run `/skills`
   in Claude Code and confirm both are listed.
2. Without mentioning any skill, ask the agent to draft the **Prisma schema** from your domain
   rules (relationships, optional links, uniqueness constraint, documented string statuses).
   Watch the transcript: did it load a skill on its own?
3. Review the schema against your glossary before accepting it.
4. Invoke a skill **explicitly** (e.g. `/prisma-cli`) to run the migration and generate the
   client. If a migration fails, let the agent read the error and correct itself.
5. Ask for a **seed** with a realistic spread of demo data, then verify it in Prisma Studio.
6. Compare: what did the skill know that the agent alone probably would have gotten wrong? Record
   the database commands (migrate, seed, reset, studio) in your project memory.

## Success Criteria

**Feature**

- [ ] The Prisma skills are installed and show up in `/skills`
- [ ] You observed at least one automatic skill invocation and ran one skill explicitly
- [ ] You can explain progressive disclosure and why this knowledge belongs in a skill, not in
      `CLAUDE.md`

**App still works**

- [ ] The schema models all entities with correct relations and unique constraints
- [ ] A migration applies cleanly; the seed populates demo data you can browse
- [ ] `tsc --noEmit` passes with the client and your db helper imported

## Pitfalls (current Prisma)

Recent Prisma (7.x) changed setup — this is where the skills earn their keep:

- The datasource may have **no `url`**; the connection string is read in `prisma.config.ts` from
  `DATABASE_URL`, and `.env` is not auto-loaded (`dotenv` must be installed).
- The client may generate to a **custom path** (e.g. `lib/generated/prisma`) — import from there.
- **Runtime needs a driver adapter** — construct the client with one, not a bare `new PrismaClient()`.
- A seed run via `tsx` won't resolve `@/` path aliases — use relative imports.

## References

- Claude Code — Skills: https://code.claude.com/docs/en/skills
- Agent skills (community catalogue): https://agentskills.io
- Prisma — Schema reference: https://www.prisma.io/docs/orm/prisma-schema
- Prisma — Migrate: https://www.prisma.io/docs/orm/prisma-migrate
- Prisma — Seeding: https://www.prisma.io/docs/orm/prisma-migrate/workflows/seeding
