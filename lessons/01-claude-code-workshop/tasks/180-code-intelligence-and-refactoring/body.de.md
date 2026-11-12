> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

---

In dieser Aufgabe geht es um ein **Refactoring mit Sicherheitsnetz**: Ihr baut die Struktur von Code um, ohne dass sich sein Verhalten ändert. Das Netz sind **Characterisation-Tests**, Tests, die festhalten, was der Code heute tut, auch wenn es seltsam aussieht. Bevor ihr dem Netz vertraut, prüft ihr es, und dann lasst ihr einen Hook die Tests bei jedem Ende ausführen. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24 oder neuer).

### 1. Legt einen Branch an

Öffnet in der Desktop-App das Terminal im Projektordner:

```bash
git switch -c refactor/split-routes
```

Alles Weitere passiert auf diesem Branch, damit `main` unberührt bleibt.

### 2. Kartiert das Gelände

Startet eine neue Session und stellt den Modus auf Plan. Claude liest dann nur und ändert nichts.

```text
Wir wollen api/routes.js nach Ressourcen aufteilen, so wie es api/routes/ schon begonnen hat. Ändere noch nichts. Zeige mir als Tabelle jeden Endpoint der Ressourcen Bücher, Rezensionen und Warenkorb mit Datei und Zeile.
```

Ihr bekommt eine Tabelle mit allen Endpoints. Die Reihenfolge in der Datei gehört zum Verhalten. Notiert euch alles, was Claude als auffällig meldet. Ihr ändert es in dieser Aufgabe nicht.

### 3. Schreibt die Characterisation-Tests

Startet eine neue Session im Modus Auto.

```text
Schreibe Characterisation-Tests für alle Endpoints in api/routes.js, deren Pfad mit /books, /reviews oder /cart beginnt. Die Tests halten fest, was der Code heute tut, auch wenn es seltsam aussieht: Statuscode und Antwortform, auch bei Fehlern, mit und ohne Login, als normaler User und als Admin. Nutze das vorhandene node:test-Setup in api/test/ und ändere keinen Produktionscode. Führe danach npm test aus und berichte kurz.
```

In unserem Lauf entstand eine neue Testdatei mit 58 Tests, alle grün. Bittet Claude danach, die Tests zu committen.

Die Codebasis hat Fehler, und die Tests sind trotzdem grün. Das ist so gewollt: Das Netz kennt kein richtig oder falsch, nur gleich oder anders.

### 4. Prüft das Netz von Hand

Ob das Netz hält, wisst ihr erst, wenn ihr gesehen habt, wie es etwas fängt. Lasst Claude in derselben Session absichtlich ein Verhalten ändern:

```text
Ändere in api/routes.js bei GET /books/:isbn den Statuscode für ein unbekanntes Buch von 404 auf 410. Ändere keine Tests und führe keine Tests aus.
```

Claude meldet, dass es fertig ist. Führt jetzt selbst im Terminal `npm test` aus. In unserem Lauf wurde genau ein Test rot, der den 404 für ein unbekanntes Buch festhält.

Nehmt die Änderung zurück: `git restore api/routes.js` (die Tests sind schon committet) oder `/rewind` (zweimal `Esc` bei leerer Eingabe), dort den Prompt mit der 410-Änderung wählen und „Restore code“. Danach ist `npm test` wieder grün.

Blieb vorher alles grün, fehlt eurem Netz dieser Fall. Lasst Claude jetzt einen Test für den 404 ergänzen und committen, und wiederholt den Schritt.

### 5. Lasst die Tests automatisch laufen

In Schritt 4 hat der Prompt das Testen verboten, deshalb hat nur euer eigener Lauf den Fehler gezeigt. Im Alltag verbietet das niemand, aber eine Bitte wie „teste danach“ geht in einer langen Session auch verloren. Ein **Stop-Hook** läuft jedes Mal, wenn Claude aufhören will, egal was im Prompt steht.

Ihr müsst die lange Zeile unten nicht lesen. Sie tut drei Dinge: `npm test` ausführen, bei Rot das Aufhören blockieren (`exit 2`, kennt ihr aus Aufgabe 120) und beim zweiten Versuch durchlassen (`stop_hook_active`), damit Claude euch noch fragen kann und nicht in einer Schleife hängt. Gebt Claude diesen Prompt:

````text
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
````

Fragt Claude nach, erlaubt es. Die Datei gehört nicht in einen Commit.

Startet eine neue Session im Modus Auto, damit der Hook geladen wird. Schickt denselben Prompt wie in Schritt 4, er verbietet Tests weiterhin. Sagt vorher: Was passiert?

In unserem Lauf meldete Claude erst „Erledigt“. Dann führte der Hook die Tests aus, und Claude nannte von selbst den roten Characterisation-Test mit Datei und Zeile. Greift der Hook bei euch nicht, hilft Tipp 5. Nehmt die Änderung wieder zurück wie in Schritt 4, falls Claude sie nicht selbst zurückgenommen hat.

