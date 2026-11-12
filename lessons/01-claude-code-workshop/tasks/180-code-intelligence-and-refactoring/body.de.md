> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

---

In dieser Aufgabe geht es um ein **Refactoring mit Sicherheitsnetz**: Ihr baut die Struktur von Code um, ohne dass sich sein Verhalten ändert. Das Netz sind **Characterisation-Tests**, Tests, die festhalten, was der Code heute tut, auch wenn es seltsam aussieht. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24 oder neuer).

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

In unserem Lauf entstand eine neue Testdatei mit 58 Tests, alle grün. Bittet Claude danach, die Tests zu committen. Erst jetzt habt ihr ein Netz.

### 4. Lasst einen Plan schreiben

Startet eine neue Session im Modus Plan.

```text
Plane das Aufteilen von api/routes.js. Alle Endpoints, deren Pfad mit /books, /reviews oder /cart beginnt, sollen in eigene Dateien in api/routes/ wandern, nach dem Muster der vorhandenen Dateien dort. Das Verhalten darf sich nicht ändern. Gib mir kleine Schritte, nach denen npm test jeweils grün ist. Ändere noch nichts.
```

### 5. Widersprecht dem Plan

Lest den Plan und schreibt selbst, was daran besser werden soll, in derselben Session. Der Plan ist ein Vorschlag, und jetzt ist die billigste Zeit für Korrekturen. Ihr könnt zum Beispiel schreiben:

```text
Der Plan ist mir zu grob. Ändere keine Reihenfolge der Routen, und alles, was seltsam aussieht, bleibt wie es ist und kommt nur in eine Liste. Teile die Schritte so, dass jeder Schritt genau eine neue Datei anlegt und danach npm test grün ist und ein Commit möglich ist.
```

Der Plan kommt in kleineren Schritten zurück. Die Reihenfolge der Routen gehört zum Verhalten, deshalb bleibt sie gleich.

### 6. Setzt den Plan um

Stellt den Modus auf Auto und bleibt in derselben Session.

```text
Setze den Plan jetzt Schritt für Schritt um. Führe nach jedem Schritt npm test aus und committe bei Grün. Bei Rot hältst du an und fragst mich.
```

In unserem Lauf entstanden sechs Commits mit neuen Dateien in `api/routes/`, und `npm test` blieb nach jedem grün. Wird ein Test rot, entscheidet ihr: Hat das Refactoring etwas kaputt gemacht, oder hat der Test etwas Falsches festgehalten?

### 7. Prüft den Diff

Startet eine neue Session, damit Claude unbefangen liest.

```text
Lies den Diff dieses Branches gegen main (git diff main). Wurde außer dem Verschieben irgendetwas am Verhalten geändert, auch an der Reihenfolge der Routen? Nenne jede Abweichung mit Datei, oder sag klar, dass du keine gefunden hast.
```

Prüft die Antwort selbst: `git log --oneline` zeigt die Commits, und `npm test` muss grün sein.

### 8. Kehrt zu main zurück

```bash
git switch main
```

Die späteren Aufgaben starten von `main`. Euer Branch bleibt erhalten.

### Was gerade passiert ist

Die Tests wurden geschrieben, bevor sich Struktur änderte, deshalb bedeutet jedes Grün: Das Verhalten ist gleich geblieben. Der Plan im Modus Plan hat die Arbeit in Schritte zerlegt, die ihr vorher korrigieren konntet. Ein Refactoring, das nebenbei Verhalten ändert, ist keins mehr. Was auffällig aussah, gehört deshalb in eine Liste und nicht in den Diff.

**Fertig, wenn** `refactor/split-routes` mehrere Commits mit den Tests und den neuen Dateien in `api/routes/` enthält, `npm test` dort grün ist und ihr wieder auf `main` seid.

<details>
<summary>Mehr dazu</summary>

- Ein einzelnes Symbol umbenennen oder eine Methode extrahieren geht in der IDE meist schneller als mit einem Agenten. Der Agent lohnt sich dort, wo Lesen und Urteilen nötig sind.
- Code Intelligence: Mit einem Language-Server-Plugin kann Claude laut Docs zu Definitionen springen und Referenzen finden, statt zu suchen. Diese Aufgabe nutzt kein LSP und kein solches Plugin: [Code-Intelligence-Plugins](https://code.claude.com/docs/en/plugins/code-intelligence)
- Zurücknehmen: [Checkpointing](https://code.claude.com/docs/en/checkpointing) und git. Refactoring-Muster: [Fowler, Refactoring catalog](https://refactoring.com/catalog/)
- Characterization testing: [Michael Feathers](https://michaelfeathers.silvrback.com/characterization-testing)

</details>
