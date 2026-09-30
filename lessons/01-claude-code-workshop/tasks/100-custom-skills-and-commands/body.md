## Overview

Build your first full feature slice — list, detail, create, and edit screens — on top of the
established read/write architecture, using shadcn/ui components and form validation. You will give
the agent the project's repeating "shape" for a feature and reuse it, so every feature you add
stays consistent.

## Prerequisites

- **Required skills:** `shadcn`, `prisma-client-api`
- Recommended: `frontend-design`, `react-best-practices`

## Background

The application is server-first: **reads** happen in server components calling data-access
helpers, and **writes** happen through server actions that validate input, enforce authorization,
persist via the ORM, and revalidate affected paths. Validation schemas are shared between forms and
actions so there is one source of truth.

## Steps

1. Plan a feature for one entity covering **list, detail, create, and edit**. Decide the list's
   search, filter, and sort behaviour.
2. Implement **reads** through data-access helpers consumed by server components; implement
   **writes** through server actions that validate with a shared schema, authorize, persist, and
   revalidate.
3. Build the screens with the component library, including a form that surfaces validation errors
   clearly.
4. Verify the whole slice in the browser: create, view, edit, and see the list update.
5. Apply the **same shape** to a second entity to prove the pattern reuses cleanly. Note where the
   only differences are.
6. Capture the feature pattern in your project memory for future reuse.

## Success Criteria

- [ ] List pages support search and sort; results update on submit
- [ ] New/Edit write through a validated Server Action and the list/detail refreshes afterward
- [ ] Detail pages show host info; only the host sees Edit/Delete
- [ ] `tsc --noEmit` and `npm run build` pass; reads render seeded data when signed in

## Pitfalls (current framework)

- `params` and `searchParams` are **Promises** on recent Next.js — `await` them in pages.
- SQLite search via Prisma's `contains` is **case-sensitive** — decide if that matters for you.
- Bind an id into a Server Action while keeping the `(prev, formData)` signature: `action.bind(null, id)`.
- A date/time input needs its default value in a specific string format.

## References

- Next.js — Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
- shadcn/ui — Components: https://ui.shadcn.com/docs/components
- Zod — Schema validation: https://zod.dev
