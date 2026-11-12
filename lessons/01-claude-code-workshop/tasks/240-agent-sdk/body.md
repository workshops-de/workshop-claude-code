> **✅ No server needed:** you do not have to start anything before this task.

---

This task is about the **Claude Agent SDK**: Claude Code as a library, so you can start an agent from your own TypeScript code. You work in a new, empty folder with Node.js 24 (18.14 and up also works). You use the same login as in Claude Code, no API key needed.

### 1. Create a project

Open the terminal in the desktop app in a folder outside your other projects and run:

```bash
mkdir mein-agent && cd mein-agent
npm init -y
npm pkg set type=module
npm install @anthropic-ai/claude-agent-sdk tsx
```

`tsx` runs TypeScript files directly. Then open the folder `mein-agent` as a project in a new session.

### 2. Let Claude write the agent

```text
Create utils.py with two small Python functions, each preceded by a TODO comment. Then write agent.ts: a script using the Claude Agent SDK (@anthropic-ai/claude-agent-sdk, query) that has the agent find and summarize all TODO comments in the folder. The agent only gets the tools Read, Glob and Grep, loads no .claude configuration (the setting for that is called settingSources, it stays empty), and the script prints text and tool names.
```

Claude creates both files. Read through `agent.ts`: `query` starts the agent, `tools` defines what it can do at all.

### 3. Start the agent

```bash
npx tsx agent.ts
```

The agent searches and summarizes without you confirming anything. In our run, a list with both TODOs from `utils.py` appeared in the terminal after a few seconds.

### 4. Give it a task it cannot do

You write the prompt yourself. You want to see what happens when the agent should write something but may only read.

For example:

```text
Change the prompt in agent.ts so the agent also writes the TODOs it finds into a new file notizen.txt. Change nothing else.
```

Run `npx tsx agent.ts` again. In our run, `notizen.txt` was not created, and the agent said it is missing a write tool.

### 5. Get structured output

```text
The agent should return the TODOs as structured output (JSON schema with file, line and text per TODO). In the script, print them as a list with one line per TODO.
```

Run the script again. Your code now gets data it can process further, instead of free text.

### What just happened

The agent is the same loop as in Claude Code: read, search, answer. Your code decides what it may do through `tools`, and you do not have to answer prompts. That is why you use the CLI for daily work and the SDK when a script, a service or a CI pipeline should start the agent itself.

**Done when** your script prints the TODOs as a structured list and the write request in step 4 created no file.

<details>
<summary>More</summary>

Login: For the SDK, the docs describe the API key (`ANTHROPIC_API_KEY`) as well as Bedrock, Vertex and Foundry, and note that third-party developers may not offer claude.ai login to their users unless Anthropic approved it. In our test the script ran on a machine without `ANTHROPIC_API_KEY`, using the existing Claude Code login. For a product that others use, you need an API key from the Console.

[Overview](https://code.claude.com/docs/en/agent-sdk/overview) · [Quickstart](https://code.claude.com/docs/en/agent-sdk/quickstart) · [Example agents](https://github.com/anthropics/claude-agent-sdk-demos) · [Python version](https://code.claude.com/docs/en/agent-sdk/python)

</details>
