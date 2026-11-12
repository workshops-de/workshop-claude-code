## Lernziele

- **Skills:** den Startmodus aus der Statuszeile lesen; Permission Modes auswählen und wechseln;
  Standardwerte setzen; Grenzen formulieren; die Auto-Mode-Standardregeln lesen; Permission-Regeln
  in `/permissions` lesen und schreiben.
- **Konzepte:** Abwägung zwischen Kontrolle und Flow; Klassifikator-basierte Schutzmechanismen;
  geschützte Pfade; Human-in-the-Loop; Sandboxing für autonome Läufe.
- **Takeaways:** den Modus am Risiko ausrichten; lockerere Modi erhöhen den Einsatz beim Review; für
  harte Garantien Deny-Regeln und Sandboxes nutzen, nicht allein Prompts.

## Hinweise zur Durchführung

- Eröffnet mit der Frage aus Schritt 1: **Welchen Modus zeigt die Statuszeile nach dem Start, und
  warum?** Mit Claude Code v2.1.283 oder neuer sehen die meisten `auto mode on`, weil Auto der
  eingebaute Startmodus für interaktive Terminal- und VS-Code-Sessions ist. Andere sehen
  `manual mode on`: eine ältere Version, ein `permissions.defaultMode` in ihren Settings, eine
  Organisation, die den Auto Mode abgeschaltet hat, oder ein Modell bzw. Tarif ohne Auto Mode. Lasst
  sie den Grund selbst finden; die Rangfolge (Flag, dann Settings, dann eingebauter Standard) ist
  der Kern.
- Der Modus, der vor den meisten Aktionen fragt, heißt in CLI, VS Code, JetBrains und der
  Desktop-App **Manual**; sein Konfigurationswert ist `default` (die CLI akzeptiert auch `manual`).
  Nennt einmal beide Namen, damit die Teilnehmenden `default` in Settings-Dateien und Hooks
  wiedererkennen.
- Shift+Tab-Zyklus ab auto: Manual → `acceptEdits` → `plan` → `auto`. `bypassPermissions` taucht nur
  auf, wenn die Session damit gestartet wurde; `dontAsk` erscheint nie im Zyklus.
- Ist der Auto Mode für jemanden nicht verfügbar, geht gemeinsam die Doku und
  `claude auto-mode defaults` durch, statt den Klassifikator live zu erleben.
- Spätere Aufgaben in `bookmonkey-legacy` verlangen den Start in Manual oder Plan Mode, damit das
  Repository sauber bleibt. Erwähnt das hier, denn ein Auto-Mode-Standard würde Claude bei
  schreibgeschützten Übungen sonst Dateien ändern lassen.
- Das passt direkt zum Motto „You push it, you own it“, das sich durch den ganzen Workshop zieht:
  benennt diesen Zusammenhang ausdrücklich.
- Falls ihr den privaten Demo-Hub des Trainers habt, zeigt vor der Übung dessen Seite `/permissions`
  (4 Minuten: „Wer gewinnt?“, „Was eine Deny-Regel nicht abdeckt“, Live-Demo). Lasst die Gruppe Schritt 5
  erst vorhersagen: Deny schlägt Allow, in jeder Reihenfolge und in jeder Datei.
- Nimmt Claude nach einem geblockten `curl` von selbst einen Umweg (ein Skript, WebFetch), haltet es
  nicht auf. Genau das ist die Lehre: Eine Bash-Regel prüft nur den Befehlstext, sie sperrt nichts
  ab. Das leistet eine Sandbox, wie Schritt 7 zeigt.
- Schritt 7 funktioniert auch als 5-Minuten-Demo des Trainers (Hub: Permissions, Karte „So bleibt
  Claude im Projektordner“, Aufklapper „Demo“; der Ablauf von Tag 4 verlinkt ihn). Lasst die Gruppe den zweiten Lauf erst vorhersagen.
  Getestet am 12. Nov mit Claude Code 2.1.319 und Haiku 5.5 über `claude -p`: Ohne Sandbox las und
  schrieb der Befehl im Home-Ordner; mit nur `sandbox.enabled` konnte er lesen, aber nicht schreiben;
  mit zusätzlich `blockReadsOutsideWorkingDirectories` scheiterte auch das Lesen. Nicht getestet in
  einer interaktiven Auto-Mode-Session: Blockt der Klassifikator den ersten Lauf, wechselt zu Manual
  und bestätigt die Nachfrage.
- Prüft, dass alle am Ende von Schritt 5 beide `curl`-Regeln gelöscht haben; eine übrig gebliebene
  Deny-Regel stört spätere Aufgaben.
- Ein guter Live-Moment: Testet bewusst, ob eine formulierte Grenze ein `/compact` überlebt. In
  kurzen Test-Sessions hielt sie (6 von 6), aber nichts erzwingt sie. Eine Deny-Regel schon.

## Zeitbedarf

~45 Minuten, weniger, wenn die Gruppe die Modi schon in der Installationsaufgabe durchgeschaltet
hat.
