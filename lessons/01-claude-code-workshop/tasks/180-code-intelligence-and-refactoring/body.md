## Overview

Use Claude Code for a refactor that a real team would hesitate to start: large, spread across many
files, in code you did not write. You pin down today's behaviour with tests first, plan the change
in plan mode, let the agent do the heavy lifting, and prove that nothing changed that should not
have. Refactoring with an agent is about **intent backed by a safety net**.

## The Feature

Agents excel at refactors that need understanding and judgement: restructuring a tangled module,
applying one pattern across many call sites, finding every place that does the same thing a little
differently. They are _not_ the fastest tool for mechanical edits your IDE does instantly (rename a
symbol, extract a method).

- **Characterisation tests first.** Before you change structure, ask Claude to write tests that
  record what the code does _today_, right or wrong, through the public interface (HTTP endpoints,
  exported functions). They must pass before and after the refactor.
- **Plan mode for the change** (`claude --permission-mode plan` or `Shift+Tab`): get an inventory
  of every affected place, a step order that keeps the tests green after each step, and a list of
  risks. Push back before any file changes.
- **Small verified steps.** Let Claude run the tests after every step and commit when green, so a
  wrong turn costs one step, not the afternoon. `/rewind` and git are your undo.
- **Code intelligence (optional).** A language-server plugin gives Claude go-to-definition and
  find-references instead of grep (see the bonus).

## Apply it to BookMonkey Legacy

The practice ground is your [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)
clone. The product owner has two requests on the board. Pick **one**:

- **(a) "Prices must be consistent everywhere."** Every place that shows, sums, stores, or exports
  a price goes through one money and pricing path that works in integer cents. The customer sees
  the same price for the same book on every screen, in the cart, at checkout, and in exports.
- **(b) "Split the big v1 routes file by resource, without changing behaviour."** `api/routes.js`
  becomes one file per resource, following the pattern that `api/routes/` already started. Every
  endpoint answers exactly as before: same status codes, same bodies, same access rules.

Your team allows it? Then you may refactor a part of **your own codebase** instead, with the same
steps: characterisation tests, plan, small verified steps.

## Prerequisites

- The `bookmonkey-legacy` clone with `npm install` and `npm run db:reset` done, and your
  `CLAUDE.md` from the CLAUDE.md task (040)
- A branch for the work: `git switch -c refactor/prices` or `git switch -c refactor/split-routes`

## Steps

1. **Map the territory** in plan mode. For (a): every place that computes, shows, sums, stores,
   or exports a price, in the API and in the web app. For (b): every endpoint in `api/routes.js`,
   grouped by resource, with the middleware that applies to it. Ask for file and line for each.
2. **Write characterisation tests** for what you are about to touch, using the existing
   `node:test` setup in `api/test/` (run with `npm test`). For (a): the prices of a few books as
   every part of the app returns them today. For (b): status code and response shape of each
   endpoint, including the error cases. Commit the
   tests while they are green.
3. **Plan the refactor.** Ask for a plan with steps that each keep `npm test` green, then challenge
   it at least once (a step that's too big, a place it missed, a behaviour it wants to "fix" on the
   way). Edit the plan with `Ctrl+G` if needed.
4. **Execute step by step.** Approve the plan, let Claude run the tests after each step, and commit
   after each green step. If a test fails, stop and decide: refactoring mistake, or did the test
   capture something wrong?
5. **Verify** beyond the tests: read the full diff (`git diff main --stat`, then the files), start
   both dev servers, and check a few pages in the browser. For (a), compare the price of the same
   book on every screen. For (b), click through the admin.
6. Now try a deliberately **mechanical** change (rename a helper, move a function) once with
   Claude and once with your IDE, and notice which is faster.
7. Reflect: where did the agent's understanding pay off, and where did the tests catch it?

## Success Criteria

**Feature**

- [ ] Characterisation tests existed and passed **before** the first structural change
- [ ] The refactor was planned in plan mode, and the plan changed at least once because you pushed
      back
- [ ] The work landed as several small commits, each with green tests
- [ ] You identified at least one mechanical change that was faster in the IDE

**App still works**

- [ ] `npm test` passes, including your new tests
- [ ] For (a): one book shows the same price on every screen, in the cart, at checkout, and in the
      export; for (b): `api/routes.js` is gone or reduced to mounting, and every endpoint behaves
      as before
- [ ] Behaviour that looked wrong but was not part of the request is written down, not silently
      changed

## References

- Claude Code: Common workflows (refactor code): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- Claude Code: Checkpointing (`/rewind`): https://code.claude.com/docs/en/checkpointing
- Michael Feathers: Characterization testing: https://michaelfeathers.silvrback.com/characterization-testing
- Refactoring catalogue (Martin Fowler): https://refactoring.com/catalog/
- Martin Fowler: Money pattern: https://martinfowler.com/eaaCatalog/money.html
