In dieser Aufgabe geht es um **Regeldateien und Imports**: Ihr legt die Fachsprache und den API-Vertrag von BookMonkey einmal fest, damit jede neue Session sie kennt. Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26 und startet die API mit `npx bookmonkey-api`, falls sie noch nicht läuft.

### 1. Lasst Claude die Fachsprache aufschreiben

```text
Die BookMonkey-API läuft auf http://localhost:4730. Speichere ihren Vertrag von /api-json in docs/openapi.json. Schreibe dann .claude/rules/domain.md: ein Glossar unserer Fachsprache (Buch, ISBN, id, Reihe, Autor) mit Entitätsmodell, servergeführten Feldern und Einschränkungen. Prüfe Aussagen mit echten Antworten der API statt sie zu raten. Neu dazu kommt die Leseliste mit den Zuständen want to read, reading und finished. Setze danach die API mit POST /dev/reset zurück.
```

Claude fragt die API selbst ab, legt Testbücher an und schreibt das Ergebnis in `domain.md`. In unseren Läufen standen dort zum Beispiel, dass eine doppelte ISBN mit `409` abgelehnt wird und dass Detail-Routen die ISBN verlangen, nicht die `id`. Die Leseliste gibt es in der API noch nicht, ihr plant sie für später. Der Reset räumt die Testbücher wieder weg. Lest die Datei und widersprecht, wenn etwas nicht stimmt.

### 2. Importiert einen kompakten Vertrag

```text
Schreibe eine kompakte docs/api-contract.md aus docs/openapi.json: Endpoints, Query-Parameter und Statuscodes, alles auf einem Bildschirm. Lege dann eine CLAUDE.md an, die diese Datei und die AGENTS.md per @-Import einbindet.
```

Eine `CLAUDE.md` kann andere Dateien einbinden: eine Zeile mit `@` und dem Dateinamen. Die `CLAUDE.md` besteht danach im Kern aus zwei Zeilen: `@AGENTS.md` und `@docs/api-contract.md`. Die `AGENTS.md` hat `create-next-app` erzeugt, und Claude Code liest sie nur noch über diesen Import, sobald es eine `CLAUDE.md` gibt.

### 3. Fragt in einer neuen Session nach der Fachsprache

Startet eine neue Session und fragt:

```text
Was ist bei uns der Unterschied zwischen id und isbn, und was ist eine Leseliste? Antworte in drei Sätzen.
```

Claude antwortet mit euren Begriffen, ohne eine Datei zu lesen. Die Regeldatei und der Vertrag waren schon beim Start im Kontext.

### 4. Schreibt eine Regel, die nur für eine Datei gilt

Jetzt bittet ihr Claude selbst um eine Regel in `.claude/rules/api-client.md`. Sie soll nur gelten, wenn Claude am API-Client `lib/api.ts` arbeitet. Überlegt euch zwei Konventionen, die nur dort zählen, zum Beispiel ein festes Präfix für Fehlermeldungen. Schreibt den Prompt in eigenen Worten.

### 5. Seht, wann die Regel greift

Startet eine neue Session und fragt zuerst:

```text
Welche Regeln gelten für den API-Client in lib/api.ts? Lies die Datei nicht, antworte aus dem, was du schon weißt.
```

Claude kennt eure Regel noch nicht. Bittet es dann in derselben Session:

```text
Füge in lib/api.ts eine Funktion getBook hinzu, die ein Buch lädt, und wirf bei Fehlern einen Error.
```

Sobald Claude `lib/api.ts` öffnet, lädt die Regel, und die neue Funktion folgt euren Konventionen. In unserem Lauf folgten die neuen Fehlermeldungen dem Präfix, den wir in der Regel festgelegt hatten.

### 6. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

| Ort | Wann geladen | Wofür |
|---|---|---|
| `CLAUDE.md` und Imports | bei jedem Start | Fakten, die immer gelten |
| `.claude/rules/*.md` ohne `paths` | bei jedem Start | ein Thema pro Datei, z. B. die Fachsprache |
| `.claude/rules/*.md` mit `paths` | wenn Claude eine passende Datei liest | Konventionen für einen Bereich |

Imports ordnen euer Gedächtnis, sie sparen aber keinen Kontext: Alles, was beim Start geladen wird, kostet bei jedem Prompt. Darum importiert ihr eine kompakte Zusammenfassung und keine rohe `openapi.json`. Die vollständige Datei bleibt auf der Platte, Claude liest sie bei Bedarf.

**Fertig, wenn** eine neue Session eure Begriffe aus `domain.md` verwendet, Claude eure Regel aus `api-client.md` vor dem Öffnen von `lib/api.ts` nicht kennt und `getBook` danach euren Konventionen folgt.

<details>
<summary>Mehr dazu</summary>

Eure `domain.md` enthält auch die Leseliste mit ihren Zuständen. Die baut ihr in der Hooks-Aufgabe. `docs/openapi.json` solltet ihr committen, denn sie dient später als Vertrag für ein eigenes Backend.

Das `paths`-Feld steht als Frontmatter am Anfang der Regeldatei, zum Beispiel `paths: ["lib/api.ts"]`. Ob die geladenen Dateien in der Desktop-App sichtbar sind, haben wir nicht geprüft; wer nachsehen will, öffnet dort das Terminal, startet `claude` und tippt `/memory`.

- [Memory, rules and imports](https://code.claude.com/docs/en/memory)
- [Path-specific rules](https://code.claude.com/docs/en/memory#path-specific-rules)

</details>
