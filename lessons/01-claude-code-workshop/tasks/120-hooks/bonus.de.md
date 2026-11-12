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

### Einen `SessionStart`-Hook die Server starten lassen

Eine Idee aus dem Kurs: Statt beide Server vor Schritt 7 von Hand zu starten, übernimmt das ein Hook.

```text
Richte einen SessionStart-Hook nur für startup ein: Er prüft, ob Port 4730 (npx bookmonkey-api) und Port 3000 (npm run dev) antworten. Jeder fehlende Server startet im Hintergrund, mit Log in .claude/logs/, das Git ignoriert. Der Hook wartet nicht auf die Server und sagt dir in einer Zeile, welche Server laufen.
```

Startet eine neue Session und fragt `Welche Server laufen?`. Claude weiß es ohne Tool-Aufruf, weil die Ausgabe des Hooks in seinen Kontext kommt.

Wann es eine Falle ist: Die Server laufen nach der Session weiter (stoppen mit `lsof -ti :3000 | xargs kill`), und in einem Team-Repo überrascht ein Hook, der Prozesse startet. Dort ist ein Hook, der nur prüft und meldet, oft die bessere Wahl.
