> **⚠️ Must be running:** each in its own terminal. Start what is not running yet and keep it open for the whole task.
> - API: `npx bookmonkey-api` (http://localhost:4730)

---

This task is about **Plan Mode**: Claude first proposes a plan and changes nothing, you correct the plan, and only then does it build.

You work in a new, empty folder `bookmonkey` with Node.js 26 (for example `mkdir bookmonkey && cd bookmonkey && git init`). Open it in the desktop app and start a new session there.

### 1. Let Claude make a plan

Set the mode to **Plan** and send:

```text
Plan a new Next.js project with TypeScript and Tailwind for BookMonkey, a book catalog. It should have a public and a protected area, separated by route groups. The start page shows the titles of the first five books from http://localhost:4730/books?_limit=5. Do not change anything yet, I want to see the plan first.
```

Claude reads and checks, shows a plan and creates no project files. Look at the folder: it is still empty.

### 2. Correct the plan

Read the plan closely. In our run it contained things we did not want: a `src` folder, an environment variable with a different name, a login page with a cookie check. The correction sets what later tasks need. If the app offers to approve the plan, do not do that yet and type your change into the input field. Send:

```text
Change the plan: no src folder, the pages live directly in app/. The environment variable is called NEXT_PUBLIC_API_URL. The protected area is for now just a page /library with a short heading, without login and without a cookie. I will add sign-in myself later. Show me the new plan, do not change anything yet.
```

Claude shows a new plan that takes over your points. The folder is still empty.

### 3. Correct it yourself

Find something in the new plan that you want differently and write the correction yourself. Later tasks build on this, so make sure you reach this: the two route groups are called `(public)` and `(app)`, and the function for the API lives in `lib/api.ts`. Also say that Claude should not change anything yet.

For example:

```text
The two route groups should be called (public) and (app), and the function for the API should live in lib/api.ts. Show me the new plan, do not change anything yet.
```

### 4. Approve the plan

Now you trust the plan. Approve it if the app offers that, or switch the mode from Plan to Auto so Claude may change files. Then send:

```text
The plan is fine. Implement it and run npm run build at the end to check that everything works.
```

The installation takes a few minutes. The first build can fail because of the Next.js feature Cache Components. Claude usually fixes that itself. Make sure it does not simply turn the feature off: the clean fix is a `<Suspense>` around the fetch.

### 5. Look at the result

```text
Start the development server and tell me the URL.
```

Open the address in the browser: five book titles appear. Under `/library` you see the heading of the protected area. It only becomes protected in the subagents task.

### 6. Commit what you have read

```text
Make the first commit. Read the changes first and write a fitting commit message.
```

Check in the commit summary that `.env.local` is not included. The `.env.example` should be included. The template ignores all `.env*` files, so the `.gitignore` needs the line `!.env.example`.

### What just happened

In Plan Mode Claude only reads and does not change your code. You changed the plan twice before the first file existed. You change a plan with one sentence; cleaning up a finished project takes longer. Remember: **check and correct the plan first, then let it build**.

**Done when** `/` shows five book titles from the API, `/library` is reachable and the project is committed.

<details>
<summary>More</summary>

- Plan mode: https://code.claude.com/docs/en/permission-modes#analyze-before-you-edit-with-plan-mode
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
- Route groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups

</details>
