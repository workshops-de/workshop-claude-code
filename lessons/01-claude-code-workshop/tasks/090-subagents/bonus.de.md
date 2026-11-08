## Weiterführend – Multi-Agent im großen Maßstab

Ein einzelner Subagent ist erst der Anfang. Claude Code kann **viele** Agents koordinieren:

- **Parallele Subagents** – lasst einen Reviewer und einen „Test-Runner“-Subagent (meldet nur
  bestanden/durchgefallen und die Namen fehlgeschlagener Tests) gleichzeitig laufen.
- **Agent Teams** – mehrere Claude-Code-Sessions, die mit gemeinsamen Aufgaben und
  Nachrichtenaustausch zwischen den Agents zusammenarbeiten.
- **Worktrees** – isolieren parallele Sessions und Subagents, damit ihre Änderungen nicht
  kollidieren.
- **Eine ganze Session als Agent laufen lassen** – `claude --agent security-reviewer` gibt dem
  Haupt-Thread die Tool-Einschränkungen und das Modell des Reviewers.

Versucht, einen zweiten Subagent hinzuzufügen, der Tests ausführt, und delegiert in einem Prompt an beide.
