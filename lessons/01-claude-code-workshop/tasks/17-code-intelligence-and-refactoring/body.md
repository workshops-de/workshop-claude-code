## Overview

Use Claude Code to improve the structure of code you already own — making it clearer, more
modular, and more maintainable — while learning **where an agent adds value and where your IDE is
faster**. Refactoring with an agent is about intent backed by a safety net of tests.

## Background

Agents excel at refactors that require understanding and judgement — restructuring a tangled
module, applying a pattern across many call sites. They are _not_ the fastest tool for mechanical
edits your IDE does instantly (rename a symbol, extract a method).

## Steps

1. Find a part of your codebase that has grown awkward — an overgrown file, a hard-to-read
   function, or a pattern applied inconsistently.
2. Ask the agent (planning mode first) for a **refactor with explicit intent**, reviewing the plan
   before it runs.
3. Apply the refactor and **verify behaviour is unchanged** using tests and a careful read of the
   diff.
4. Now try a deliberately _mechanical_ change and notice it's faster in your editor.
5. Reflect on which refactors benefited from the agent's understanding and which did not.

## Success Criteria

- [ ] A judgement-heavy refactor was planned, reviewed, and applied
- [ ] Tests (or a careful diff read) confirm behaviour is unchanged
- [ ] You identified at least one mechanical change better done in the IDE

## References

- Refactoring catalogue (Martin Fowler): https://refactoring.com/catalog/
- Claude Code — Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code — Best practices: https://code.claude.com/docs/en/best-practices
