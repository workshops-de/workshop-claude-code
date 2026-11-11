> **⚠️ Zuerst die API starten:** Öffnet ein **separates Terminalfenster** und startet dort `npx bookmonkey-api`. Lasst es während der ganzen Aufgabe offen, damit der Server lokal auf http://localhost:4730 läuft.

In dieser Aufgabe geht es um **Hooks**. Ein Hook ist eine Regel, die Claude Code bei bestimmten Tool-Aufrufen selbst anwendet, auch wenn Claude nicht daran denkt. Ihr nutzt Hooks für alles, was **immer passieren muss**.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26 und müsst nur Prompts schreiben. Für Schritt 7 braucht ihr zwei Server: `npx bookmonkey-api` (http://localhost:4730) und `npm run dev` (http://localhost:3000). Der Demo-User ist `admin@bookmonkey.api` mit `password1!`.

### 1. Schaut, was Claude ohne Hook darf

Die Datei `.env.local` habt ihr schon: Sie enthält seit der Subagents-Aufgabe euren `SESSION_SECRET`, und Git ignoriert sie.

```text
Lies die Datei .env.local und zeig mir den Inhalt.
```

Der Inhalt erscheint, auch Secrets.

### 2. Lasst Claude einen Hook bauen

```text
Richte einen Hook ein, damit du keine .env-Dateien mehr lesen oder ändern kannst. .env.example soll lesbar bleiben.
```

Startet eine neue Session, damit die Einstellung geladen wird, und stellt die Frage aus Schritt 1 noch einmal. Claude sollte sagen, dass ein **Hook** den Zugriff blockiert.

### 3. Prüft, was Claude gebaut hat

```text
Führe genau diesen Befehl aus: git commit --allow-empty -m "docs: .env.local erwähnt"
```

Der Commit ist harmlos, wurde in unseren Läufen aber blockiert, weil der Hook auch den Befehlstext durchsucht. Passiert das bei euch, sagt Claude, was anders werden soll:

```text
Der Hook blockiert zu viel: Eine Commit-Message, die .env.local nur erwähnt, soll durchgehen. Dateizugriffe auf .env-Dateien sollen weiter blockiert sein.
```

Wiederholt danach den Commit-Befehl und die Frage aus Schritt 1.

### 4. Lasst Claude einen zweiten Hook bauen

Schreibt selbst einen Satz: Nach jedem `Edit` oder `Write` soll ein Typecheck laufen und Claude soll die Typfehler sehen. Zum Beispiel:

```text
Richte einen zweiten Hook ein: Nach jedem Edit oder Write soll ein Typecheck laufen, und du sollst die Typfehler sehen und beheben.
```

### 5. Probiert den Typecheck-Hook aus

Startet eine neue Session und baut einen absichtlichen Fehler ein:

```text
Lege die Datei lib/typfehler-test.ts mit genau diesem Inhalt an: export const x: number = "text";
```

Claude sollte `TS2322` nennen. Meldet es auch `PageProps` oder `LayoutProps`, führt `npx next typegen` aus. Räumt danach auf:

```text
Lösche die Datei lib/typfehler-test.ts wieder.
```

### 6. Baut mit beiden Hooks die Leseliste

Eine Leseliste hat Zustände (want to read, reading, finished). Eine State Machine legt fest, welche Wechsel zwischen den Zuständen erlaubt sind. Erst klärt ihr die Regeln mit Claude, dann baut es sie.

```text
Wir bauen eine Leseliste. Übergänge: hinzufügen führt zu want to read, beginnen zu reading, abschließen zu finished, erneut beginnen zu reading, entfernen geht aus jedem Zustand. Wiederhole die zulässigen und die unzulässigen Übergänge, bevor du etwas schreibst.
```

Dann im selben Chat:

```text
Setze das jetzt um: die State Machine als reine Funktion transition(state, action), die unzulässige Übergänge ablehnt. Dazu ein Store pro User in localStorage, Leselisten-Buttons auf der Detailseite, eine Seite /reading-list im angemeldeten Bereich, nach Zustand gruppiert, und ein Zähler im Header. Gibt es noch keinen Header, lege einen an.
```

Beide Hooks laufen bei jeder Änderung mit.

### 7. Probiert die Leseliste im Browser aus

Startet die beiden Server, meldet euch auf http://localhost:3000 als Demo-User an und setzt ein Buch auf die Liste. Meldet euch ab, registriert einen zweiten Account (zum Beispiel zweiter@example.com mit password1!) und öffnet `/reading-list`. Die Liste ist leer.

### 8. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

Der erste Hook lief **vor** dem Tool (`PreToolUse`) und stoppte es, in unserem Lauf mit `exit 2`. Der zweite lief **danach** (`PostToolUse`) und gab Claude die Fehler zurück. Eine Anweisung in der `CLAUDE.md` berät, ein Hook erzwingt.

**Fertig, wenn** ein Hook euch den Zugriff auf `.env.local` verweigert hat, Claude `TS2322` aus dem Typecheck-Hook genannt hat und die Leseliste mit zwei Accounts getrennte Listen zeigt.

<details>
<summary>Mehr dazu</summary>

Claude legt die Hooks in `.claude/settings.json` und `.claude/hooks/` an. Die Hooks seht ihr im Terminal: öffnet in der Desktop-App das Terminal, startet dort `claude` und gebt `/hooks` ein. Ohne `jq` schlägt ein Hook-Skript still fehl und blockiert nichts. Habt ihr beim Testen User registriert, entfernt `curl -X POST http://localhost:4730/dev/reset` sie wieder.

[Hooks guide](https://code.claude.com/docs/en/hooks-guide)

</details>
