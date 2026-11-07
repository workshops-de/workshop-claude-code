## Überblick

Bevor ihr Code anfasst, installiert ihr Claude Code als Terminal-Tool auf eurem eigenen Rechner und
prüft, dass es von Anfang bis Ende funktioniert: Es läuft, ihr seid angemeldet und es antwortet.
Das ist eine reine Setup-Aufgabe – kein Erkunden, kein Code, nur eine funktionierende
Installation, auf die ihr euch für den Rest des Workshops verlassen könnt.

## Voraussetzungen

- Node.js 18+ installiert (`node -v`), falls ihr per npm installieren wollt
- Ein Terminal, mit dem ihr gut zurechtkommt
- Ein Claude-Account (Claude.ai oder Claude Console)

## Schritte

1. Installiert Claude Code auf einem der beiden Wege:

   ```bash
   # macOS / Linux / WSL — natives Installationsskript
   curl -fsSL https://claude.ai/install.sh | bash

   # oder per npm (jedes OS mit Node.js 18+)
   npm install -g @anthropic-ai/claude-code
   ```

2. Prüft, dass es in eurem `PATH` liegt, und schaut euch die Version an:

   ```bash
   claude --version
   ```

3. Wechselt in ein beliebiges Projektverzeichnis und startet eine Session:

   ```bash
   cd your-project
   claude
   ```

4. **Meldet euch an**, wenn ihr dazu aufgefordert werdet (über Claude.ai oder Claude Console), und
   wartet, bis der Prompt interaktiv wird.

5. **Testet, ob es funktioniert**: Stellt eine einfache Frage (zum Beispiel „welche Dateien liegen
   in diesem Verzeichnis?“) und prüft, dass ihr eine sinnvolle Antwort bekommt.

6. Beendet die Session sauber (`/exit` oder `Ctrl+C`) und startet sie erneut, um zu prüfen, dass
   auch der zweite Start reibungslos läuft – keine erneute Anmeldung, keine Fehler.

## Erfolgskriterien

- [ ] `claude --version` läuft ohne Fehler
- [ ] Ihr seid bei einem Claude-Account angemeldet
- [ ] `claude` startet in einem Projektverzeichnis eine interaktive Session
- [ ] Der Agent hat eine einfache Frage zum aktuellen Verzeichnis beantwortet
- [ ] Ein Neustart der Session erfordert keine erneute Anmeldung

## Referenzen

- Claude Code — Overview: https://code.claude.com/docs/en/overview
- Claude Code — Quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code — CLI reference: https://code.claude.com/docs/en/cli-reference
