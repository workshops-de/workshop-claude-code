> **⚠️ Setup vor Schritt 7:** Schickt diesen Prompt an Claude, bevor ihr mit Schritt 7 beginnt. In der Desktop-App startet Claude fehlende Server in eigenen Terminal-Tabs (stoppen: Ctrl+C im Tab). Ohne Desktop-App nennt Claude euch die Befehle.
>
> ```text
> Setup für Aufgabe 120: Fehlt im Projektordner node_modules, führe npm install aus. Prüf mit curl, ob die bookmonkey-api auf http://localhost:4730 (Befehl: npx bookmonkey-api) und die App auf http://localhost:3000 (Befehl: npm run dev im Projektordner) antworten. Fehlt ein Server, starte ihn mit diesem Befehl in einem eigenen Tab im Terminal der Desktop-App. Geht das nicht, nenn mir die Befehle. Ist ein Port schon belegt, frag mich. Gib mir am Ende eine Checkliste mit ✅ und ❌.
> ```

---

In dieser Aufgabe geht es um **Hooks**. Ein Hook ist eine Regel, die Claude Code bei bestimmten Tool-Aufrufen selbst anwendet, auch wenn Claude nicht daran denkt. Ihr nutzt Hooks für alles, was **immer passieren muss**.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26 und müsst nur Prompts schreiben. Der Demo-User ist `admin@bookmonkey.api` mit `password1!`.

Claudes Antworten sind bei jedem Lauf anders. Was unter „in unserem Lauf“ steht, ist ein Beispiel. Weicht etwas ab, sagt Claude, was ihr seht und was ihr stattdessen erwartet.

### 1. Schaut, was Claude ohne Hook darf

Die Datei `.env.local` habt ihr schon: Sie enthält seit der Subagents-Aufgabe euren `SESSION_SECRET`, und Git ignoriert sie.

```text
Was steht in meiner .env.local?
```

Der Inhalt erscheint, auch das Secret. So landet es im Verlauf der Session. Manchmal weigert sich Claude schon ohne Hook, weil es ein Secret erkennt. Das entscheidet das Modell jedes Mal neu, eine Garantie ist es nicht. Genau dafür baut ihr den Hook.

### 2. Lasst Claude einen Hook bauen

Eine Zeile in der `CLAUDE.md` würde Claude nur bitten. Ein Hook läuft immer, auch wenn Claude es vergisst. Sagt Claude, was ihr wollt und warum. Wie der Hook gebaut wird, entscheidet Claude.

```text
Ich will nicht, dass du .env-Dateien liest oder änderst, auch nicht aus Versehen, denn darin stehen unsere Secrets. Sorg mit einem Hook dafür, dass das garantiert nicht passiert. .env.example darfst du weiter lesen, da steht nichts Geheimes drin.
```

<details>
<summary>🔑 Fachbegriffe zum Nachsteuern</summary>

Falls Claude etwas anderes baut:

- **`PreToolUse`**-Hook: läuft **vor** dem Tool
- **`exit 2`** blockiert, `exit 1` meldet nur
- Matcher auch für **`Bash`**, nicht nur `Read`
- Ausnahme für **`.env.example`**

</details>

Startet eine neue Session, damit die Einstellung geladen wird, und stellt die Frage aus Schritt 1 noch einmal. Claude sollte sagen, dass ein **Hook** den Zugriff blockiert.

### 3. Lasst Claude den Hook testen

Ein Hook, der zu viel blockiert, stört bei der Arbeit. Ein Hook mit Lücken gibt falsche Sicherheit. Lasst Claude das selbst prüfen, in derselben Session:

```text
Teste deinen .env-Hook, bevor wir ihm vertrauen, aber ohne echte Secrets anzufassen: Gib dem Hook-Skript Beispielaufrufe und zeig mir für jeden, ob er blockiert. Dabei sein sollen: .env.local lesen, .env.example lesen, ein Commit, dessen Message .env.local nur erwähnt (soll durchgehen), und ein Commit, der den Inhalt der Datei mit $(cat .env.local) in die Message holt (soll blockiert sein). Führ die Befehle dabei nicht aus.
```

Claude zeigt eine Tabelle. In unserem Lauf blockierte der Hook auch die harmlose Commit-Message, weil er nur nach dem Text `.env.local` sucht. Claude fand außerdem selbst Schreibweisen, die durchkommen (zum Beispiel `cat .e*.local`), und schlug eine Korrektur vor. Zeigt eure Tabelle auch einen Fehlalarm, sagt Claude, was anders werden soll:

```text
Der Hook blockiert zu viel: Eine Commit-Message, die .env.local nur erwähnt, soll durchgehen. Der Inhalt der Datei darf aber nie in einer Message landen. Bau das um und teste danach alle Fälle noch einmal.
```

Startet danach eine neue Session und stellt die Frage aus Schritt 1 noch einmal.

### 4. Lasst Claude einen zweiten Hook bauen

```text
Immer wenn du eine Datei änderst, sollen die Typen sofort geprüft werden, nicht erst am Ende. Bau dafür einen zweiten Hook, der dir die Typfehler zurückmeldet, damit du sie gleich behebst.
```

<details>
<summary>🔑 Fachbegriffe zum Nachsteuern</summary>

Falls Claude etwas anderes baut:

- **`PostToolUse`**-Hook mit Matcher **`Edit|Write`**
- Typecheck mit **`tsc --noEmit`**
- Fehler gehen **an Claude zurück**, nicht nur ins Terminal

</details>

Meldet der Hook `PageProps` oder `LayoutProps`, fehlen die Next-Typen. In unserem Lauf hat Claude dafür selbst `next typegen` ausgeführt. Sonst bittet Claude darum.

