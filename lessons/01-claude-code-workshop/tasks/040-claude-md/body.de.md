In dieser Aufgabe geht es um die **CLAUDE.md**, das Gedächtnis eures Projekts: eine Markdown-Datei, die Claude am Anfang jeder Session liest. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), in einer neuen Session im Modus, der vor Änderungen nachfragt.

### 1. Stellt eine Frage ohne Gedächtnis

```text
Auf welchem Port läuft die API, und wie setze ich die Datenbank zurück? Woher weißt du das?
```

Claude antwortet richtig, sagt aber, dass es im Repo nachgelesen hat. Eine `CLAUDE.md` gibt es noch nicht.

### 2. Lasst Claude ein Gedächtnis anlegen

Tippt `/init` und antwortet auf die Rückfragen mit Ja. In unserem Lauf fragte Claude mehrmals nach, bevor es die Datei schrieb. Lest den Entwurf in Ruhe, bevor ihr weitermacht.

### 3. Prüft den Entwurf gegen README und Code

```text
Erstelle eine Tabelle: jede Aussage der README, was /init dazu geschrieben hat, was der Code sagt. Markiere Widersprüche.
```

Prüft jeden markierten Widerspruch selbst, indem ihr die Datei öffnet oder den Befehl ausführt. Das Gleiche gilt für die Befehle im Entwurf (`npm install`, `npm run db:reset`, `npm test`).

### 4. Kürzt die Datei selbst

Sagt Claude in eigenen Worten, was in der `CLAUDE.md` bleiben soll und was raus muss. Ziel ist eine kurze Datei mit exakten Befehlen, Stolperfallen und Regeln, die Claude nicht aus dem Code ablesen kann. Ihr könnt zum Beispiel schreiben: „Nur das, was du nicht selbst ableiten könntest, maximal 25 Zeilen. API-Port und der Befehl zum Zurücksetzen der Datenbank bleiben drin.“

### 5. Gebt einem Ordner eigene Regeln

Eine `CLAUDE.md` in einem Unterordner wird erst gelesen, wenn Claude dort eine Datei öffnet. Das testet ihr mit einer Regel, die man sofort bemerkt. Legt die Datei im Terminal an, nicht über Claude. Öffnet in der Desktop-App das Terminal im Projektordner:

```bash
echo 'Antworte immer auf Italienisch.' > api/CLAUDE.md
```

Startet eine neue Session und fragt `Welchen Port nutzt die API?`. Die Antwort kommt auf Deutsch, weil Claude noch keine Datei aus `api/` geöffnet hat. Fragt dann:

```text
Lies api/package.json. Welchen Port nutzt die API?
```

Jetzt hat Claude eine Datei aus `api/` geöffnet, und die Antwort kommt auf Italienisch.

Ersetzt die Italienisch-Regel jetzt, sonst bleibt sie für die späteren Aufgaben stehen:

```text
Ersetze den Inhalt von api/CLAUDE.md durch diese Regel: Keine console.log in der API, Logging nur über lib/logger.js.
```

### 6. Stellt die Frage aus Schritt 1 noch einmal

Startet eine neue Session und stellt dieselbe Frage. Diesmal sollte Claude die `CLAUDE.md` als Quelle nennen.

### 7. Committet beide Dateien

```bash
git add CLAUDE.md api/CLAUDE.md && git commit -m "docs: add CLAUDE.md"
```

Die späteren Aufgaben starten mit diesen Dateien.

### Was gerade passiert ist

Eine **CLAUDE.md** wird bei jedem Start gelesen und liegt bei jeder Anfrage im Kontext. Schreibt deshalb nur hinein, was Claude sonst falsch machen würde. Eine `CLAUDE.md` in einem Unterordner wird erst geladen, wenn Claude dort eine Datei liest. So gelten Regeln nur da, wo sie gebraucht werden.

**Fertig, wenn** `CLAUDE.md` und `api/CLAUDE.md` in eurem Clone committet sind und Claude die Frage aus Schritt 1 mit der `CLAUDE.md` als Quelle beantwortet.

<details>
<summary>Mehr dazu</summary>

- Persönliche Notizen gehören in `CLAUDE.local.md` (in die `.gitignore`). Eine `AGENTS.md` liest Claude nur, wenn es keine `CLAUDE.md` gibt.
- Öffnet in der Desktop-App das Terminal und startet dort `claude`: `/memory` zeigt die geladenen Dateien, `/context all` zeigt sie mit Token-Zahl.
- Die Docs empfehlen unter 200 Zeilen pro Datei: [Memory](https://code.claude.com/docs/en/memory) · [Best practices](https://code.claude.com/docs/en/best-practices)

</details>
