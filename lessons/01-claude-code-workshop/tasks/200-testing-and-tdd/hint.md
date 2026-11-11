<details>
<summary>💡 Hint 1: Say "use TDD" explicitly</summary>

Otherwise Claude will not reliably do it. First ask only for tests, review them, and ask for the implementation in a separate prompt.

</details>

<details>
<summary>💡 Hint 2: Green against the API first</summary>

A contract test that fails against `bookmonkey-api` describes a wish, not the contract. Get the suite green on port 4730 before you build the backend. Fix the test, never the API.

</details>

<details>
<summary>💡 Hint 3: Tests that create books leave traces</summary>

Every test uses its own ISBN and deletes its book with `DELETE`. If something is left over, `curl -X POST http://localhost:4730/dev/reset` restores the API's data.

</details>