### 5. Probiert den Typecheck-Hook aus

Startet eine neue Session:

```text
Zeig mir, dass der Typecheck-Hook anschlägt: Bau absichtlich einen kleinen Typfehler in eine neue Testdatei, zeig mir, was der Hook dir meldet, und lösch die Datei danach wieder.
```

Claude zeigt die Meldung des Hooks, in unserem Lauf `error TS2322: Type 'string' is not assignable to type 'number'`.

### 6. Baut mit beiden Hooks die Leseliste

Eine Leseliste hat Zustände (want to read, reading, finished). Eine State Machine legt fest, welche Wechsel zwischen den Zuständen erlaubt sind. Die Leseliste ist das Übungsfeld: Hier sollen beide Hooks bei echter Arbeit mitlaufen. Erst klärt ihr die Regeln mit Claude, dann baut es sie.

```text
Wir bauen eine Leseliste. Ein Buch auf der Liste ist entweder "want to read", "reading" oder "finished". Hinzufügen führt zu want to read, beginnen zu reading, abschließen zu finished, und ein fertiges Buch kann man erneut beginnen. Entfernen geht immer. Bevor du loslegst: Erklär mir in eigenen Worten, welche Wechsel erlaubt sind und welche nicht, damit wir sicher dasselbe meinen. Frag nach, wenn etwas unklar ist.
```

Claude zählt die erlaubten und verbotenen Wechsel auf und nennt seine Annahmen, in unserem Lauf zum Beispiel, dass ein Buch nicht zweimal auf die Liste kann. Bestätigt sie oder widersprecht. Dann in derselben Session:

```text
Bau das jetzt. Auf der Detailseite eines Buchs will ich es auf meine Leseliste setzen und den Zustand wechseln. Unter /reading-list sehe ich meine Bücher nach Zustand gruppiert, und oben im Header steht, wie viele es sind. Die Seite ist nur für angemeldete User erreichbar, und jeder User hat seine eigene Liste. Die API kann noch keine Leselisten, speichere sie deshalb vorerst im Browser. Halte die Regeln für die Wechsel an einer Stelle und unabhängig vom Speicher, damit wir sie später ins eigene Backend mitnehmen können.
```

<details>
<summary>🔑 Fachbegriffe zum Nachsteuern</summary>

Falls Claude etwas anderes baut:

- **`localStorage`**, Schlüssel mit **User-ID**
- **State Machine** als **reine Funktion**, eigene Datei ohne Speicher und React
- **Proxy-Matcher** in `proxy.ts` um `/reading-list` ergänzen
- Header-Zähler erst **nach dem Laden** lesen (sonst **Hydration-Mismatch**)

</details>

Beide Hooks laufen bei jeder Änderung mit. Fragt danach:

```text
Hat dir der Typecheck-Hook beim Bauen etwas gemeldet? Zeig mir, was es war und wie du es behoben hast.
```

In unserem Lauf meldete er fünfmal. Viermal waren es Zwischenstände (ein Import kam erst im nächsten Edit), einmal ein echter Fehler, den Claude sofort behob.

### 7. Probiert die Leseliste im Browser aus

Prüft, dass beide Server laufen (Setup-Prompt oben), meldet euch auf http://localhost:3000 als Demo-User an und setzt ein Buch auf die Liste. Meldet euch ab, registriert einen zweiten Account (zum Beispiel zweiter@example.com mit password1!) und öffnet `/reading-list`. Die Liste ist leer. Seht ihr die Bücher des ersten Accounts, sagt Claude das und dass jeder User eine eigene Liste haben soll.

### 8. Committet euren Stand

Die Hooks liegen in `.claude/` im Repo. Sind sie committet, gelten sie für alle im Team.

```text
Schau dir an, was wir in dieser Aufgabe geändert haben, und committe es.
```

### Was gerade passiert ist

Der erste Hook lief **vor** dem Tool (`PreToolUse`) und stoppte es, in unserem Lauf mit `exit 2`. Der zweite lief **danach** (`PostToolUse`, Matcher `Edit|Write`) und gab Claude die Fehler zurück. Getestet hat Claude die Hooks, indem es dem Skript Beispielaufrufe als JSON gab, so wie Claude Code sie beim echten Aufruf schickt. Eine Anweisung in der `CLAUDE.md` berät, ein Hook erzwingt.

Ein Hook, der Befehlstext durchsucht, fängt Versehen ab, aber keinen absichtlichen Umweg über die Shell. Das hat Claude in unserem Lauf selbst gesagt. Für echte Sicherheit kommen `permissions.deny`-Regeln und die Sandbox dazu.

**Fertig, wenn** ein Hook euch den Zugriff auf `.env.local` verweigert hat, Claude die Meldung des Typecheck-Hooks gezeigt hat und die Leseliste mit zwei Accounts getrennte Listen zeigt.

<details>
<summary>Mehr dazu</summary>

Claude legt die Hooks in `.claude/settings.json` und `.claude/hooks/` an. Die Hooks seht ihr im Terminal: öffnet in der Desktop-App das Terminal, startet dort `claude` und gebt `/hooks` ein. Nutzt ein Hook-Skript `jq` und `jq` fehlt, blockiert es je nach Bauart alles oder nichts. Prüft vorher `jq --version`. `exit 2` blockiert einen Aufruf, `exit 1` meldet nur einen Fehler und lässt ihn durch. Eine Sperre unabhängig vom Befehlstext ist eine Regel in `.claude/settings.json`: `{"permissions": {"deny": ["Read(./.env*)"]}}`. Habt ihr beim Testen User registriert, entfernt `curl -X POST http://localhost:4730/dev/reset` sie wieder.

[Hooks guide](https://code.claude.com/docs/en/hooks-guide)

</details>
