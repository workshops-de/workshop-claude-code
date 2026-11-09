## Lernziele

- **Skills:** Claude Code starten und steuern; Plan Mode als Erkundungsmodus ohne Änderungen;
  Agent-Aktivität lesen; Kontextnutzung überwachen; Berechtigungen verwalten.
- **Konzepte:** die Agent-Kontrollschleife (Reason → Act → Observe); Tools vs. Text; Antworten mit
  Belegen; Kontext als wichtigste Ressource.
- **Takeaways:** erst erkunden, dann ändern; überprüfbare Artefakte verlangen; ihr bleibt
  Eigentümer jeder Änderung, auch der Entscheidung, keine zu machen.

## Hinweise zur Durchführung

- Stellt sicher, dass alle die Installationsaufgabe abgeschlossen haben. Das Klonen braucht kein
  `npm install`; die App zu starten ist hier optional und kostet bei langsamen Netzen Zeit.
- Beginnt mit einer 2-minütigen Live-Demo: `claude --permission-mode plan`, eine Frage, dann
  `Ctrl+O`, um die Tool-Aufrufe hinter der Antwort zu zeigen. So wird die Schleife für den Rest
  der Aufgabe sichtbar.
- Teilnehmende geben manchmal aus Gewohnheit den ersten Plan frei. Das ist der Lernmoment: Plan
  Mode schützt nur, bis man Ja sagt. Wer eine Datei geändert hat, schaut sich `git diff` und
  `git restore .` an.
- Verlangt Belege. Gute Antworten nennen Dateien und Zeilen und überstehen ein „zeig mir“. Schwache
  Antworten wiederholen Dokumentation, ohne sie zu prüfen. Ermutigt dazu, mindestens eine
  zitierte Behauptung gegen den Code zu prüfen, ohne zu verraten, was sie finden werden.
- So sehen gute Ergebnisse allgemein aus: ein Überblick, der beide Workspaces abdeckt, wie jeder
  Teil gestartet wird und wo die Daten liegen; eine Mermaid-Karte, die jemand gegen mindestens
  einen echten Import geprüft hat; ein Request-Flow, der bei einem echten SQL-Statement ankommt;
  Risiken nach Art gruppiert (Sicherheit, Daten, Wartbarkeit, Wissensverlust), jeweils mit
  konkretem Verweis; eine Historie, die Personen, Jahre und Bereiche verbindet.
- Bestätigt oder benennt im Plenum keine konkreten Defekte. Mehrere der Risiken begegnen den
  Teilnehmenden in den Aufgaben zu Refactoring, Debugging und Code-Review wieder. Wer eines
  entdeckt, schreibt es als „Kandidat“ an das Board und geht weiter. Die vollständige Liste liegt
  im privaten Trainer-Repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`), nicht in diesem
  Kurs-Repo.
- Häufiges Problem: Die Antworten werden nach vielen Fragen vage. Zeigt mit `/context`, was die
  Erkundung gekostet hat. Das ist das erste Live-Beispiel für „context is king“ und die Brücke zur
  Kontext-Aufgabe.

## Zeitbedarf

~45 Minuten: 5 klonen und starten, 10 Überblick und Karte, 10 Request-Flow, 10 Risiken und
Historie, 10 Nachbesprechung. Streicht bei einer langsamen Gruppe zuerst den Historie-Schritt.

## Diskussionspunkte

- Zwei Teilnehmende vergleichen ihre fünf Risiken. Wo sie sich unterscheiden: Welcher Beleg war
  stärker?
- Wo in der Schleife hat der Agent um Erlaubnis gefragt, und hätten sie sie in einer echten
  Übernahme erteilt?
