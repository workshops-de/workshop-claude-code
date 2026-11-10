In dieser Aufgabe geht es um **LLM-Gateways**: Ein Gateway ist ein Server, über den Claude Code seine Anfragen an das Modell schickt, statt direkt zu Anthropic. Ihr baut ein kleines Gateway zum Ausprobieren, schaut, was Claude Code dorthin sendet, und leitet daraus eine Empfehlung für eure Firma ab.

Ihr arbeitet in einem neuen, leeren Ordner `gateway-test` (zum Beispiel `mkdir gateway-test && cd gateway-test`), geöffnet in der Desktop-App, mit Node.js 22 oder neuer. Ihr braucht dafür keinen Account und keinen API-Key.

### 1. Lasst Claude ein Test-Gateway schreiben

Startet eine neue Session und schickt:

```text
Schreibe mock-gateway.js: ein Node-Skript ohne Abhängigkeiten, das auf Port 3420 einen Anthropic-kompatiblen Endpoint nachbildet. Es beantwortet POST /v1/messages als Stream im Format der Anthropic Messages API mit dem festen Text 'Hallo vom Mock-Gateway.' Für jede Anfrage schreibt es eine Zeile ins Terminal: Pfad, angefragtes Modell, Anzahl der Tools, ob gestreamt wird und mit welchem Header die Anmeldung kam (nur der Name des Headers, nie der Wert).
```

Claude legt `mock-gateway.js` an. Es antwortet immer mit demselben Satz, ein echtes Modell steckt nicht dahinter.

### 2. Startet das Gateway

Öffnet in der Desktop-App ein Terminal im Projektordner und startet:

```bash
node mock-gateway.js
```

Lasst es offen, es zeigt gleich jede Anfrage.

### 3. Schickt eine Anfrage durch das Gateway

Öffnet ein zweites Terminal im selben Ordner. Mit `ANTHROPIC_BASE_URL` sagt ihr Claude Code, wohin es seine Anfragen schickt, `ANTHROPIC_AUTH_TOKEN` ist hier ein ausgedachtes Token. Unter Windows nehmt die Git Bash:

```bash
ANTHROPIC_BASE_URL=http://localhost:3420 ANTHROPIC_AUTH_TOKEN=test-token claude -p "Sag Hallo"
```

Die Antwort ist euer fester Satz, kein echtes Claude. Im ersten Terminal stehen Zeilen mit `/v1/messages`. In unserem Lauf waren es drei: eine Anfrage mit 13 Tools und zwei kleine ohne Tools.

### 4. Ändert den Modellnamen

Dieselbe Zeile, mit einem Modellnamen, den es nicht gibt:

```bash
ANTHROPIC_BASE_URL=http://localhost:3420 ANTHROPIC_AUTH_TOKEN=test-token ANTHROPIC_MODEL=firma-modell-1 claude -p "Sag Hallo"
```

Im Gateway-Terminal steht jetzt `firma-modell-1`. In unserem Lauf meldete Claude Code, dass es das Modell nicht kennt, und arbeitete trotzdem weiter. So legt eine Firma fest, welche Modellnamen ihr Gateway anbietet.

### 5. Schreibt selbst: Das Gateway protokolliert mit

Ein Gateway kann Anfragen für Audits mitschreiben. Stoppt es mit Ctrl+C, sagt Claude in eigenen Worten, dass jede Anfrage in eine Datei soll, startet das Gateway neu und wiederholt Schritt 3 mit einem anderen Prompt.

Zum Beispiel:

```text
Erweitere mock-gateway.js: Bei jeder Anfrage mit stream=true hängt das Gateway an audit.log eine Zeile mit Uhrzeit und dem Text der letzten Nutzer-Nachricht an.
```

Öffnet `audit.log`. In unserem Lauf war die Zeile etwa 19 KB lang: Vor dem Prompt stand der Inhalt unserer eigenen CLAUDE.md-Dateien. Claude Code sendet also euren Prompt zusammen mit dem Kontext, und das Gateway sieht alles im Klartext.

### 6. Schreibt selbst: Eine Empfehlung aus den Docs

Formuliert eine Rahmenbedingung, wie sie in eurer Firma vorkommt, und lasst Claude die Docs dazu lesen. Verlangt die Docs-Seite für jede Aussage, damit ihr nachprüfen könnt.

Zum Beispiel:

```text
Unsere Rahmenbedingung: Aller Verkehr muss in unserem eigenen AWS-Account bleiben, und wir wollen die Kosten pro Team sehen. Lies https://code.claude.com/docs/en/llm-gateway und https://code.claude.com/docs/en/amazon-bedrock und empfiehl uns eine Routing-Option mit den Umgebungsvariablen, die wir dafür setzen. Nenne bei jeder Aussage die Docs-Seite, auf der sie steht.
```

In unserem Lauf unterschied Claude zwischen dem, was in den Docs steht, und seinem eigenen Wissen und bat uns, Letzteres nachzuprüfen. Prüft zwei Variablennamen selbst auf der genannten Seite.

### 7. Räumt auf

Beendet das Gateway mit Ctrl+C und löscht `audit.log`, die Datei enthält eure Prompts und Konfigurationsdateien.

### Was gerade passiert ist

Ein Gateway sieht jede Anfrage vollständig. Deshalb kann es Anmeldung, Kosten und Audit zentral regeln, und deshalb muss eure Firma ihm genauso vertrauen wie dem Modell-Anbieter. Mit einem Gateway wechselt ihr nur den Weg zu Claude. Laut Docs unterstützt Anthropic kein Routing von Claude Code auf Nicht-Claude-Modelle.

**Fertig, wenn** ihr Anfragen mit dem Modellnamen im Gateway-Terminal gesehen habt, `audit.log` euren Prompt enthielt und ihr eine Empfehlung habt, bei der zwei Variablennamen auf der genannten Docs-Seite stehen.

<details>
<summary>Mehr dazu</summary>

Alles hier ist laut Docs, nicht von uns ausprobiert, weil dafür ein Provider-Account nötig ist.

- Die Desktop-App liest `ANTHROPIC_BASE_URL` nicht, sie hat eine eigene Konfiguration für Drittanbieter. Deshalb nutzt dieser Test das Terminal: [Connect Claude Code to an LLM gateway](https://code.claude.com/docs/en/llm-gateway-connect)
- Ein Gateway bietet Zugangsdaten, Nutzungserfassung pro Entwickler oder Team, Kostenlimits und Audit-Logs: [LLM gateway](https://code.claude.com/docs/en/llm-gateway)
- Bedrock, Vertex AI und Foundry sind Wege direkt in euren Cloud-Account ohne eigenes Gateway: [Amazon Bedrock](https://code.claude.com/docs/en/amazon-bedrock), [Google Vertex AI](https://code.claude.com/docs/en/google-vertex-ai), [Übersicht](https://code.claude.com/docs/en/third-party-integrations)
- Datenschutz: Bei Team, Enterprise, API und Drittanbietern trainiert Anthropic laut Docs nicht mit Code und Prompts, Metriken, Fehlerberichte und `/feedback` sind bei Bedrock, Vertex und Foundry standardmäßig aus, mit `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` schaltet ihr Nebenverkehr ab. Ob das euren Vorgaben genügt, klärt ihr mit eurer Datenschutzabteilung: [Data usage](https://code.claude.com/docs/en/data-usage)

</details>
