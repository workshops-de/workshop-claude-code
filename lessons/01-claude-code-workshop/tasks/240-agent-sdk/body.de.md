In dieser Aufgabe geht es um das **Claude Agent SDK**: Das ist Claude Code als Bibliothek, mit der ihr einen Agenten aus eigenem TypeScript-Code startet. Ihr arbeitet in einem neuen, leeren Ordner mit Node.js 24 (ab 18.14 geht es auch) und braucht keinen Server. Ihr nutzt dieselbe Anmeldung wie in Claude Code, einen API-Key braucht ihr nicht.

### 1. Legt ein Projekt an

Öffnet in der Desktop-App das Terminal in einem Ordner außerhalb eurer anderen Projekte und führt aus:

```bash
mkdir mein-agent && cd mein-agent
npm init -y
npm pkg set type=module
npm install @anthropic-ai/claude-agent-sdk tsx
```

`tsx` führt TypeScript-Dateien direkt aus. Öffnet danach den Ordner `mein-agent` als Projekt in einer neuen Session.

### 2. Lasst Claude den Agenten schreiben

```text
Lege utils.py mit zwei kleinen Python-Funktionen an, vor jeder steht ein TODO-Kommentar. Schreibe dann agent.ts: ein Skript mit dem Claude Agent SDK (@anthropic-ai/claude-agent-sdk, query), das den Agenten alle TODO-Kommentare im Ordner finden und zusammenfassen lässt. Der Agent bekommt nur die Tools Read, Glob und Grep, lädt keine .claude-Konfiguration (die Einstellung dafür heißt settingSources, sie bleibt leer) und das Skript gibt Text und Toolnamen aus.
```

Claude legt beide Dateien an. Lest `agent.ts` durch: `query` startet den Agenten, `tools` legt fest, was er überhaupt kann.

### 3. Startet den Agenten

```bash
npx tsx agent.ts
```

Der Agent sucht und fasst zusammen, ohne dass ihr etwas bestätigt. In unserem Lauf stand nach wenigen Sekunden eine Liste mit beiden TODOs aus `utils.py` im Terminal.

### 4. Gebt ihm eine Aufgabe, die er nicht erledigen kann

Ihr schreibt den Prompt selbst. Ihr wollt prüfen, was passiert, wenn der Agent etwas schreiben soll, aber nur lesen darf.

Zum Beispiel:

```text
Ändere den Prompt in agent.ts so, dass der Agent die gefundenen TODOs zusätzlich in eine neue Datei notizen.txt schreiben soll. Ändere sonst nichts.
```

Startet `npx tsx agent.ts` noch einmal. In unserem Lauf blieb `notizen.txt` aus, und der Agent schrieb, dass ihm ein Schreib-Tool fehlt.

### 5. Holt strukturierte Ausgabe

```text
Der Agent soll die TODOs als strukturierte Ausgabe zurückgeben (JSON-Schema mit Datei, Zeile und Text je TODO). Gib sie im Skript als Liste mit einer Zeile pro TODO aus.
```

Startet das Skript wieder. Euer Code bekommt jetzt Daten, die er weiterverarbeiten kann, statt Fließtext.

### Was gerade passiert ist

Der Agent ist dieselbe Schleife wie in Claude Code: lesen, suchen, antworten. Was er darf, bestimmt euer Code über `tools`, ihr müsst nicht auf Rückfragen reagieren. Deshalb nehmt ihr die CLI für eure tägliche Arbeit und das SDK, wenn ein Skript, ein Dienst oder eine CI-Pipeline den Agenten selbst starten soll.

**Fertig, wenn** euer Skript die TODOs als strukturierte Liste ausgibt und der Schreibauftrag in Schritt 4 keine Datei erzeugt hat.

<details>
<summary>Mehr dazu</summary>

Anmeldung: Die Docs beschreiben für das SDK den API-Key (`ANTHROPIC_API_KEY`) sowie Bedrock, Vertex und Foundry und weisen darauf hin, dass Drittanbieter ihren Nutzern kein claude.ai-Login anbieten dürfen, außer sie haben es von Anthropic genehmigt bekommen. In unserem Test lief das Skript auf einem Rechner ohne `ANTHROPIC_API_KEY` mit der vorhandenen Claude-Code-Anmeldung. Für ein Produkt, das andere nutzen, braucht ihr einen API-Key aus der Console.

[Overview](https://code.claude.com/docs/en/agent-sdk/overview) · [Quickstart](https://code.claude.com/docs/en/agent-sdk/quickstart) · [Beispiel-Agenten](https://github.com/anthropics/claude-agent-sdk-demos) · [Python-Variante](https://code.claude.com/docs/en/agent-sdk/python)

</details>
