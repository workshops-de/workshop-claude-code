<details>
<summary>💡 Hint 1: A plan you never argue with is a rubber stamp</summary>

Ask "why is this step needed?" for anything that surprises you — extra libraries especially. Keep
the first scaffold minimal; the component library arrives in the skills task, on purpose.

</details>

<details>
<summary>💡 Hint 2: Your edit beats a long correction prompt</summary>

If you'd need three sentences to explain a change, it is often faster to open the plan with
`Ctrl+G` and just write it the way you want.

</details>

<details>
<summary>💡 Hint 3: The page is empty, but the API is up?</summary>

Check what the browser actually requested and whether the request ran on the server or in the
client. `NEXT_PUBLIC_` variables are inlined at build time — restart the dev server after changing
`.env.local`.

</details>

<details>
<summary>💡 Hint 4: The build says `"dynamic" is not compatible with cacheComponents`</summary>

Current `create-next-app` (Next.js 16) turns on Cache Components. The old fix
`export const dynamic = "force-dynamic"` now breaks the build. Data fetched at request time has to
render inside a `<Suspense>` boundary instead: move the fetch into its own async Server Component
and wrap it.

</details>
