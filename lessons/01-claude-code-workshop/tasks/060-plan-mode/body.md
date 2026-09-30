## Overview

Turn an empty repository into a running web application skeleton, with the agent doing the
mechanical work while **you steer with a reviewed plan**. This is where your own version of Clash
begins to take shape.

## Prerequisites

- **Required skill:** `shadcn` (`npx skills add vercel/vercel-plugin@shadcn -y`) — the shadcn CLI is
  interactive and its flags change frequently; this skill keeps the agent on current commands.
- Recommended: `react-best-practices`, `frontend-design`.

## Background

Scaffolding is repetitive and well-documented — an ideal job to delegate to the agent. But
delegation without review invites surprises, so you use planning mode to see and approve the
approach first, then verify the dev server actually boots before declaring success. The target
stack is a Next.js App Router project in TypeScript, styled with Tailwind CSS and shadcn/ui
components — see [`pawsaw/clash`](https://github.com/pawsaw/clash) for the reference.

## Steps

1. In your empty repository, ask the agent — **in planning mode** — to propose how it would
   scaffold the base application. Review the plan and push back on anything beyond what you need.
2. Approve the plan and let the agent execute it. Watch for the commands it runs.
3. Establish a separation between a **public area** (for sign-in/registration later) and an
   **authenticated application area** (the main shell), using route groups.
4. Configure the styling layer and component library, and confirm a sample component renders.
5. **Verify**: start the development server and open the app in a browser.
6. Review the changes and make your first commit with a clear message.

## Success Criteria

- [ ] `npm run dev` serves the app and the shell renders
- [ ] Type-check and `npm run build` both pass
- [ ] A public route group and an authenticated route group both exist and render
- [ ] A component from the component library renders on a page
- [ ] The scaffold is committed with a message you reviewed

## References

- Next.js — App Router docs: https://nextjs.org/docs/app
- Tailwind CSS — Installation: https://tailwindcss.com/docs/installation
- shadcn/ui — Installation: https://ui.shadcn.com/docs/installation
- Next.js — Route groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups
