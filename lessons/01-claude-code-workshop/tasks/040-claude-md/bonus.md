## Going further — memory at scale & evolution

- **Per-directory `CLAUDE.md` and path-scoped rules** keep instructions local to the code they
  govern.
- **`claudeMdExcludes`** skips memory for packages you never touch.
- **Auto memory** lets Claude accumulate durable learnings on its own during a session.
- **Let memory evolve** — a `Stop` hook can review a session and propose `CLAUDE.md` updates while
  the gap it exposed is fresh.

Try wiring a simple `Stop` hook that reminds you to review `CLAUDE.md` after a long session.