Der Prompt hat Tests verboten, der Hook hat sie trotzdem ausgeführt. Eine Anweisung gilt für Claude, ein Hook gilt für Claude Code.

### 6. Lasst einen Plan schreiben

Startet eine neue Session im Modus Plan.

```text
Plane das Aufteilen von api/routes.js. Alle Endpoints, deren Pfad mit /books, /reviews oder /cart beginnt, sollen in eigene Dateien in api/routes/ wandern, nach dem Muster der vorhandenen Dateien dort. Das Verhalten darf sich nicht ändern. Gib mir kleine Schritte, nach denen npm test jeweils grün ist. Ändere noch nichts.
```

### 7. Widersprecht dem Plan

Lest den Plan und schreibt selbst, was daran besser werden soll, in derselben Session. Der Plan ist ein Vorschlag, und jetzt ist die billigste Zeit für Korrekturen. Ihr könnt zum Beispiel schreiben:

```text
Der Plan ist mir zu grob. Ändere keine Reihenfolge der Routen, und alles, was seltsam aussieht, bleibt wie es ist und kommt nur in eine Liste. Teile die Schritte so, dass jeder Schritt genau eine neue Datei anlegt und danach npm test grün ist und ein Commit möglich ist.
```

Der Plan kommt in kleineren Schritten zurück. Die Reihenfolge der Routen gehört zum Verhalten, deshalb bleibt sie gleich.

### 8. Setzt den Plan um

Stellt den Modus auf Auto und bleibt in derselben Session.

```text
Setze den Plan jetzt Schritt für Schritt um. Führe nach jedem Schritt npm test aus und committe bei Grün nur die Dateien dieses Schritts, nie .claude/. Ändere keine Tests, ohne mich zu fragen. Bei Rot hältst du an und fragst mich.
```

Der Prompt sorgt für saubere Commits zwischen den Schritten, der Hook sichert das Ende ab: Claude kann nicht mit einem roten Test „fertig“ melden. Hält Claude bei Rot an, um zu fragen, blockiert der Hook das einmal und lässt den zweiten Versuch durch. Fängt Claude stattdessen an, selbst zu reparieren, unterbrecht mit `Esc`. In unserem Lauf entstanden sechs Commits mit neuen Dateien in `api/routes/`, und `npm test` blieb nach jedem grün. Wird ein Test rot, entscheidet ihr: Hat das Refactoring etwas kaputt gemacht, oder hat der Test etwas Falsches festgehalten?

### 9. Prüft den Diff

Startet eine neue Session, damit Claude unbefangen liest.

```text
Lies den Diff dieses Branches gegen main (git diff main). Wurde außer dem Verschieben irgendetwas am Verhalten geändert, auch an der Reihenfolge der Routen? Nenne jede Abweichung mit Datei, oder sag klar, dass du keine gefunden hast.
```

Prüft selbst mit `git log --oneline`, dass die Commits da sind.

### 10. Räumt auf und kehrt zu main zurück

Der Hook würde in späteren Aufgaben bei jedem Ende `npm test` ausführen. Entfernt ihn:

```text
Entferne den Stop-Hook aus .claude/settings.local.json und lass alle anderen Einträge stehen.
```

```bash
git switch main
```

Die späteren Aufgaben starten von `main`. Euer Branch bleibt erhalten.

### Was gerade passiert ist

Die Tests wurden geschrieben, bevor sich Struktur änderte, deshalb bedeutet jedes Grün: Das Verhalten ist gleich geblieben. In Schritt 4 habt ihr gesehen, dass das Netz eine Änderung wirklich fängt. In Schritt 5 hat ein Hook die Tests ausgeführt, ohne dass jemand daran denken musste, sogar gegen den Prompt. Ein Refactoring, das nebenbei Verhalten ändert, ist keins mehr. Was auffällig aussah, gehört deshalb in eine Liste und nicht in den Diff.

**Fertig, wenn**

- die absichtliche Änderung einen Test rot gemacht hat, erst bei eurem eigenen `npm test`, dann über den Hook,
- `refactor/split-routes` Commits mit den Tests und den neuen Dateien in `api/routes/` enthält und `npm test` dort grün ist,
- der Hook entfernt ist und ihr wieder auf `main` seid.

<details>
<summary>Mehr dazu</summary>

- Ein einzelnes Symbol umbenennen oder eine Methode extrahieren geht in der IDE meist schneller als mit einem Agenten. Der Agent lohnt sich dort, wo Lesen und Urteilen nötig sind.
- Hooks im Detail, auch `exit 2` und `PreToolUse`/`PostToolUse`: Aufgabe 120 und [Hooks](https://code.claude.com/docs/en/hooks)
- Code Intelligence: Mit einem Language-Server-Plugin kann Claude laut Docs zu Definitionen springen und Referenzen finden, statt zu suchen. Diese Aufgabe nutzt kein LSP und kein solches Plugin: [Code-Intelligence-Plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Zurücknehmen: [Checkpointing](https://code.claude.com/docs/en/checkpointing) und git. Refactoring-Muster: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
