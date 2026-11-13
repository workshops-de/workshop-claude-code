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
- Schritt 6 (pre-push Hook) ersetzt das frühere offene "Baut ein eigenes Skript". Er schließt den
  Bogen: Pipe, Schema, Exit-Code, Hook. Getestet am 2026-11-13 (Claude Code 2.1.323, Sonnet) an einer
  Wegwerf-Kopie mit lokalem Bare-Remote: Der Push des PR-Branches stoppte, ein unveränderter Branch
  ging durch, `--no-verify` übersprang den Hook. Claude wählte `.githooks` plus `core.hooksPath`.
- Klar sagen: Git-Hook ist kein Claude-Code-Hook (Aufgabe 120). Warum `pre-push` und nicht
  `pre-commit`: Die Prüfung dauert. Warum es `--no-verify` gibt: Das KI-Urteil schwankt von Lauf zu
  Lauf. Brücke zu 215: lokal als Hook, fürs Team als GitHub Action.
- Stolperstein: In unserem Lauf hat Claude `review.sh` bei Fehlern (etwa kein Netz) mit 2 enden lassen und bei leerem Diff mit 0 abgekürzt. Der Prompt in Schritt 4 verlangt beides nicht, andere Läufe können abweichen: Ein Fehler mit Exit 0 lässt den Push ungeprüft durch, einer mit Exit 2 blockiert ihn. Verhält sich der Clean-Push seltsam, das Skript gemeinsam ansehen.
- Stolperstein: Zum Testen nicht auf das echte Remote pushen; der Setup-Block legt ein Test-Remote an, der Prompt nennt es. Der Push des Clean-Branches ist optional (Zeit).
- Wer früher fertig ist, kann weiterhin eine eigene Alltagsprüfung als Skript verpacken.
- Sind API-Kosten ein Thema im Raum, auf `total_cost_usd` in der JSON-Ausgabe hinweisen, um die
  Ausgaben pro Aufruf zu verfolgen.

## Zeitbedarf

~30 Minuten.
