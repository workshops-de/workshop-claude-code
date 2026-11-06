<details>
<summary>💡 Hint 1: Test what is, not what should be</summary>

A characterisation test records today's output, even if it looks odd. If you "fix" the
expected value while writing the test, you can no longer tell whether the refactor changed
behaviour. Note the oddity and keep the test honest.

</details>

<details>
<summary>💡 Hint 2: The inventory is the real work</summary>

Ask for the inventory twice, in different ways: once by searching the code, once by following
the data (where does this value come from, where does it go next?). The places that only one of
the two finds are the ones that break later.

</details>

<details>
<summary>💡 Hint 3: Same behaviour includes the error paths</summary>

"Behaves as before" covers more than the happy path. Cover the error paths of the code you
touch too, not only the requests that succeed.

</details>

<details>
<summary>💡 Hint 4: Let the IDE win sometimes</summary>

"Rename this symbol everywhere" and "extract this method" are usually faster in the IDE. Save
the agent for the parts that need reading and judgement.

</details>
