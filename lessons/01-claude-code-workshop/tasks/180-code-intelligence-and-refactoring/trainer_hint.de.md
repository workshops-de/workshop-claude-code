## Lernziele

- **Feature:** Plan Mode für große Änderungen, Characterisation-Tests als Sicherheitsnetz, ein
  Stop-Hook, der das Netz automatisch auslöst, kleine geprüfte Schritte mit Commits, `/rewind`,
  optional Sandbox und Code Intelligence.
- **Konzepte:** Refactoring vs. Neuschreiben; Verhaltenserhalt; Inventar vor der Änderung;
  „Refactoring“ von „Fix“ trennen; ein Netz erst prüfen, dann vertrauen; Bitte im Prompt vs.
  Hook.
- **Takeaways:** Urteilsintensive Refactorings delegieren; Verhalten festnageln, bevor ihr Code
  verschiebt; „Das Netz kennt kein richtig oder falsch, nur gleich oder anders“; was immer
  passieren muss, gehört in einen Hook; der Diff gehört euch.

## Hinweise zur Durchführung

- Das eröffnet „Quality & Automation“. Den Rahmen setzen: Der Rest des Blocks dreht sich darum,
  Qualität systematisch zu machen.
- Die Codebasis hat bekannte Fehler, und die Characterisation-Tests sind trotzdem grün. Das ist
  der Kernsatz für Schritt 3: Das Netz meldet Änderungen, keine Fehler. Gefundene Fehler kommen auf
  die Liste für die Aufgaben zu Debugging und Code Review.
- Schritt 4 ist der Aha-Moment: Claude meldet „fertig“, und erst das eigene `npm test` zeigt den
  Bruch. Bleibt bei jemandem alles grün, ist das kein Fehler der Aufgabe, sondern eine Lücke im
  Netz. Genau diese Erkenntnis ist wertvoll.
- Schritt 5 knüpft an Aufgabe 120 an: Dort hat Claude Hooks gebaut, hier bekommen die
  Teilnehmenden einen fertigen. Grund: Als wir Claude den Stop-Hook selbst bauen ließen, legte es
  eine Debug-Datei in `/tmp` an und baute keinen Schutz gegen Endlosschleifen ein. Der vorgegebene
  Hook lässt den zweiten Stopp durch (`stop_hook_active`), damit Claude in Schritt 7 bei Rot noch
  fragen kann.
- `.claude/settings.local.json` ist im Repo nicht in `.gitignore`. Achtet darauf, dass niemand die
  Datei committet, und dass in Schritt 8 alle den Hook wieder entfernen. Sonst läuft `npm test` in
  den späteren Aufgaben bei jedem Ende, auch in der Debugging-Aufgabe.
- Die Aufgabe nimmt mit `git restore` zurück. Optional `/rewind` (oder zweimal `Esc`) in Schritt 4
  einmal live zeigen, als Alternative für Änderungen über Claudes Datei-Tools.
- Die Liste der auffälligen Stellen nicht herausgeben. Das Inventar ist das Lernen. Die
  vollständige Liste und die Hinweise, was die Tests zutage fördern sollten, stehen im privaten
  Trainer-Repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- Rechnet damit, dass der Agent nebenbei Dinge „verbessert“. Das ist die wichtigste Diskussion: Ein
  Refactoring, das auch das Verhalten ändert, ist kein Refactoring mehr.
- Teilnehmende, die an ihrer eigenen Codebasis arbeiten, brauchen einen Test-Befehl, der in unter
  einer Minute läuft; das vor dem Start prüfen. Der Stop-Hook führt ihn bei jedem Ende aus.
- Der Bonus mit der Sandbox zeigt zwei Dinge: Sie blockiert auch Harmloses (einen lokalen Port),
  und Hooks laufen außerhalb von ihr. Die Frage aus Punkt 3 eignet sich für die
  Nachbesprechung.
- Steht in eurer Organisation ein LSP-Plugin zur Verfügung, ist ein Live-Vorher/Nachher (Inventar
  per grep vs. per Code Intelligence) eine starke Demo.

## Getestet

Am 12. Nov mit Claude Code 2.1.319 und Sonnet über `claude -p` in einer Kopie von
`bookmonkey-legacy` unter macOS, Node 24.11, ohne persönliche Einstellungen (`--setting-sources project,local`):

- Schritt 4: Nach der Änderung von 404 auf 410 wurde genau der Characterisation-Test für das
  unbekannte Buch rot.
- Schritt 5: Claude meldete erst „Erledigt“, der Stop-Hook blockierte, Claude nannte den roten Test
  mit Datei und Zeile und hörte beim zweiten Versuch auf.
- Bonus: Sandbox an ergibt `listen EPERM`, mit `allowLocalBinding` sind alle Tests grün. Der
  Stop-Hook blieb in der Sandbox grün.

Desktop-App (12. Nov, Sonnet, Kopie des Repos): Der Stop-Hook aus `.claude/settings.local.json`
griff und blockierte bei Rot. Die Sandbox war aktiv (Schreiben im Home-Ordner scheiterte), und mit
`allowLocalBinding` aus der Datei liefen alle Tests grün. Die App nutzt die Standard-Node-Version
der Shell (bei nvm: `nvm alias default`), nicht die des Terminals. War das Node 22, scheiterten
Tests und Hook mit einem `SyntaxError`. Lasst die Gruppe vor Schritt 3 in einer Session `node -v`
prüfen. Ein neuer, unbekannter Ordner mit Hook in `.claude/settings.local.json` löste in der App
die Abfrage „Trust this workspace?“ aus. Im eigenen Clone ist der Ordner schon vertraut.

`/rewind` (Desktop-App, Testordner): „Restore code“ holte Änderungen per Edit und Write zurück, auch an
einer schon committeten Datei (danach eine uncommittete Änderung). Änderungen per Bash (`sed`, `echo`,
`rm`) und der Commit blieben. Für Schritt 4 funktioniert es also, weil Claude dort mit Edit ändert.

## Zeitbedarf

~70 Minuten: 10 Inventar, 15 Characterisation-Tests, 15 Netz prüfen und Hook, 25 Plan und
Refactoring, 5 Nachbesprechung. Wird es knapp, sagt laut, dass ein sauberer Teilschritt mit grünen
Tests als Erfolg gilt. Gruppen, die früher fertig sind, nehmen den Bonus vor Schritt 8.
