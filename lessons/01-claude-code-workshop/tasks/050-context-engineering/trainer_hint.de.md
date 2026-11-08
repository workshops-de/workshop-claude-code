## Lernziele

- **Feature:** `/context`, `/compact` mit Fokus-Anweisungen, `/clear`, `/btw`, Lesen an einen
  Subagent delegieren.
- **Konzepte:** das begrenzte Kontextfenster; Fehlerarten des Kontexts; „Lost in the Middle“;
  warum Legacy-Code das Fenster schnell füllt.
- **Takeaways:** kuratieren, was hineinkommt; Rauschen entfernen; wenn möglich eine Aufgabe pro
  frischer Session.

## Hinweise zur Durchführung

- Haltet es praktisch und zeitlich begrenzt. Das Legacy-Repo macht das Verschmutzen leicht: die
  große Route-Datei, `git log -p` (zehntausende Zeilen) und das Server-Log füllen das Fenster in
  Minuten.
- Claude Code verweigert oder kürzt sehr große Ausgaben eventuell (zum Beispiel speichert es lange
  Tool-Ergebnisse in einer Datei). Das ist selbst ein guter Diskussionspunkt: Das Tool schützt das
  Fenster bereits.
- Der einprägsamste Moment ist der Vorher-nachher-Vergleich rund um `/compact`. Sorgt dafür, dass
  wirklich alle dieselbe Frage vorher und nachher stellen.
- Der Subagent-Schritt gibt einen Vorgeschmack auf die Subagents-Aufgabe. Haltet ihn kurz; der
  Punkt ist, wie wenig im Haupt-Kontext landet.
- Knüpft an „context is king“ an und blickt voraus auf Skills, Hooks, Subagents und MCP: Alle sind
  Hebel des Context Engineering.

## Zeitbedarf

~30 Minuten.
