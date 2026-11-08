## Weiterführend: tieferes und automatisiertes Review

- **`/code-review ultra`** führt ein tiefes Multi-Agent-Review in der Cloud aus (Ultrareview). Es
  gibt ein paar kostenlose Läufe in den Plänen Pro, Max und Ultra, danach braucht es
  Nutzungs-Credits.
- **Reviewt eure eigene Arbeit**: Öffnet einen Draft-Pull-Request für euer BookMonkey-Frontend,
  lasst Claude die Beschreibung aus dem Diff entwerfen und führt `/code-review --comment` darauf
  aus, damit die Findings im PR landen.
- **Automatisiert es**: Die GitHub-Actions-Aufgabe führt Claude aus einem Workflow aus; dieselbe
  Action kann jeden Pull Request reviewen.
- **Code Review for GitHub** (Team und Enterprise) reviewt jeden PR automatisch, konfiguriert mit
  `REVIEW.md` und eurer `CLAUDE.md`.
