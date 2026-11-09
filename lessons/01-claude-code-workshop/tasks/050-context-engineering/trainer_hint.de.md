## Lernziele

- **Feature:** `/context`, `/compact` mit Fokus-Anweisungen, `/clear`, `/btw`, Lesen an einen
  Subagent delegieren.
- **Konzepte:** das begrenzte Kontextfenster; Fehlerarten des Kontexts; „Lost in the Middle“;
  warum Legacy-Code das Fenster schnell füllt.
- **Takeaways:** kuratieren, was hineinkommt; Rauschen entfernen; wenn möglich eine Aufgabe pro
  frischer Session.

## Hinweise zur Durchführung

- Haltet es praktisch und zeitlich begrenzt. Das Fenster füllen viele Dateien, die mit dem
  Read-Tool gelesen werden (zuerst die große Route-Datei), und lange Logs, die in den Chat
  eingefügt werden.
- `git log -p` oder ein Lockfile über Bash zählen kaum: Im Test bekam Claude von beiden nur eine
  kurze Vorschau und den Dateipfad. Das ist ein guter Diskussionspunkt: Das Tool schützt das
  Fenster bereits.
- Der einprägsamste Moment ist der Vorher-nachher-Vergleich rund um `/compact`. Sorgt dafür, dass
  wirklich alle dieselbe Frage vorher und nachher stellen.
- Der Subagent-Schritt gibt einen Vorgeschmack auf die Subagents-Aufgabe. Haltet ihn kurz; der
  Punkt ist, wie wenig im Haupt-Kontext landet.
- Knüpft an „context is king“ an und blickt voraus auf Skills, Hooks, Subagents und MCP: Alle sind
  Hebel des Context Engineering.

## Zeitbedarf

~30 Minuten.
