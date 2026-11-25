## Überblick

Bevor ihr Code anfasst, installiert ihr Claude Code als Terminal-Tool auf eurem eigenen Rechner und
prüft, dass es von Anfang bis Ende funktioniert: Es läuft, ihr seid angemeldet und es antwortet.
Das ist eine reine Setup-Aufgabe – kein Erkunden, kein Code, nur eine funktionierende
Installation, auf die ihr euch für den Rest des Workshops verlassen könnt.

## Voraussetzungen

- Node.js 26 (aktuelles LTS) installiert (`node -v`). Die BookMonkey-API, die ihr in der
  Plan-Mode-Aufgabe startet, verlangt `node >=26`; die npm-Installation von Claude Code selbst
  braucht Node.js 22 oder neuer.
- Ein Terminal, mit dem ihr gut zurechtkommt (mit der Desktop-App: das Terminal der App)
- Ein Claude-Account mit Zugang zu Claude Code (Pro, Max, Team, Enterprise oder Console; der
  kostenlose Claude.ai-Plan enthält Claude Code nicht)

## Mit der Desktop-App statt im Terminal

Die Desktop-App bringt Claude Code schon mit. So richtet ihr sie ein:

1. Ladet die App und installiert sie:
   [Windows (x64)](https://claude.ai/claude-code/desktop-download?platform=win-x64),
   [Windows (ARM64)](https://claude.ai/claude-code/desktop-download?platform=win-arm64),
   [macOS](https://claude.ai/claude-code/desktop-download?platform=mac).
2. Meldet euch mit eurem Claude-Account an und öffnet den Tab **Code**.
3. Wählt unter dem Eingabefeld euren Projektordner. Daneben liegt das **Modus-Menü** (Manual,
   Accept edits, Plan, Auto); die Aufgabe zu den Permission Modes erklärt es.
4. Macht dann Schritt 5 und 6 unten in der App: eine einfache Frage stellen, die App schließen und
   wieder öffnen.

**Entwickler installieren die CLI trotzdem** mit Schritt 1 unten: Die Aufgabe zu den Permission
Modes braucht sie (`claude auto-mode defaults`, `claude --settings`). Die App hat ein eigenes
Terminal (``Ctrl+` ``); öffnet es nach der Installation neu, damit es `claude` findet. Wer nur mit der App
arbeitet, lässt die CLI weg.

Unter Windows installiert ihr zusätzlich [Git for Windows](https://git-scm.com/downloads/win): Die
Git-Schritte der Aufgaben brauchen es, und die CLI nutzt es für ihr Bash-Tool.

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

**Mit der CLI**

- [ ] `claude --version` läuft ohne Fehler
- [ ] `claude doctor` meldet keine Installationsfehler
- [ ] Ihr seid bei einem Claude-Account angemeldet
- [ ] `claude` startet in einem Projektverzeichnis eine interaktive Session
- [ ] Der Agent hat eine einfache Frage zum aktuellen Verzeichnis beantwortet
- [ ] Ein Neustart der Session erfordert keine erneute Anmeldung

**Mit der Desktop-App**

- [ ] Ihr seid angemeldet
- [ ] Der Tab Code hat eine Frage zu eurem Ordner beantwortet
- [ ] Nach dem Neustart der App seid ihr noch angemeldet

## Referenzen

- Claude Code: Overview: https://code.claude.com/docs/en/overview
- Claude Code: Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code: Advanced setup: https://code.claude.com/docs/en/setup
- Claude Code: CLI reference: https://code.claude.com/docs/en/cli-reference
