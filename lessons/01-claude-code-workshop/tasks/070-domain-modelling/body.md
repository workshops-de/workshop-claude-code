## Overview

Translate a written brief into a clear, shared domain model **before** writing any schema or code.
You will use the agent to restate the domain, surface ambiguities, and agree on precise
terminology. The lesson is that cheap alignment on meaning prevents expensive rework later.

## Background

A reference brief (the "clash" concept — activities happening at a place and time, hosted at
reusable venues, joined by request/approval) is a good stand-in if you don't yet have your own
product brief: see [`pawsaw/clash`](https://github.com/pawsaw/clash) for the full write-up. Getting
concepts and relationships precise now means the schema, validation, and UI all line up later.
Ambiguity is a context hazard: synonyms and vague terms lead the agent to merge things that should
stay distinct.

## Steps

1. Give the agent your brief and ask it to **restate the domain in its own words** — the core
   entities, how they relate, and the lifecycle of a join request (or your domain's equivalent).
2. Hunt for ambiguity: ask the agent to list terms that are unclear or could be confused, and
   resolve each into a single agreed definition.
3. Produce a **glossary** of the core entities and add it to your project memory so future
   sessions stay aligned.
4. Sketch the **entity model**: entities, their key attributes, the relationships between them
   (including which are optional), and the states an entity can be in.
5. Identify any constraints that matter (for example, uniqueness of a request per activity) and
   note them for the database design that follows.
6. Confirm the model against the brief end to end before moving on.

## Success Criteria

- [ ] The agent's restatement of the domain matches the brief (you corrected any drift)
- [ ] A glossary of the core entities is recorded where the agent can re-read it
- [ ] The entity model names every entity, its key attributes, relationships, and states
- [ ] Any uniqueness constraint is explicitly captured

## References

- Clash brief (reference domain): https://github.com/pawsaw/clash
- Domain modelling primer: https://martinfowler.com/bliki/UbiquitousLanguage.html
- Entity–relationship modelling overview: https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model
