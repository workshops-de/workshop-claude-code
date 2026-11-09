## Lernziele

- **Skills:** `claude -p` ausführen; Daten per Pipe übergeben; JSON-Ausgabe erzeugen und auslesen;
  Tools vorab freigeben; Claude in ein Projekt-Skript einbinden.
- **Konzepte:** nicht interaktive Ausführung; reproduzierbare Läufe mit `--bare`; strukturierte
  Ausgaben; Scripting und CI-Integration.
- **Takeaways:** Claude Code lässt sich wie jede CLI kombinieren; Tools einschränken und Bare Mode
  nutzen für planbare Automatisierung.

## Hinweise zur Durchführung

- Das Skript verpackt ein Review des `git diff` (Schritt 4). Wenn Zeit bleibt, kann der
  Quality-Gate-Befehl der vorigen Aufgabe als Zweites verpackt werden.
- Sind API-Kosten ein Thema im Raum, auf `total_cost_usd` in der JSON-Ausgabe hinweisen, um die
  Ausgaben pro Aufruf zu verfolgen.

## Zeitbedarf

~30 Minuten.
