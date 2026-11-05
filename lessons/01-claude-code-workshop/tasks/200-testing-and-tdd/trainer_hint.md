## Learning goals

- **Feature:** agent-assisted TDD — explicit test-first prompting, reviewing tests before code,
  edge-case hunting, protecting tests from "fixes", one runnable gate command.
- **Concepts:** tests as a done-signal; characterization/contract tests; ephemeral test databases.
- **Practice ground:** contract tests against the reference `bookmonkey-api`, then the first two
  endpoints of an own NestJS backend driven by the same suite.
- **Takeaways:** ask for TDD explicitly; get the tests right against reality first; make gates the
  agent can run.

## Facilitation notes

- Frame the storyline: since task 090 everyone knows the API doesn't enforce the token — this is
  where the own backend starts. Task 230 finishes it autonomously.
- The "green against the reference first" step is the important twist. Agents tend to write tests
  from the OpenAPI spec that the real API doesn't quite satisfy — fixing the test is the lesson.
- Watch for agents editing tests to make them pass. If it happens, show the protect-the-tests hook
  idea from the bonus.
- Port conflicts: Next.js uses 3000, the reference API 4730 — suggest 3001 for the own backend.
- If time is tight, `GET /books/:isbn` alone is enough to see the loop; `POST` can move to 230.
- Directly foreshadows Headless & Automation: the gate command built here gets wrapped into a
  script next.

## Time estimate

~60 minutes.
