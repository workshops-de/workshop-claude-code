## Lernziele

- **Feature:** Plan Mode für große Änderungen, Characterisation-Tests als Sicherheitsnetz, kleine
  geprüfte Schritte mit Commits, `/rewind`, optionale Code Intelligence.
- **Konzepte:** Refactoring vs. Neuschreiben; Verhaltenserhalt; Inventar vor der Änderung;
  „Refactoring“ von „Fix“ trennen.
- **Takeaways:** Urteilsintensive Refactorings delegieren; Verhalten festnageln, bevor ihr Code
  verschiebt; mechanische Änderungen in der IDE lassen; der Diff gehört euch.

## Hinweise zur Durchführung

- Das eröffnet „Quality & Automation“. Den Rahmen setzen: Der Rest des Blocks dreht sich darum,
  Qualität systematisch zu machen.
- Die Teilnehmenden frei wählen lassen. Option (a) dreht sich darum, alle Stellen zu finden, die
  dasselbe unterschiedlich machen; Option (b) darum, Code zu verschieben, ohne zu ändern, was er
  tut. Beide sind bewusst verkleinert: (a) auf drei Stellen, die die Gruppe wählt, (b) auf die zwei
  zuerst verschobenen Ressourcen. Beide dauern trotzdem länger, als man erwartet; die Arbeit auf
  45 Minuten begrenzen und laut sagen, dass ein sauberer Teilschritt mit grünen Tests als Erfolg
  gilt.
- `/diff` nach dem ersten Schritt und `/rewind` (oder zweimal `Esc`) einmal live zeigen: Die Agenda
  verspricht beides, und die Teilnehmenden nutzen sie erst, nachdem sie sie einmal gesehen haben.
- Die Liste der betroffenen Stellen nicht herausgeben. Das Inventar ist das Lernen. Die vollständige
  Liste für beide Optionen und die Hinweise, was die Tests zutage fördern sollten, stehen im
  privaten Trainer-Repo (`bookmonkey-legacy-trainer`, `SOLUTIONS.md`).
- Rechnet damit, dass der Agent nebenbei Dinge „verbessert“. Das ist die wichtigste Diskussion: Ein
  Refactoring, das auch das Verhalten ändert, ist kein Refactoring mehr. Die Teilnehmenden bitten,
  solche Funde stattdessen aufzulisten und für die Aufgaben zu Debugging und Code Review
  aufzuheben.
- Manche Teilnehmende finden beim Schreiben der Characterisation-Tests überraschendes Verhalten.
  Gut so. Nur bestätigen, dass Überraschungen es wert sind, aufgeschrieben zu werden, nicht, was
  sie bedeuten.
- Teilnehmende, die an ihrer eigenen Codebasis arbeiten, brauchen einen Test-Befehl, der in unter
  einer Minute läuft; das vor dem Start prüfen.
- Steht in eurer Organisation ein LSP-Plugin zur Verfügung, ist ein Live-Vorher/Nachher (Inventar
  per grep vs. per Code Intelligence) eine starke Demo.

## Zeitbedarf

~60 Minuten: 10 Inventar, 15 Characterisation-Tests, 25 Refactoring in Schritten, 10 Prüfen und
Nachbesprechung. Die verkleinerte Aufgabe sorgt dafür, dass 60 Minuten reichen; ohne sie 90 planen.
Gruppen, die früher fertig sind, nehmen den Bonus (mehr Stellen für (a), mehr Ressourcen für (b)).
