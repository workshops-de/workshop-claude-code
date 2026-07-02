## Overview

Experience the **BMAD Method** — a team of specialized agent personas running a facilitated agile
workflow — by taking a brief from idea to a working application. This contrasts both with ad-hoc
prompting and with the spec-centric Spec Kit flow.

## Background

BMAD ("Breakthrough Method for Agile AI-Driven Development") provides specialized agents —
analyst, product manager, architect, developer, QA, and more — plus facilitated workflows that
adapt planning depth to project complexity. A "party mode" brings several personas into one session
to resolve trade-offs. Build a **new, small application** here. Suggested brief: a reusable
packing-list app (templates, trips generated from templates, check-off progress).

## Steps

1. Install BMAD and choose the core module and Claude Code as the tool; confirm the agents and
   workflows are available.
2. Produce a short **product brief** using the analyst/PM persona.
3. Have the **product manager** persona turn the brief into a product requirements document.
4. Have the **architect** persona choose a stack and produce an architecture and key decisions.
5. Break the work into **stories**, then run the **developer** persona's dev loop — reviewing
   diffs and running the app as it builds.
6. Run a **QA** pass with the testing persona, and use **party mode** at least once to resolve a
   cross-cutting trade-off.
7. Use the method's **help** whenever you're unsure what comes next.

## Success Criteria

- [ ] BMAD is installed and configured for Claude Code
- [ ] A brief, PRD, and architecture exist as artifacts from their respective personas
- [ ] Stories were implemented via the developer persona's dev loop and the app runs
- [ ] Party mode was used at least once for a cross-cutting decision

## References

- BMAD Method — Repository & README: https://github.com/bmad-code-org/BMAD-METHOD
- BMAD Method — Documentation: https://docs.bmad-method.org/
- BMAD Method — Getting started tutorial: https://docs.bmad-method.org/tutorials/getting-started/
