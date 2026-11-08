## Lernziele

- **Feature:** `/code-review` mit Branch-Bereich und Effort-Stufe, `/security-review`, ein eigener
  Security-Subagent ohne Edit-Tools, Triage von Agenten-Findings.
- **Konzepte:** Review als Qualitätsuntergrenze; Korrektheits- vs. Security-Review; falsch
  positive Findings; Findings reproduzieren; Verantwortung.
- **Takeaways:** Jedes Review ist besser als keins; zwei unabhängige Reviewer finden mehr als einer;
  für das, was ihr freigebt, seid ihr verantwortlich.

## Hinweise zur Durchführung

- Die Teilnehmenden reviewen, sie schreiben nicht. Das ausdrücklich machen: Der Branch wurde von
  jemand anderem geschrieben, in Eile, und sieht aus wie ein normaler Feature-PR.
- Niemandem sagen, wonach er suchen soll oder wie viele Probleme es gibt. Die Liste dessen, was ein
  vollständiges Review finden sollte, mit Schweregraden und Reproduktionen, steht im privaten
  Trainer-Repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`). Diese Liste nur nutzen, um Ergebnisse in der
  Nachbesprechung zu prüfen, und nie in dieses öffentliche Repo kopieren.
- Gute Nachbesprechung: Findings aus dem Raum an der Tafel sammeln und markieren, welcher Reviewer
  jedes gefunden hat (`/code-review`, Security-Subagent, Mensch). Ein falsch positives Finding im
  Detail besprechen. Dann mit der Trainer-Liste vergleichen und darüber sprechen, was niemand
  gefunden hat und warum.
- `/code-review` läuft im Hintergrund und braucht ein paar Minuten. Die Teilnehmenden sollten
  währenddessen den Diff selbst lesen, damit sie eine eigene Liste haben, bevor sie die des Agenten
  sehen.
- `/security-review` vergleicht mit dem Default-Branch von `origin`; es braucht den
  `origin`-Remote des Clones, den `git clone` setzt. Wenn es mit einem `ambiguous argument`-Fehler
  scheitert, `git fetch origin` und `git remote set-head origin --auto` ausführen.
- Vor dem Wechsel haben die Teilnehmenden noch Änderungen aus der Debugging-Aufgabe. Sicherstellen,
  dass sie diese zuerst committen oder stashen. Der Review-Branch wird aus
  `origin/feature/admin-export-v2` erstellt und `main` wird hineingemergt, damit ihre `CLAUDE.md`
  geladen wird; `main...review/admin-export-v2` zeigt weiterhin nur die Änderungen des PR.
  `/security-review` vergleicht mit dem Default-Branch von `origin`, sieht also auch die eigenen
  Commits der Teilnehmenden auf `main`; darauf hinweisen, falls sie sich wundern.
- Der optionale Security-Durchgang über `main` (Schritt 9) ist für schnelle Gruppen. Findings daraus
  im Raum weder bestätigen noch bewerten; das Trainer-Repo enthält, womit man vergleichen kann.
- Eine neue Subagent-Datei braucht eventuell einen Neustart von Claude Code, um geladen zu werden,
  wie in der Subagents-Aufgabe.
- Das schließt zusammen mit der GitHub-Actions-Aufgabe „Quality & Automation“ ab. Ein natürlicher
  Punkt für eine breitere Retrospektive, bevor die Aufgabe zu autonomen Workflows das eigene Backend
  fertigstellt.

## Zeitbedarf

ca. 45 Minuten: 5 verstehen, 10 Reviews (parallel zum eigenen Lesen), 15 Triage, 10 Review
schreiben und eines beheben, 5 reflektieren.
