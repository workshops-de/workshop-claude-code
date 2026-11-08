## Lernziele

- **Feature:** `/init`, `CLAUDE.md` kuratieren, Unterverzeichnis-Memory-Dateien und wann sie
  geladen werden, `CLAUDE.local.md`, `/memory`.
- **Konzepte:** Langzeit- vs. Kurzzeitgedächtnis; Signal statt Menge; Memory als Kontextkosten;
  Dokumentationsdrift.
- **Takeaways:** Memory wird kuratiert und am Code verifiziert; haltet es schlank; beweist, dass
  es das Verhalten des Agenten ändert.

## Hinweise zur Durchführung

- Die README von `bookmonkey-legacy` wurde zuletzt vor Jahren gepflegt. Manches ist aktuell,
  manches nicht. Sagt den Teilnehmenden nicht, was. Der Punkt ist, dass sie es durch Prüfen
  herausfinden und dass `/init` veraltete Aussagen in die Memory-Datei kopieren kann, wenn
  niemand prüft. Die Liste der veralteten Aussagen liegt im privaten Trainer-Repo
  (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- Eine starke Frage für die Nachbesprechung: „Welche Zeile eurer `CLAUDE.md` hätte die nächste
  Session am meisten Zeit gekostet, wenn sie falsch wäre?“
- Teilnehmende behalten oft zu viel von der `/init`-Ausgabe. Drängt sie, radikal zu kürzen; der
  „neues Teammitglied“-Test ist ein guter Impuls, den man laut wiederholt.
- Den Schritt mit der frischen Session überspringen Leute unter Zeitdruck gern. Lasst das nicht zu;
  er ist der einzige Beweis, dass die Datei funktioniert.
- `npm install` und `npm run db:reset` dauern 1 bis 2 Minuten. Empfehlt, sie in einem zweiten
  Terminal zu starten, während `/init` läuft.
- Die committeten Memory-Dateien werden in den Aufgaben zu Refactoring, Debugging und Code-Review
  im selben Repository wiederverwendet.

## Zeitbedarf

~30 Minuten für eine erfahrene Gruppe, 40, wenn viele Installationen langsam sind.
