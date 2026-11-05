<details>
<summary>💡 Hint 1: Say "use TDD" explicitly</summary>

The agent won't reliably do it otherwise. Ask for tests only, review them, run them — then ask for
the implementation in a separate prompt.

</details>

<details>
<summary>💡 Hint 2: Green against the reference first</summary>

A contract test that fails against `bookmonkey-api` describes a wish, not the contract. Get the
suite green on port 4730 before your backend exists.

</details>

<details>
<summary>💡 Hint 3: Tests that create books leave traces</summary>

Use unique ISBNs per test run and clean up after yourself — `POST /dev/reset` restores the
reference API's seed. For your backend, use a throwaway database, never your dev data.

</details>
