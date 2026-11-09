## Lernziele

- **Feature:** `anthropics/claude-code-action@v1`, die Claude GitHub App, `CLAUDE_CODE_OAUTH_TOKEN`
  (`claude setup-token`) vs. `ANTHROPIC_API_KEY`, `prompt`, `track_progress`, `claude_args` mit
  `--allowedTools` und `--max-turns`, `/install-github-app` als geführte Alternative.
- **Konzepte:** Claude als Teammitglied im Issue-Tracker; unbeaufsichtigte Läufe brauchen enge
  Tool-Listen; Kosten und Wirkungsradius von CI-Läufen.
- **Takeaways:** mit Analyse beginnen, nicht mit Implementierung; Tools pro Modus einschränken; das,
  was Claude in einem Issue schreibt, wie jedes andere Review prüfen.

## Hinweise zur Durchführung

- Vor der Session einen Demo-Fork vorbereiten, mit installierter App und gesetztem Secret, und ein
  Label `analyse` live ausführen. Teilnehmende, die kein persönliches Token oder keinen API-Key
  nutzen können oder dürfen, folgen dieser Demo. Niemals ein Trainer-Token mit dem Raum teilen.
- Kosten: Jeder Lauf verbraucht den Claude-Plan der Teilnehmenden (OAuth-Token) oder deren API-Key.
  Standard-Runner von GitHub sind für öffentliche Repositories kostenlos, und ein Fork eines
  öffentlichen Repositories ist öffentlich. `timeout-minutes` und `--max-turns` als Begrenzungen
  erwähnen.
- Typische Stolperfallen beim Setup, in dieser Reihenfolge: Workflows im Fork deaktiviert; Issues im
  Fork deaktiviert; App nicht auf dem Fork installiert; Labels fehlen; `gh` zielt auf das
  Original-Repository statt auf den Fork; ein Push, der eine Workflow-Datei ändert, wird abgelehnt,
  bis `gh auth refresh -s workflow` ausgeführt wurde.
- `/install-github-app` funktioniert ebenfalls, nutzt aber das Repository des aktuellen Clones und
  bereitet einen eigenen Workflow-PR vor. Für diese Aufgabe ist der manuelle Weg klarer; den Befehl
  als Alltagsabkürzung erwähnen.
- Gute Diskussion zu Schritt 1: Titel und Text des Issues stammen von der Person, die das Issue
  geöffnet hat, und der Workflow setzt sie in Claudes Prompt ein. Wer kann einen Lauf auslösen, und
  was könnte ein bösartiges Issue verlangen? Die Action läuft standardmäßig nur für Nutzende mit
  Schreibzugriff; darüber sprechen, was einen Lauf wirklich begrenzt: die
  Tool-Liste, die `GITHUB_TOKEN`-Rechte des Workflows und diese Zugriffsprüfung.
- Nicht kommentieren, ob Claudes Analyse des Tickets stimmt. Das deckt die Debugging-Aufgabe ab (und
  das private Trainer-Repo `bookmonkey-legacy-trainer`, `SOLUTIONS.md`). Hier geht es um das Setup
  und die Prüfung des Kommentars.
- Das Label `implement` lässt Claude einen Branch pushen und eine vorausgefüllte Pull-Request-Seite
  verlinken; die Action öffnet den PR standardmäßig nicht selbst. Es ist optional; es dauert länger
  und kostet mehr. In der Demo nutzen, wenn die Zeit reicht.
- Schritt 1 fragt, wo der Workflow mehr erlaubt, als der Prompt verlangt. Antworten im Raum sammeln,
  ohne sie zu bewerten, dann in Schritt 9 eine davon einschränken lassen.
- Windows-Teilnehmende: Die Snippets sind Bash. Git Bash funktioniert unverändert; in PowerShell
  ändert sich nur die Variablenzeile `FORK=` (`$FORK = "..."`).
- Auf dem Aufräumschritt bestehen (Secret, App-Zugriff, optional Fork löschen, API-Key in der
  Console). Ein gelöschtes Secret beendet die Zugangsdaten nicht: Eine Kopie des einjährigen Tokens
  in einer Shell-Historie oder einem Chat ist das eigentliche Risiko dieser Aufgabe.

## Zeitbedarf

ca. 40 Minuten: 20 Fork und Setup (Fork, Actions und Issues, App, Token und Secret, Labels), 10
erster Lauf und Kommentar lesen, 10 Workflow-Änderung, zweiter Lauf und Aufräumen. 10 Minuten
dazurechnen, wenn viele Teilnehmende erst ein Token erstellen müssen.
