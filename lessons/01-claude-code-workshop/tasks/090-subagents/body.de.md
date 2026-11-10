In dieser Aufgabe geht es um **Subagents**. Ein Subagent ist ein zweiter Claude mit eigenem Kontext, der eine Aufgabe getrennt von eurer Unterhaltung erledigt und nur das Ergebnis zurückgibt. Ihr baut die Anmeldung für BookMonkey und lasst sie von einem eigenen Security-Reviewer prüfen.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26. Die API (`npx bookmonkey-api`) läuft auf http://localhost:4730, der Demo-User ist `admin@bookmonkey.api` mit `password1!`.

### 1. Baut die Anmeldung

```text
Bau Anmeldung, Registrierung und Abmeldung gegen die bookmonkey-api (POST /login und POST /register). Das Token kommt in einen signierten http-only Cookie, der auf dem Server gesetzt wird, nicht in localStorage. Ein Guard in proxy.ts leitet den Bereich unter /library auf /login um. Halte es klein und prüfe mit npm run build.
```

Startet die App mit `npm run dev`, öffnet http://localhost:3000/library und meldet euch an. Ohne Anmeldung landet ihr auf `/login`.

### 2. Lasst Claude einen Reviewer anlegen

```text
Erstelle einen Subagent security-reviewer in .claude/agents/. Er prüft Anmeldung, Session-Cookie und Guard auf Sicherheitsprobleme, darf nur lesen und niemals Dateien ändern. Seine Beschreibung soll sagen, dass er nach Änderungen am Anmeldecode eingesetzt wird.
```

Öffnet danach die neue Datei `.claude/agents/security-reviewer.md`. Unter `tools` stehen in unseren Läufen nur `Read`, `Grep` und `Glob`. Ohne `Edit`, `Write` und `Bash` kann der Reviewer nichts ändern.

### 3. Startet eine neue Session

Eine neue Session lädt den Reviewer. In unseren Läufen war er in der Session, in der die Datei entstand, noch nicht bekannt.

### 4. Ruft den Reviewer auf

```text
@agent-security-reviewer Prüfe die Anmeldung. Nenne die Findings nach Schweregrad mit Datei und Zeile und sag bei jedem, ob der Fix ins Frontend oder ins Backend gehört.
```

Claude startet den Subagent, der Reviewer liest die Dateien und eure Unterhaltung bleibt klein. Am Ende steht eine Liste mit Findings. Die Details unterscheiden sich in jedem Lauf.

### 5. Bewertet die Findings selbst

Sucht euch ein Finding aus, das euch plausibel vorkommt, und eines, das ihr für übertrieben haltet. Sagt Claude in eigenen Worten, was ihr mit jedem tun wollt: beheben, später machen oder ablehnen. Ihr schreibt den Prompt selbst.

### Was gerade passiert ist

| | Hauptsession | Subagent |
|---|---|---|
| Kontext | eure Unterhaltung | ein eigener, leerer Kontext |
| Tools | alle | nur die in `tools` |
| Rückgabe | | eine Zusammenfassung |

Alles, was der Reviewer unterwegs liest, bleibt bei ihm. Claude wählt Subagents anhand der `description`, mit `@agent-name` erzwingt ihr einen. Ob ein Finding stimmt, prüft ihr selbst.

**Fertig, wenn** ihr den `security-reviewer` aufgerufen habt, seine Findings gesehen und zu mindestens einem entschieden habt, was damit passiert.

<details>
<summary>Mehr dazu</summary>

Meldet sich der Reviewer als unbekannt, startet eine neue Session. Habt ihr beim Testen User registriert, entfernt `curl -X POST http://localhost:4730/dev/reset` sie wieder.

[Subagents](https://code.claude.com/docs/en/sub-agents)

</details>
