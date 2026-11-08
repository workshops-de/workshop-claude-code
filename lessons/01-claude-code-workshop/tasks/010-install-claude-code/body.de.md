## Überblick

Bevor ihr Code anfasst, installiert ihr Claude Code als Terminal-Tool auf eurem eigenen Rechner und
prüft, dass es von Anfang bis Ende funktioniert: Es läuft, ihr seid angemeldet und es antwortet.
Das ist eine reine Setup-Aufgabe – kein Erkunden, kein Code, nur eine funktionierende
Installation, auf die ihr euch für den Rest des Workshops verlassen könnt.

## Voraussetzungen

- Node.js 26 (aktuelles LTS) installiert (`node -v`). Die BookMonkey-API, die ihr in der
  Plan-Mode-Aufgabe startet, verlangt `node >=26`; die npm-Installation von Claude Code selbst
  braucht Node.js 22 oder neuer.
- Ein Terminal, mit dem ihr gut zurechtkommt
- Ein Claude-Account mit Zugang zu Claude Code (Pro, Max, Team, Enterprise oder Console; der
  kostenlose Claude.ai-Plan enthält Claude Code nicht)

## Schritte

1. Installiert Claude Code auf einem der beiden Wege:

   ```bash
   # macOS / Linux / WSL: natives Installationsskript (empfohlen)
   curl -fsSL https://claude.ai/install.sh | bash

   # Windows PowerShell: natives Installationsskript
   irm https://claude.ai/install.ps1 | iex

   # Windows, Alternative: WinGet (ohne automatische Updates)
   winget install Anthropic.ClaudeCode

   # oder per npm (jedes OS mit Node.js 22+)
   npm install -g @anthropic-ai/claude-code
   ```

   Unter nativem Windows installiert ihr zusätzlich [Git for Windows](https://git-scm.com/downloads/win),
   damit Claude Code sein Bash-Tool nutzen kann.

2. Prüft, dass es in eurem `PATH` liegt, und schaut euch die Version an:

   ```bash
   claude --version
   ```

   Führt danach die Diagnose aus. Sie ändert nichts und prüft, ohne eine Session zu starten, ob die
   Installation und eure Settings-Dateien in Ordnung sind:

   ```bash
   claude doctor
   ```

3. Wechselt in ein beliebiges Projektverzeichnis und startet eine Session:

   ```bash
   cd your-project
   claude
   ```

4. **Meldet euch an**, wenn ihr dazu aufgefordert werdet (über Claude.ai oder Claude Console), und
   wartet, bis der Prompt interaktiv wird. Achtet auf den Modus in der Statuszeile unter dem
   Prompt (zum Beispiel `auto mode on` oder `manual mode on`); die Aufgabe zu den Permission Modes
   erklärt ihn.

5. **Testet, ob es funktioniert**: Stellt eine einfache Frage (zum Beispiel „welche Dateien liegen
   in diesem Verzeichnis?“) und prüft, dass ihr eine sinnvolle Antwort bekommt.

6. Beendet die Session sauber (`/exit` oder `Ctrl+C`) und startet sie erneut, um zu prüfen, dass
   auch der zweite Start reibungslos läuft – keine erneute Anmeldung, keine Fehler.

## Erfolgskriterien

- [ ] `claude --version` läuft ohne Fehler
- [ ] `claude doctor` meldet keine Installationsfehler
- [ ] Ihr seid bei einem Claude-Account angemeldet
- [ ] `claude` startet in einem Projektverzeichnis eine interaktive Session
- [ ] Der Agent hat eine einfache Frage zum aktuellen Verzeichnis beantwortet
- [ ] Ein Neustart der Session erfordert keine erneute Anmeldung

## Referenzen

- Claude Code: Overview: https://code.claude.com/docs/en/overview
- Claude Code: Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code: Advanced setup: https://code.claude.com/docs/en/setup
- Claude Code: CLI reference: https://code.claude.com/docs/en/cli-reference
