## Lernziele

- **Feature:** `/goal` (Bedingung, Evaluator, Status, Clear), Auto Mode vs. kuratiertes
  `--allowedTools`, Isolation mit `claude --worktree`.
- **Konzepte:** teilautonome Workflows; zielgesteuerte Ausführung; messbare Endzustände;
  ausfallsichere Autonomie mit menschlichem Checkpoint.
- **Übungsfeld:** das eigene BookMonkey-NestJS-Backend gegen die Contract-Test-Suite fertigstellen
  und anschließend das Frontend umstellen.
- **Takeaways:** Autonomie ist begrenzte Delegation; isolieren, begrenzen und das Ergebnis prüfen.

## Hinweise zur Durchführung

- Das eröffnet den letzten Vormittag – rahmt es als „alles, was ihr gelernt habt, mit weniger
  Handführung angewendet“ und als Auflösung des Handlungsbogens, der in den Aufgaben 070 und 200
  begonnen wurde.
- Ist der Auto Mode auf den Accounts der Teilnehmenden nicht verfügbar, funktioniert ein
  kuratiertes `--allowedTools`-Set als Ersatz – lasst unterschiedlichen Zugang die Übung nicht
  blockieren.
- Schritt 1 (die Suite von Hand erweitern) ist Absicht: Der Mensch besitzt die Definition von
  „fertig“, der Agent den Weg dorthin. Lasst Schritt 1 nicht an den Goal-Lauf abgeben.
- Läufe können dauern – lasst die Teilnehmenden das Ziel vor einer Pause starten oder kürzt den
  Umfang auf die Query-Oberfläche von `GET /books` plus `DELETE`.
- Zahlen aus dem Bericht des Probelaufs (eure können abweichen): Der verschachtelte Goal-Lauf
  brauchte etwa 6,5 Minuten, 41 agentische Turns und rund 0,83 USD, um 46 Contract-Tests grün zu
  bekommen; die ganze Session etwa 17 Minuten, 51 Turns und 1,59 USD. Das `num_turns` im `-p`-JSON zählt agentische
  Turns, nicht die Goal-Turns des Evaluators, ist also nicht dieselbe Einheit wie „stop after 30
  turns“.
- Der Review-Checkpoint hat sich im Probelauf bewährt: Die Suite war grün, doch der Demo-User konnte
  sich am eigenen Backend nicht anmelden (das Seed hat einen bcrypt-Hash, das Backend prüfte
  scrypt), und `/dev/reset` antwortete `{reset:true}` statt `{ok:true}`. Lücken in der Spezifikation
  werden grün gemacht, nicht entdeckt; deshalb prüft ein Mensch den Diff.
- Eigenheiten der Referenz-API, über die man beim Erweitern der Suite stolpern kann: `_limit=abc`
  liefert `[]` mit `200`; `q` ohne Paging sendet keinen `X-Total-Count`; `_page` ohne `_limit`
  nutzt eine Seitengröße von 10; `PUT` ersetzt das ganze Buch; `DELETE` liefert `{}`. Entscheidet
  pro Eigenheit, ob der Vertrag sie festschreibt.
- Der ESLint-Lauf im Root aus dem Gate prüft auch `contract-tests/`, sofern die TDD-Aufgabe ihn
  nicht eingegrenzt hat; neue Testdateien scheitern dann an `no-explicit-any`.
- Die Umstellung des Frontends ist die emotionale Belohnung; bittet eine Person, sie mit der
  Browser-Journey aus der MCP-Aufgabe zu demonstrieren.

## Zeitbedarf

~45 Minuten (plus Laufzeit; wenn möglich vor einer Pause starten).
