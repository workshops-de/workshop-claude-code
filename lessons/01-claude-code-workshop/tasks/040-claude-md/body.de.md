## Überblick

Gebt einem Projekt ein dauerhaftes, kuratiertes Gedächtnis, das jede Claude-Code-Session steuert.
Ihr erzeugt eine `CLAUDE.md` für die Codebasis, die ihr in der Grundlagen-Aufgabe erkundet habt,
kürzt sie auf das Wesentliche und beweist in einer frischen Session, dass sie wirkt. Die Lektion:
**Das Langzeitgedächtnis wird kuratiert, nicht abgeladen**, denn jede Zeile kostet bei jedem Turn
Kontext.

## Das Feature

`CLAUDE.md` ist eine Markdown-Datei, die Claude Code zu Beginn jeder Session liest: das
Langzeitgedächtnis eures Projekts.

- **Startet sie** mit `/init`. Claude analysiert die Codebasis und schreibt einen ersten Entwurf
  mit Build-Befehlen, Testanleitung und den Konventionen, die es gefunden hat. Existiert schon eine
  `CLAUDE.md`, schlägt `/init` Verbesserungen vor, statt sie zu überschreiben.
- **Kuratiert sie.** Behaltet, was Claude nicht von selbst ableiten kann: exakte Befehle,
  Architekturregeln, Stolperfallen, ein kurzes Glossar, eine Review-Checkliste. Löscht, was es
  ohnehin schon weiß.
- **Gebt ihr einen Geltungsbereich.** Eine `CLAUDE.md` in einem Unterverzeichnis (zum Beispiel
  `api/CLAUDE.md`) wird nicht beim Start geladen. Sie wird geladen, sobald Claude eine Datei in
  diesem Verzeichnis liest oder ändert.
- **Persönliche Notizen** gehören in `CLAUDE.local.md` (in die `.gitignore` aufnehmen). `/memory`
  zeigt und bearbeitet die geladenen Memory-Dateien.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

Das Übungsfeld ist der [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)-Clone
aus der Grundlagen-Aufgabe. Er hat noch keine `CLAUDE.md`, nur eine README, die über die Jahre
mehrere Leute bearbeitet haben. Ein neues Teammitglied (Mensch oder Agent) würde beides lesen,
also sollte beides stimmen. Eure Memory-Datei soll die Fakten enthalten, die die nächste Session
braucht, geprüft am Code.

## Voraussetzungen

- Der `bookmonkey-legacy`-Clone aus der Grundlagen-Aufgabe
- Node.js 24 oder neuer, damit ihr die Befehle ausführen könnt, die ihr aufschreibt

## Schritte

1. Startet Claude Code in `bookmonkey-legacy` im Manual Mode (`claude --permission-mode default`),
   damit jede Änderung erst nachfragt und das Repository sich nur dort ändert, wo ihr zustimmt.
   Für den Leseteil geht auch der Plan Mode. Führt `/init` aus und lest, was entstanden ist, bevor
   ihr etwas ändert.
2. **Vergleicht `/init` mit der README.** Verlangt von Claude eine Tabelle: jede Aussage der
   README, was `/init` dazu geschrieben hat und was der Code sagt. Prüft jede Zeile, in der sie
   sich widersprechen, selbst (Datei öffnen, Befehl ausführen).
3. **Führt die Befehle aus**, die euer Entwurf auflistet (`npm install`, `npm run db:reset`,
   `npm test`, die beiden Dev-Server), und behaltet nur die, die genau wie geschrieben
   funktionieren.
4. **Kuratiert** die Datei auf wertvolle Fakten: Stack und Versionen, wie jeder Teil gestartet
   wird, die Befehle, Architekturregeln, ein kurzes Domänen-Glossar (Ausleihe, Exemplar,
   Reservierung, Warteliste, ...), Stolperfallen, die ihr in Schritt 2 bestätigt habt, und eine
   Review-Checkliste. Löscht alles Generische.
5. Fügt eine **Unterverzeichnis**-Memory-Datei hinzu, zum Beispiel `api/CLAUDE.md` mit Regeln nur
   für die API. Prüft, dass sie nur geladen wird, wenn Claude in `api/` arbeitet (fragt danach,
   bevor und nachdem Claude eine API-Datei gelesen hat, oder schaut in `/memory`).
6. Öffnet eine **frische** Session (`/clear` oder ein neues Terminal) und stellt eine Frage, deren
   Antwort von eurer Datei abhängt, zum Beispiel „Wie setze ich die Datenbank zurück und führe die
   Tests aus?“ oder „Welchen Port nutzt die API?“. Bestätigt, dass die Antwort aus eurem Memory
   kommt und nicht aus einer neuen Erkundung.
7. Committet die Memory-Dateien in eurem Clone (`git add CLAUDE.md api/CLAUDE.md && git commit`),
   damit die späteren Aufgaben in diesem Repository mit ihnen starten.

## Erfolgskriterien

**Feature**

- [ ] `/init` lief, und ihr könnt mindestens zwei Dinge nennen, die ihr aus dem Entwurf entfernt
      habt, und warum
- [ ] Eine knappe `CLAUDE.md` deckt Stack, Befehle, Architekturregeln, ein Glossar und eine
      Review-Checkliste ab
- [ ] Eine Unterverzeichnis-Memory-Datei existiert und wird nur in ihrem eigenen Bereich geladen
- [ ] Eine frische Session hat nachweislich aus der Memory-Datei geantwortet

**Die Memory-Datei stimmt**

- [ ] Jeder Befehl in der `CLAUDE.md` läuft auf eurem Rechner wie geschrieben
- [ ] Ihr habt README und `/init` mit dem Code verglichen, und die Memory-Datei folgt dem Code
- [ ] Die Memory-Dateien sind in eurem Clone committet

## Referenzen

- Claude Code: Memory and CLAUDE.md: https://code.claude.com/docs/en/memory
- Claude Code: Commands (`/init`, `/memory`): https://code.claude.com/docs/en/commands
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- AGENTS.md (https://agents.md): wird von Claude Code gelesen, wenn es keine `CLAUDE.md` gibt; teilen mit `@AGENTS.md`
- Weitere Ebenen: `~/.claude/CLAUDE.md` (User), `CLAUDE.local.md` (lokal, von Git ignoriert), Managed-Policy-Datei (IT)
