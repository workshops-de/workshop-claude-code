## Overview

Turn your agreed domain model into a real, migrated database with seed data, using Prisma and
SQLite. You will practise giving the agent a precise specification (your model) and **verifying
the result** — including letting the agent self-correct when a migration fails.

## Prerequisites

- **Required skills:** `prisma-cli`, `prisma-database-setup`
  (`npx skills add prisma/skills@prisma-cli -y`, `npx skills add prisma/skills@prisma-database-setup -y`)
- Recommended: `prisma-next`, `prisma-client-api`

## Background

Prisma describes your data in a schema file, generates a type-safe client, and applies changes
through migrations. SQLite keeps the database to a single local file. One wrinkle: SQLite has no
native enums, so status- and type-like fields are stored as documented strings.

## Steps

1. Give the agent your entity model and ask it to draft the **schema** for every entity, with the
   correct relationships and any uniqueness constraint you identified.
2. Review the schema against your glossary: optional relationships, unique constraints, and
   status/type fields represented as documented strings.
3. Have the agent **migrate** the database and generate the client. If a migration fails, let the
   agent read the error and correct itself.
4. Ask the agent to write a **seed** with a realistic spread of demo data.
5. **Verify** by browsing the data (for example, with Prisma Studio) and confirming it matches your
   model.
6. Record the database commands (migrate, seed, reset, studio) in your project memory.

## Success Criteria

- [ ] The schema models all entities with correct relations and unique constraints
- [ ] A migration applies cleanly and the client generates to the expected location
- [ ] The seed runs and populates demo data you can browse
- [ ] `tsc --noEmit` passes with the client and your db helper imported

## Pitfalls (current Prisma)

Recent Prisma (7.x) changed setup — have the agent check the installed version and docs rather
than copying old snippets:

- The datasource may have **no `url`**; the connection string is read in `prisma.config.ts` from
  `DATABASE_URL`, and `.env` is not auto-loaded (`dotenv` must be installed).
- The client may generate to a **custom path** (e.g. `lib/generated/prisma`) — import from there.
- **Runtime needs a driver adapter** — construct the client with one, not a bare `new PrismaClient()`.
- A seed run via `tsx` won't resolve `@/` path aliases — use relative imports.

## References

- Prisma — Schema reference: https://www.prisma.io/docs/orm/prisma-schema
- Prisma — Migrate: https://www.prisma.io/docs/orm/prisma-migrate
- Prisma — Seeding: https://www.prisma.io/docs/orm/prisma-migrate/workflows/seeding
