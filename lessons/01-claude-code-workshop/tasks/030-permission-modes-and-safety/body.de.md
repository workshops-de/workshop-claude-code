## Überblick

Versteht und steuert, **wie viel Autonomie** ihr Claude Code gebt, damit ihr die Kontrolle an das
Risiko anpassen könnt. Ihr lernt die Permission Modes (Manual (`default`), `acceptEdits`, `plan`,
`auto`, `dontAsk`, `bypassPermissions`) kennen, in welchem eine Session startet, wie ihr zwischen
ihnen wechselt und welche Schutzmechanismen euch absichern, darunter der Sicherheits-Klassifikator
des **Auto Mode** im Hintergrund und die Idee von Human-in-the-Loop-Grenzen. Das bildet die
Grundlage jeder späteren Aufgabe: Je lockerer der Modus, desto wichtiger eure Review-Disziplin.

## Hintergrund

Wenn Claude eine Datei ändern, einen Befehl ausführen oder eine Netzwerkanfrage stellen will,
entscheidet ein Permission Mode, ob es vorher fragt. **Manual** (Konfigurationswert `default`) und
`plan` lesen nur ohne Nachfrage; `acceptEdits` schreibt Dateien (und gängige
Dateisystem-Befehle) ohne Nachfrage; `auto` lässt Claude handeln, während ein separates
Klassifikator-Modell jede Aktion vorher prüft; `dontAsk` erlaubt nur vorab freigegebene Tools
(ideal für abgeschottete CI); `bypassPermissions` überspringt alle Prüfungen und ist nur in einem
isolierten Container oder einer VM sicher.

Seit Claude Code v2.1.283 ist der **Auto Mode der eingebaute Startmodus** für interaktive
Terminal- und VS-Code-Sessions. Ein `--permission-mode`-Flag oder `permissions.defaultMode` in
einer Settings-Datei hat Vorrang vor diesem eingebauten Standard, und wenn der Auto Mode für eure
Session nicht verfügbar ist, startet sie stattdessen in Manual.

## Schritte

1. **Startet eine Session und lest die Statuszeile**, bevor ihr etwas tippt (`claude` in eurem
   `bookmonkey-legacy`-Clone). Welchen Modus zeigt sie, und warum? Prüft `claude --version` und
   eure `~/.claude/settings.json` (`permissions.defaultMode`), um es zu erklären. Drückt dann
   mehrmals `Shift+Tab` und beobachtet die Statuszeile: Von `auto` wechselt der erste Druck zu
   Manual (`⏸ manual mode on`), danach läuft der Zyklus Manual → `acceptEdits` → `plan` → zurück
   zu `auto`. Notiert, was jeder Modus ohne Nachfrage erlaubt.
2. Macht in `acceptEdits` eine kleine Änderung und bestätigt, dass sie ohne Nachfrage
   übernommen wurde; prüft die Änderung danach mit `git diff`. Macht sie mit `git restore .`
   rückgängig, damit der Clone für die nächsten Aufgaben sauber bleibt.
3. Wechselt zurück in den **Auto Mode** und gebt ihm eine klar umrissene Aufgabe. Beobachtet den
   Klassifikator: Führt `claude auto-mode defaults` in einem zweiten Terminal aus, um die
   Standardregeln zu lesen, und benennt zwei Aktionen, die er standardmäßig blockiert, und zwei,
   die er erlaubt. Wechselt dann zu Manual (`default`) und gebt dieselbe Aufgabe: Zählt, wie viele
   Nachfragen ihr jetzt bekommt.
4. Formuliert im Gespräch eine **Grenze** (zum Beispiel „führe keine Netzwerk-Befehle aus, bis ich
   es sage“) und prüft, dass Claude sie auch dort einhält, wo die Standardregeln die Aktion
   erlauben würden.
5. Entscheidet für drei Szenarien (ein unbekanntes Repo erkunden, an Code iterieren, den ihr gerade
   reviewt, ein abgeschotteter CI-Job), welcher Modus passt und warum.
6. Lest nach, wie ihr autonom **sicher** arbeitet (Sandbox oder Dev-Container), und haltet fest,
   warum deterministische Isolation stärker ist als Schutzmaßnahmen auf Prompt-Basis.

## Erfolgskriterien

- [ ] Ihr könnt sagen, in welchem Modus eure Session gestartet ist und warum
- [ ] Ihr könnt jeden Permission Mode benennen und sagen, was er ohne Nachfrage erlaubt
- [ ] Ihr habt bestätigt, dass mindestens eine Grenze im Gespräch eingehalten wurde
- [ ] Ihr könnt den Unterschied zwischen einer formulierten Grenze und einer Deny-Regel erklären
- [ ] Ihr habt für die drei vorgegebenen Szenarien jeweils einen passenden Modus gewählt

## Referenzen

- Claude Code: Choose a permission mode: https://code.claude.com/docs/en/permission-modes
- Claude Code: Configure auto mode: https://code.claude.com/docs/en/auto-mode-config
- Claude Code: Permissions (allow/ask/deny rules): https://code.claude.com/docs/en/permissions
- Claude Code: Sandboxing: https://code.claude.com/docs/en/sandboxing
