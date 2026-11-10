In dieser Aufgabe geht es um die **CLAUDE.md**, das Gedächtnis eures Projekts: eine Markdown-Datei, die Claude am Anfang jeder Session liest. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone, in einer neuen Session im Modus, der vor Änderungen nachfragt.

### 1. Stellt eine Frage ohne Gedächtnis

```text
Auf welchem Port läuft die API, und wie setze ich die Datenbank zurück? Woher weißt du das?
```

Claude antwortet richtig, sagt aber, dass es im Repo nachgelesen hat. Eine `CLAUDE.md` gibt es noch nicht.

### 2. Lasst Claude ein Gedächtnis anlegen

Tippt `/init` und bestätigt die Rückfragen. In unseren Läufen fragt Claude mehrmals nach, bevor es die Datei schreibt. Lest den Entwurf in Ruhe, bevor ihr weitermacht.

### 3. Prüft den Entwurf gegen README und Code

```text
Erstelle eine Tabelle: jede Aussage der README, was /init dazu geschrieben hat, was der Code sagt. Markiere Widersprüche.
```

Prüft jeden markierten Widerspruch selbst, indem ihr die Datei öffnet oder den Befehl ausführt. Das Gleiche gilt für die Befehle im Entwurf (`npm install`, `npm run db:reset`, `npm test`).

### 4. Kürzt die Datei selbst

Sagt Claude in eigenen Worten, was in der `CLAUDE.md` bleiben soll und was raus muss. Ziel ist eine kurze Datei mit exakten Befehlen, Stolperfallen und Regeln, die Claude nicht aus dem Code ablesen kann. Ihr könnt zum Beispiel schreiben: „Nur das, was du nicht selbst ableiten könntest, maximal 25 Zeilen.“

### 5. Gebt einem Ordner eigene Regeln

Legt die Datei im Terminal an, nicht über Claude. Öffnet in der Desktop-App das Terminal im Projektordner:

```bash
echo 'Antworte immer auf Italienisch.' > api/CLAUDE.md
```

Startet eine neue Session und fragt `Welchen Port nutzt die API?`. Die Antwort kommt auf Deutsch. Fragt dann:

```text
Lies api/package.json. Welchen Port nutzt die API?
```

Jetzt kommt die Antwort auf Italienisch. Wer Claude im Terminal nutzt, sieht dabei die Zeile `Loaded api/CLAUDE.md`. Bittet Claude danach, die Italienisch-Regel durch eine echte Regel für die API aus Schritt 3 zu ersetzen.

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
