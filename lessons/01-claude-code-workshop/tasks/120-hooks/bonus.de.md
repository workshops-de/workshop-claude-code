## Weiterführend – der ganze Lifecycle

- **Weitere Events** – `Stop`, `SessionStart`, `UserPromptSubmit`, `PreCompact` und mehr, jedes
  mit eigener JSON-Eingabe und eigenem Exit-Code-Verhalten.
- **`SessionStart`** kann zu Beginn jeder Session Kontext einspeisen.
- **HTTP-, Prompt- und MCP-Tool-Hooks** erweitern die Automatisierung über lokale Shell-Skripte
  hinaus.
- **Hooks in Skills und Subagents**: Skill-Hooks aus dem Frontmatter bleiben ab dem Aufruf für den
  Rest der Session, Subagent-Hooks enden mit dem Agent.

Probiert einen `SessionStart`-Hook, der den Agenten an die Quality Gates eures Projekts erinnert,
oder einen `Stop`-Hook, der Lint ausführt, bevor der Agent sich für fertig erklärt.
