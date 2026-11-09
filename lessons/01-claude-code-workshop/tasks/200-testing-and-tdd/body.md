## Overview

Practise **test-driven development** with an agent and let tests give it a built-in "done" signal.
You pin down the behaviour of the ready-made API in contract tests, then start your **own
backend** and drive it test-first until it behaves the same.

## The Feature

Agents are strong test writers and can run tests themselves, which makes tests the most reliable
feedback loop available to them. But they won't reliably do TDD unless you make it explicit:

- **Say it, and separate the phases**: "Use TDD. Write failing tests for X first. Do not write any
  implementation yet." Review the tests, run them, see them fail; only then ask for the
  implementation.
- **Make the agent hunt for edge cases** before implementing: ask it to enumerate them, then add
  the ones it missed.
- **Protect the tests**: tell the agent not to change tests to make them pass. A `PreToolUse` hook
  from the hooks task can enforce that on your test folder. Let it block edits to **existing** test
  files only, so you can still add new ones (you extend the suite in the autonomous workflows task).
- **One gate command** (type-check, lint, build, tests) the agent can run on its own, recorded in
  `CLAUDE.md` so every session knows what "done" means.

## Apply it to BookMonkey

> **Repo / ports:** your `bookmonkey` repository (Node.js 26), Next.js app on
> http://localhost:3000, `npx bookmonkey-api` on http://localhost:4730, your NestJS backend on
> http://localhost:3001
>
> **Login:** demo user `admin@bookmonkey.api` / `password1!`

So far your frontend talks to the ready-made `bookmonkey-api`. Now you start replacing it with your
own **NestJS** backend, without breaking the frontend. The safety net is a **contract test
suite** that only talks HTTP and reads its base URL from `API_URL`:

- Run against `http://localhost:4730`, the suite documents how the reference API behaves. If a
  test fails there, the test is wrong, not the API.
- Run against your backend, the same suite tells the agent exactly what's still missing.

`docs/openapi.json` from the rules task is the contract both sides share.

## Prerequisites

- The `bookmonkey-api` is running on port 4730; `docs/openapi.json` is committed.
- NestJS CLI available via `npx @nestjs/cli` (no global install needed).
- Optional skills if you choose Prisma + SQLite for persistence:
  `npx skills add prisma/skills@prisma-cli -y` and `npx skills add prisma/skills@prisma-database-setup -y`.

## Steps

1. Ask the agent to set up a `contract-tests/` package (Vitest + `fetch` or `supertest` against a
   URL) that reads `API_URL`. Instruct it to use **TDD**: write tests for `GET /books/:isbn` (200
   with the book shape, 404 for an unknown ISBN) and `POST /books` (201, server-set `id` /
   `createdAt` / `updatedAt`, **409 for a duplicate ISBN**, 400 for a missing title), no
   implementation anywhere. Add a root script so one command runs the suite (the autonomous workflows
   task relies on it): `"contract": "cd contract-tests && npx vitest run"` in the root `package.json`, used as
   `API_URL=http://localhost:4730 npm run contract` (PowerShell:
   `$env:API_URL="http://localhost:4730"; npm run contract`).
2. Review the tests, ask the agent to enumerate further **edge cases**, and add the ones it missed.
   Run the suite against the reference API: everything must be green. Fix tests, never the API.
3. Scaffold the backend in plan mode:
   `npx @nestjs/cli new backend --package-manager npm --skip-git` (without the flags the CLI waits
   for a package-manager prompt and creates a nested git repository), with a books module and a
   persistence choice you can defend (SQLite via Prisma is a good default). Use a throwaway test
   database, never your dev data. NestJS 12 scaffolds **ESM with Vitest and oxlint**; older
   tutorials with Jest and CommonJS don't match. Its sample `GET /` "Hello World" e2e test goes red
   once you remove the sample route: delete or adapt it.
   Before the first backend edit, **scope the frontend tooling to the frontend**: add `"exclude":
   ["node_modules", "backend", "contract-tests"]` to the root `tsconfig.json` and ignore both
   folders in the root `eslint.config.mjs`. Otherwise the type-check hook from the hooks task runs the
   root `tsc` over the new packages and fails (`TS1241`, `TS2582 Cannot find name 'describe'`).
4. Run the contract suite against your backend (`API_URL=http://localhost:3001`) and watch it fail.
   Then let the agent implement **just enough** to turn the tests from step 1 green, and tell it
   not to touch the tests.
5. Wire the **quality gates** (type-check, lint, build, unit tests, contract tests) into one command
   and record it in `CLAUDE.md`.
6. Reflect: how did a runnable, failing test suite change the agent's behaviour compared to a
   prose request?

## Success Criteria

**Feature**

- [ ] Tests were written and reviewed before any backend implementation existed
- [ ] You added at least one edge case the agent didn't think of
- [ ] The agent implemented against failing tests without editing them
- [ ] A single command runs all quality gates and is recorded in `CLAUDE.md`

**App still works**

- [ ] The contract suite is green against the reference API on port 4730
- [ ] The same suite is green for `GET /books/:isbn` and `POST /books` against your NestJS backend
- [ ] The frontend still runs unchanged against the reference API

## References

- Claude Code: Common workflows (testing): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- NestJS: First steps: https://docs.nestjs.com/first-steps
- Vitest: Getting started: https://vitest.dev/guide/
- Consumer-driven contracts (Martin Fowler): https://martinfowler.com/articles/consumerDrivenContracts.html
