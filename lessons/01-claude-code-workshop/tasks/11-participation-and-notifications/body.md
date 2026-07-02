## Overview

Implement the heart of the domain: people request to join an activity, hosts accept or reject, and
each transition notifies the right person. You will learn to **encode a state machine explicitly**
so the agent doesn't invent ad-hoc statuses, and to attach cross-cutting side-effects
(notifications) cleanly to the write path.

## Prerequisites

- Recommended: `prisma-client-api`, `react-best-practices`
- Optional: `agent-browser` to drive the flow end-to-end with two accounts.

## Background

A participation moves from _pending_ to _accepted_ or _rejected_; modelling those states and
transitions explicitly keeps the implementation honest. Every transition is a write that should
follow the same validated, authorized path as other mutations — and additionally emit a
notification to the right user.

## Steps

1. State the **transitions** to the agent: request-to-join creates a pending participation and
   notifies the host; accept and reject move it to the corresponding state and notify the
   requester. Confirm the agent restates them correctly.
2. Implement join/leave and host accept/reject as server actions that validate, **authorize** (only
   the host may decide), persist, emit the right notification, and revalidate.
3. Build the participant-facing UI (join/leave with feedback) and the host-facing requests view.
4. Add a grouped "my participations" view splitting going, awaiting approval, and declined.
5. Verify with two seeded accounts: one requests, the other (the host) accepts; confirm the
   notification reaches the right person and views update.
6. Optionally extend: notify a venue's owner when a new activity is created at their venue.

## Success Criteria

- [ ] Join/leave and host accept/reject work and enforce authorization
- [ ] Each transition emits a notification to the correct person
- [ ] Invalid transitions are rejected; a person can't request the same item twice
- [ ] "My participations" groups going / awaiting / declined correctly; `npm run build` passes

## References

- State machine concept: https://en.wikipedia.org/wiki/Finite-state_machine
- Next.js — Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
- Prisma — Relations and queries: https://www.prisma.io/docs/orm/prisma-client/queries
