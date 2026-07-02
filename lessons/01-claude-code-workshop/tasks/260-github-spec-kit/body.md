## Overview

Experience **Spec-Driven Development** with GitHub Spec Kit by taking a brief from intent to a
working application through an explicit, multi-step process. The **specification is the source of
truth**, and the implementation is generated from it — a sharp contrast to ad-hoc prompting.

## Background

Spec Kit provides slash commands that walk you through governing principles, a specification of
the _what_ and _why_, an optional clarification pass, a technical plan, a task breakdown, an
optional consistency analysis, and finally implementation. Build a **new, small application** here
(not your Clash build) so the method — not the domain — is the lesson. Suggested brief: a personal
habit tracker (define habits, check in daily, see streaks).

## Steps

1. Install the Spec Kit CLI and **initialize** a new project configured for Claude Code; confirm
   the spec-driven slash commands are available.
2. Establish the project's **governing principles** (quality, testing, accessibility, data
   locality).
3. **Specify** what to build and why — focus on user stories and requirements, not technology.
4. Run a **clarification** pass and answer the questions it raises.
5. Create a **technical plan**, then a **task breakdown** of small, independent units.
6. Optionally run a **consistency analysis**, then **implement** — reviewing diffs and running the
   app as it builds.
7. Change one requirement and practise updating the **spec first**, then re-deriving the work.

## Success Criteria

- [ ] Spec Kit is installed and initialized with the Claude Code integration
- [ ] Constitution, specification, plan, and tasks all exist as durable artifacts
- [ ] The app was implemented from the tasks and runs
- [ ] You updated the spec first for one changed requirement, then re-derived the work

## References

- Spec Kit — Repository & README: https://github.com/github/spec-kit
- Spec Kit — Documentation: https://github.github.io/spec-kit/
- Spec Kit — Spec-Driven methodology: https://github.com/github/spec-kit/blob/main/spec-driven.md
- uv (required to install the CLI): https://docs.astral.sh/uv/
