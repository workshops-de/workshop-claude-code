## Overview

Learn to treat the **context window as your most valuable, finite resource** and to manage it
deliberately. You will practise keeping the agent's working memory focused, recognising when
context has degraded, and resetting or condensing it so the agent stays accurate on longer pieces
of work.

## Background

A model's quality drops as its context fills with noise, contradictions, or sheer length — the
"lost in the middle" effect means information buried in a long context gets less attention. Bigger
context is not automatically better. Skilled practitioners therefore _engineer_ context: they put
the right things in, keep noise out, summarize when sessions get long, and start fresh for
unrelated work.

## Steps

1. Start a session and deliberately make it long and noisy — ask several loosely related
   questions, read a few files, paste in some unrelated text. Watch the window fill with
   `/context`.
2. Observe how the agent's answers change as the context grows. Note any drift, repetition, or
   loss of earlier detail.
3. **Condense** the session into a focused summary with `/compact` and continue working from the
   smaller context. Compare the responses before and after.
4. Begin a genuinely **new, unrelated task** and start a clean context for it with `/clear` instead
   of continuing the polluted one.
5. Rewrite one of your earlier prompts so the key constraint sits at the very beginning (or end),
   and observe whether the result improves.
6. Reflect: which failure modes did you actually trigger, and which habit fixed each one?

## Success Criteria

- [ ] You observed context usage grow via `/context` on a deliberately long session
- [ ] You compacted a session and continued from the smaller context
- [ ] You started a clean context for an unrelated task
- [ ] You can name at least two context failure modes in your own words

## References

- Claude Code — Manage context: https://code.claude.com/docs/en/common-workflows
- Claude Code — Costs & context usage: https://code.claude.com/docs/en/costs
- "Lost in the Middle" (Liu et al., 2023): https://cs.stanford.edu/~nfliu/papers/lost-in-the-middle.arxiv2023.pdf
