## Lernziele

- **Feature:** belegbasiertes Debugging mit Claude: Reproduktionen, konkurrierende Hypothesen,
  Git-Historie als Beleg (optional), Regressionstests; optionaler MCP-Zugriff auf Daten.
- **Konzepte:** Ursache vs. Symptom; „seit einer Weile“-Fehler, die Git-Archäologie brauchen (optional).
- **Takeaways:** Die Debugging-Qualität folgt der Qualität der Belege; behebt die Ursache einmal,
  dort wo alle Pfade zusammenlaufen, und beweist es mit einem Test.

## Hinweise zur Durchführung

- Das Ticket laut vorlesen und sonst nichts geben. Das Ticket ist bewusst in Nutzersprache
  geschrieben. Der Versuchung widerstehen, es zu erklären.
- Der Fehler ist echt und nach einem frischen `npm run db:reset` reproduzierbar. Kann jemand den
  ersten Satz nicht reproduzieren, die Datenbank zuerst zurücksetzen lassen.
- Auf den klassischen Fehler achten: Claude patcht die Seite oder den einen Endpoint, der erste
  Satz des Tickets verschwindet, und der Teilnehmende hört auf. Fragen: „Und der zweite Satz?“
- Gute Ergebnisse, allgemein gesagt: eine Reproduktion als fehlschlagender Request oder Test; eine
  Ursache, die beide Sätze erklärt; optional der Commit, der sie eingeführt hat, samt Absicht des Autors; eine
  Liste aller betroffenen Pfade; ein Fix an einer gemeinsamen Stelle plus ein Regressionstest.
- Die Ursache, der Commit, die betroffenen Pfade und ein Referenz-Fix stehen im privaten
  Trainer-Repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`). Diese Liste nie vor der Nachbesprechung auf
  einem geteilten Bildschirm zeigen und nie in dieses öffentliche Kurs-Repo schreiben.
- Teilnehmende, die im MCP-Bonus den `legacy-ops`-MCP-Server gebaut haben, dürfen ihn nutzen. Er ist
  optional.

## Zeitbedarf

~30 Minuten: 5 Replizieren, 10 Hypothesen prüfen, 15 Ursache, Fix und Test. Git-Historie nur als
Option in „Mehr dazu“.
Nachbesprechung weitere 10 Minuten.
