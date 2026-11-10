This task is about **test-driven development (TDD) with an agent**: tests come first, then the code, and the tests tell Claude when it is done. You write tests for the behaviour of the finished API and use them to build your own NestJS backend.

You work in your `bookmonkey` repository with Node.js 26. The API runs in a terminal with `npx bookmonkey-api` at http://localhost:4730. Keep it running for the whole task.

### 1. Let Claude write the tests

```text
Use TDD. Set up a package contract-tests/ (Vitest, fetch) that reads the base URL from the environment variable API_URL. Write tests for GET /books/:isbn (200 with the book structure, 404 for an unknown ISBN) and POST /books (201 with server-set id, createdAt and updatedAt, 409 for a duplicate ISBN, 400 for a missing title). Every test uses its own ISBN and deletes its book again with DELETE. Exclude contract-tests/ in the root tsconfig.json. In the root package.json add the script "contract": cd contract-tests && npx vitest run. Do not write any implementation yet and do not run the tests yet.
```

Only tests appear. They are called **contract tests** because they pin down how the API behaves.

### 2. Check the tests against the real API

```text
Install whatever contract-tests/ is missing and run the tests with API_URL=http://localhost:4730 npm run contract against the running bookmonkey-api. If a test fails, the test is wrong, not the API: check with curl what the API really answers and fix the test.
```

A test that is already red against the real API describes a wish, not a contract. In our run one test was red because Claude had assumed something about the response that the API does not deliver. In the end all are green.

### 3. Add edge cases

Edge cases are unusual inputs nobody thinks of first. You write this prompt yourself: Claude should list what is missing in the tests, add the most important cases and check them against the API on port 4730.

For example:

```text
Which edge cases are missing in the contract tests for GET /books/:isbn and POST /books? List them briefly, add the most important ones as tests and run the suite against http://localhost:4730. If a new test fails, fix the test, not the API.
```

### 4. Create the backend

Start a new session and send:

```text
Create a NestJS backend in backend/ with npx @nestjs/cli new backend --package-manager npm --skip-git. It should run on port 3001 when the environment variable PORT is not set. Remove the example route together with its test, there are no Books endpoints yet. Exclude backend/ and contract-tests/ from the frontend tooling in the root tsconfig.json and in the root eslint.config.mjs. Do not start the backend yet.
```

The type-check hook from the hooks task runs in the main project on every change. `backend/` and `contract-tests/` have their own settings, so you exclude them there. Then start the backend in a second terminal with `cd backend && npm run start:dev`.

### 5. See the tests fail

In the root folder run `API_URL=http://localhost:3001 npm run contract` (PowerShell: `$env:API_URL="http://localhost:3001"; npm run contract`). In our run 14 of 17 tests failed, because the backend does not know books yet.

### 6. Let Claude implement just enough

Start a new session and send:

```text
The backend in backend/ runs in watch mode at http://localhost:3001. Implement a Books module just far enough that the contract tests in contract-tests/ turn green, the data lives in memory. The tests also need DELETE /books/:isbn for cleanup. Do not change anything in contract-tests/; if a test stays red, tell me why. Check with API_URL=http://localhost:3001 npm run contract.
```

Claude implements and runs the suite itself until it is green.

### 7. Build a gate command

A **gate** is a single command that runs all checks. Claude can start it itself and so knows what "done" means.

```text
In the root package.json add a script "gate" that runs type check, lint, build, the existing tests and the contract tests against the backend in sequence (API_URL defaults to http://localhost:3001) and stops at the first failure. Add to CLAUDE.md that npm run gate must be green before every "done" and that the bookmonkey-api (port 4730) and the backend must be running for it. Run the gate once.
```

### 8. Commit your state

```text
Commit all changes from this task. Read the diff first.
```

### What just happened

A running, failing test suite shows Claude more precisely than text what is missing and when it is done. For that, the tests were checked **against reality first**, and Claude was not allowed to change them. The gate needs the running API and the running backend.

**Done when** `npm run contract` is green against port 4730 and against your backend on port 3001, `npm run gate` is in `CLAUDE.md` and everything is committed.

<details>
<summary>More</summary>

`curl -X POST http://localhost:4730/dev/reset` restores the API's data. A hook that protects existing test files is shown in the bonus.

- Common workflows: https://code.claude.com/docs/en/common-workflows
- NestJS: https://docs.nestjs.com/first-steps
- Vitest: https://vitest.dev/guide/

</details>
