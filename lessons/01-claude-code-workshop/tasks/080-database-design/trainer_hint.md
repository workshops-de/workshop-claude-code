## Learning goals

- **Skills:** turning a model into a schema; running and recovering from migrations; generating
  seed data with the agent.
- **Concepts:** schema-first modelling; relations and uniqueness constraints; representing enums
  as documented strings in SQLite.
- **Takeaways:** specify precisely, verify visually, let the agent close its own loop.

## Facilitation notes

- The Prisma 7.x pitfalls listed in the task were validated during an independent implementation
  pass — expect at least one participant to hit the driver-adapter or custom-generate-path issue;
  point them at the Pitfalls section rather than solving it for them.
- A failed migration self-correcting is one of the best live demonstrations of the Reason → Act →
  Observe loop from Day 1 — call it out explicitly if it happens.

## Time estimate

~45 minutes.
