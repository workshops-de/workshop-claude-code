## Overview

Explore running Claude Code against models and endpoints **other than the default Anthropic API** —
through enterprise providers and LLM gateways — and weigh the benefits, limitations, and
trade-offs.

> This is primarily an investigation-and-discussion task; you do not need a production gateway to
> complete it.

## Background

Claude Code talks to an Anthropic-compatible API. You can route that traffic elsewhere: enterprise
providers like Amazon Bedrock, Google Vertex AI, and Microsoft Foundry run Claude under your cloud
account; an **LLM gateway** sits between Claude Code and the provider, set via
`ANTHROPIC_BASE_URL`. Gateways centralize authentication, track and cap spend, and log
interactions — but you are still running Claude behind a compatible surface, not arbitrary
third-party or local models with full feature parity.

## Steps

1. Map the routes: list the ways to change where Claude Code sends requests and what each
   requires.
2. Read how an LLM gateway is configured and summarize what it provides an organization.
3. Identify the **limitation** clearly: why isn't this the same as plugging in any
   OpenAI-compatible or local model with full feature parity?
4. Evaluate **benefits, limitations, and trade-offs** for a concrete constraint (for example, "we
   must keep all traffic inside our cloud account and track per-team spend").
5. Write a short recommendation for that constraint, citing the relevant configuration.
6. Optionally, if you have access, set `ANTHROPIC_BASE_URL` against a sanctioned gateway and
   confirm a session connects.

## Success Criteria

- [ ] You listed the main routing options (enterprise providers vs. gateway) and what each requires
- [ ] You can explain the core limitation of "alternative models" in Claude Code
- [ ] You wrote a short, concrete recommendation for a given organizational constraint

## References

- Claude Code — LLM gateway configuration: https://code.claude.com/docs/en/llm-gateway
- Claude Code — Amazon Bedrock: https://code.claude.com/docs/en/amazon-bedrock
- Claude Code — Google Vertex AI: https://code.claude.com/docs/en/google-vertex-ai
- Claude Code — Enterprise deployment overview: https://code.claude.com/docs/en/third-party-integrations
