> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about **LLM gateways**: a gateway is a server that Claude Code sends its requests to instead of talking directly to Anthropic. You build a small gateway to try things out, look at what Claude Code sends to it, and derive a recommendation for your company.

Work in a new, empty folder `gateway-test` (for example `mkdir gateway-test && cd gateway-test`), opened in the desktop app, with Node.js 22 or newer. You need no account and no API key.

### 1. Let Claude write a test gateway

Start a new session and send:

```text
Write mock-gateway.js: a Node script without dependencies that imitates an Anthropic-compatible endpoint on port 3420. It answers POST /v1/messages as a stream in the format of the Anthropic Messages API with the fixed text 'Hallo vom Mock-Gateway.' For every request it prints one line to the terminal: path, requested model, number of tools, whether it streams, and which header carried the authentication (only the name of the header, never the value).
```

Claude creates `mock-gateway.js`. It always answers with the same sentence, there is no real model behind it.

### 2. Start the gateway

In the desktop app, open a terminal in the project folder and run:

```bash
node mock-gateway.js
```

Leave it open, it will show every request in a moment.

### 3. Send a request through the gateway

Open a second terminal in the same folder. `ANTHROPIC_BASE_URL` tells Claude Code where to send its requests, `ANTHROPIC_AUTH_TOKEN` is a made-up token here. On Windows use Git Bash:

```bash
ANTHROPIC_BASE_URL=http://localhost:3420 ANTHROPIC_AUTH_TOKEN=test-token claude -p "Sag Hallo"
```

The answer is your fixed sentence, not a real Claude. The first terminal shows lines with `/v1/messages`. In our run there were three: one request with 13 tools and two small ones without tools.

### 4. Change the model name

The same line, with a model name that does not exist:

```bash
ANTHROPIC_BASE_URL=http://localhost:3420 ANTHROPIC_AUTH_TOKEN=test-token ANTHROPIC_MODEL=firma-modell-1 claude -p "Sag Hallo"
```

The gateway terminal now shows `firma-modell-1`. In our run Claude Code reported that it does not know the model and carried on anyway. This is how a company sets which model names its gateway offers.

### 5. Write it yourself: the gateway keeps a log

A gateway can write requests down for audits. Stop it with Ctrl+C, tell Claude in your own words that every request should go into a file, restart the gateway, and repeat step 3 with a different prompt.

For example:

```text
Extend mock-gateway.js: for every request with stream=true, the gateway appends a line to audit.log with the time and the text of the last user message.
```

Open `audit.log`. In our run the line was about 19 KB long: before the prompt came the content of our own CLAUDE.md files. Claude Code sends your prompt together with context, and the gateway sees everything in plain text.

### 6. Write it yourself: a recommendation from the docs

Formulate a constraint like one from your company and have Claude read the docs for it. Ask for the docs page behind every statement so you can check.

For example:

```text
Unsere Rahmenbedingung: Aller Verkehr muss in unserem eigenen AWS-Account bleiben, und wir wollen die Kosten pro Team sehen. Lies https://code.claude.com/docs/en/llm-gateway und https://code.claude.com/docs/en/amazon-bedrock und empfiehl uns eine Routing-Option mit den Umgebungsvariablen, die wir dafür setzen. Nenne bei jeder Aussage die Docs-Seite, auf der sie steht.
```

In our run Claude separated what the docs say from its own knowledge and asked us to check the latter. Check two variable names yourself on the page it names.

### 7. Clean up

Stop the gateway with Ctrl+C and delete `audit.log`, the file contains your prompts and configuration files.

### What just happened

A gateway sees every request completely. That is why it can handle authentication, cost and audit in one place, and why your company has to trust it like the model provider. With a gateway you only change the route to Claude. According to the docs, Anthropic does not support routing Claude Code to non-Claude models.

**Done when** you have seen requests with the model name in the gateway terminal, `audit.log` contained your prompt, and you have a recommendation in which two variable names appear on the docs page named.

<details>
<summary>More</summary>

Everything here is according to the docs, not tried by us, because it needs a provider account.

- The desktop app does not read `ANTHROPIC_BASE_URL`, it has its own configuration for third-party inference. That is why this test uses the terminal: [Connect Claude Code to an LLM gateway](https://code.claude.com/docs/en/llm-gateway-connect)
- A gateway offers credentials, usage tracking per developer or team, cost limits and audit logs: [LLM gateway](https://code.claude.com/docs/en/llm-gateway)
- Bedrock, Vertex AI and Foundry are routes straight into your cloud account without your own gateway: [Amazon Bedrock](https://code.claude.com/docs/en/amazon-bedrock), [Google Vertex AI](https://code.claude.com/docs/en/google-vertex-ai), [Overview](https://code.claude.com/docs/en/third-party-integrations)
- Data protection: for Team, Enterprise, API and third-party providers, Anthropic does not train on code and prompts according to the docs. Metrics, error reports and `/feedback` are off by default on Bedrock, Vertex and Foundry, and `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` switches off side traffic. Whether that meets your requirements is for your data protection office: [Data usage](https://code.claude.com/docs/en/data-usage)

</details>
