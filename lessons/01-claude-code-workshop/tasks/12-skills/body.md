## Overview

Package a repeatable, project-specific procedure as a **skill** so the agent applies your team's
pattern consistently — without you re-explaining it each session. Skills use _progressive
disclosure_: their short description is always available, and the full instructions load only
when relevant, keeping context lean.

## Prerequisites

- **Required:** `find-skills` (`npx skills add vercel-labs/skills@find-skills -y`) — discover
  existing skills and study their structure before authoring your own.

## Background

A skill is a small package (a `SKILL.md` plus optional supporting files) whose description is
loaded into context; the agent reads the full body only when the task matches. That makes skills
ideal for procedures you repeat — like adding a feature, writing a commit message, or running a
release.

## Steps

1. Identify the procedure to encode — the feature-adding pattern from your earlier UI work (schema
   or validation change → validated server action → data helper → component → revalidate → quality
   checks).
2. Author a skill that captures those steps, with a **concise, trigger-friendly description** so
   the agent knows when to use it.
3. In a fresh session, give the agent a task that should match the skill (for example, "add a field
   to an entity") and confirm it **invokes the skill** and follows the steps — without being told
   to.
4. Refine the description and body based on what the agent did or missed.
5. Reflect on when you would reach for a skill versus putting the same content in project memory.

## Success Criteria

- [ ] A `SKILL.md` exists encoding "how we add a feature in this codebase"
- [ ] The agent invoked the skill on its own for a matching task, in a fresh session
- [ ] You refined the description at least once based on observed behaviour

## References

- Claude Code — Skills: https://code.claude.com/docs/en/skills
- Claude Code — Best practices: https://code.claude.com/docs/en/best-practices
- Agent skills (community catalogue): https://agentskills.io
