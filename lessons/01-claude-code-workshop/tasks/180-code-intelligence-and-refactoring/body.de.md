> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

---

Ihr baut Code um, ohne sein Verhalten zu ändern. Das Sicherheitsnetz sind **Characterisation-Tests**: Sie halten fest, was der Code heute tut. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24 oder neuer).

### 1. Legt einen Branch an

Ihr nehmt euren bisherigen Clone. `git diff origin/main --stat` sollte höchstens eure `CLAUDE.md`-Dateien zeigen.

```bash
git switch -c refactor/split-routes
```

### 2. Kartiert das Gelände

Neue Session, Modus Plan:

```text
Wir wollen api/routes.js nach Ressourcen aufteilen, so wie es api/routes/ schon begonnen hat. Ändere noch nichts. Zeige mir als Tabelle jeden Endpoint der Ressourcen Bücher, Rezensionen und Warenkorb mit Datei und Zeile.
```

Was Claude als auffällig meldet, notiert ihr nur. Die Reihenfolge der Routen gehört zum Verhalten.

### 3. Schreibt die Characterisation-Tests

Neue Session, Modus Auto:

```text
Schreibe Characterisation-Tests für alle Endpoints in api/routes.js, deren Pfad mit /books, /reviews oder /cart beginnt. Die Tests halten fest, was der Code heute tut, auch wenn es seltsam aussieht: Statuscode und Antwortform, auch bei Fehlern, mit und ohne Login, als normaler User und als Admin. Nutze das vorhandene node:test-Setup in api/test/ und ändere keinen Produktionscode. Führe danach npm test aus, berichte kurz und committe die Tests.
```

In unserem Lauf: 58 Tests, alle grün, obwohl die Codebasis Fehler hat. Das Netz kennt kein richtig oder falsch, nur gleich oder anders.

### 4. Prüft das Netz von Hand

In derselben Session:

```text
Ändere in api/routes.js bei GET /books/:isbn den Statuscode für ein unbekanntes Buch von 404 auf 410. Ändere keine Tests und führe keine Tests aus.
```

Claude meldet „fertig“. Führt selbst `npm test` aus. In unserem Lauf wurde ein Test rot. Bleibt alles grün, fehlt dieser Fall im Netz. Zurücknehmen: `git restore api/routes.js`.

### 5. Lasst die Tests automatisch laufen

Ein **Stop-Hook** führt `npm test` aus, sobald Claude aufhören will. Bei Rot darf Claude nicht aufhören (`exit 2`, Aufgabe 120). Lasst ihn einfügen:

```text
Füge in .claude/settings.local.json genau diesen Stop-Hook ein und lass vorhandene Einträge stehen:

{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "input=$(cat); case \"$input\" in *'\"stop_hook_active\":true'*|*'\"stop_hook_active\": true'*) exit 0;; esac; out=$(npm test 2>&1) || { printf '%s\\n' \"$out\" | tail -40 >&2; exit 2; }",
            "timeout": 120
          }
        ]
      }
    ]
  }
}
```

Neue Session, Modus Auto, Prompt aus Schritt 4. Ratet vorher, was passiert. In unserem Lauf meldete Claude „Erledigt“, der Hook testete trotzdem, und Claude nannte den roten Test. Danach `git restore api/routes.js`. Die Datei `.claude/settings.local.json` nicht committen.

### 6. Plant und widersprecht

Neue Session, Modus Plan:

```text
Plane das Aufteilen von api/routes.js. Alle Endpoints, deren Pfad mit /books, /reviews oder /cart beginnt, sollen in eigene Dateien in api/routes/ wandern, nach dem Muster der vorhandenen Dateien dort. Das Verhalten darf sich nicht ändern. Ändere noch nichts.
```

Lest den Plan und korrigiert ihn in derselben Session, zum Beispiel:

```text
Ändere keine Reihenfolge der Routen. Was seltsam aussieht, bleibt und kommt nur in eine Liste. Jeder Schritt legt genau eine neue Datei an, danach ist npm test grün.
```

### 7. Setzt den Plan um

Modus Auto, dieselbe Session:

```text
Setze den Plan Schritt für Schritt um. Führe nach jedem Schritt npm test aus und committe bei Grün nur die Dateien dieses Schritts, nie .claude/. Ändere keine Tests, ohne mich zu fragen. Bei Rot hältst du an und fragst mich.
```

In unserem Lauf: sechs Commits, nach jedem grün. Der Hook sorgt dafür, dass Claude nicht mit einem roten Test „fertig“ meldet. Wird ein Test rot, entscheidet ihr: Hat das Refactoring etwas kaputt gemacht, oder hat der Test etwas Falsches festgehalten?

### 8. Räumt auf

```text
Entferne den Stop-Hook aus .claude/settings.local.json und lass alle anderen Einträge stehen.
```

```bash
git switch main
```

Sonst läuft der Hook in späteren Aufgaben bei jedem Ende mit. Euer Branch bleibt erhalten.

**Fertig, wenn**

- die absichtliche Änderung einen Test rot gemacht hat, erst bei eurem eigenen `npm test`, dann über den Hook,
- `refactor/split-routes` Commits mit den Tests und den neuen Dateien in `api/routes/` enthält und `npm test` dort grün ist,
- der Hook entfernt ist und ihr wieder auf `main` seid.

<details>
<summary>Mehr dazu</summary>

- Diff-Review zum Schluss: Lasst eine neue Session `git diff main` lesen und jede Verhaltensänderung nennen.
- Ein einzelnes Symbol umbenennen oder eine Methode extrahieren geht in der IDE meist schneller als mit einem Agenten. Der Agent lohnt sich dort, wo Lesen und Urteilen nötig sind.
- Hooks im Detail: Aufgabe 120 und [Hooks](https://code.claude.com/docs/en/hooks)
- Code Intelligence: Mit einem Language-Server-Plugin kann Claude laut Docs zu Definitionen springen und Referenzen finden, statt zu suchen. Diese Aufgabe nutzt kein LSP und kein solches Plugin: [Code-Intelligence-Plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Zurücknehmen: [Checkpointing](https://code.claude.com/docs/en/checkpointing) und git. Refactoring-Muster: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
