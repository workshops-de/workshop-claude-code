> **⚠️ Vorher starten:** jeweils in einem eigenen Terminal, während der ganzen Aufgabe offen lassen.
> - API: `npx bookmonkey-api` (http://localhost:4730)

---

In dieser Aufgabe baut Claude einen **eigenen MCP-Server**: ein kleines Programm, das Claude ein paar fertige Werkzeuge (Tools) für den BookMonkey-Katalog gibt. Dazu müsst ihr keinen Code selbst schreiben.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26.

### 1. Lasst Claude den Server bauen

```text
Baue einen kleinen MCP-Server in tools/bookmonkey-mcp, der Claude Zugriff auf den Katalog der bookmonkey-api (http://localhost:4730) gibt. Er soll zwei Tools haben: search_books (Suche nach Titel oder Autor, liefert ISBN, Titel, Autor und Preis) und get_series (folgt ab einer ISBN den Reihen-Links und liefert alle Bände in der richtigen Reihenfolge mit dem Gesamtpreis). Der Einstieg ist tools/bookmonkey-mcp/server.mjs. Halte es klein, mit dem offiziellen MCP SDK, und prüfe beide Tools einmal gegen die laufende API.
```

Claude legt den Ordner an, installiert das SDK und testet die Tools gegen die API.

### 2. Verbindet den Server mit Claude

```text
Registriere den Server bookmonkey als MCP-Server im Projekt-Scope, sodass ihn das ganze Team über .mcp.json bekommt.
```

Claude legt dafür die Datei `.mcp.json` im Projektordner an, in der steht, wie der Server gestartet wird. Weil sie im Repository liegt, hat das Team den Server nach dem Klonen. Startet danach eine neue Session. Bestätigt den Projekt-Server, wenn Claude Code danach fragt. Öffnet in der Desktop-App das Terminal, startet dort `claude` und gebt `/mcp` ein: `bookmonkey` sollte als verbunden erscheinen.

### 3. Stellt eine Frage über den ganzen Katalog

```text
Welche Buchreihe hat die meisten Bände, und was kostet die ganze Reihe? Nutze dafür den bookmonkey-Server.
```

In einem unserer Läufe hat Claude die beiden Tools geladen, aber nicht benutzt, sondern die API direkt abgefragt, in einem anderen hat es damit nur einen Teil der Reihen geprüft. `get_series` braucht eine ISBN, und kein Tool kann sagen, welche Reihen es überhaupt gibt. Schaut in der Ausgabe nach, welche Tools Claude bei euch aufgerufen hat.

### 4. Gebt Claude das fehlende Tool

Überlegt, welches Tool die Frage aus Schritt 3 mit einem einzigen Aufruf beantworten würde, und schreibt den Prompt selbst. Zum Beispiel:

```text
Ergänze im bookmonkey-Server ein Tool list_series, das alle Reihen des Katalogs liefert, sortiert nach Zahl der Bände, mit Anzahl der Bände und Gesamtpreis. Die Beschreibung soll sagen, dass es für Fragen über alle Reihen gedacht ist. Prüfe es einmal gegen die API.
```

### 5. Fragt noch einmal

Startet eine neue Session, damit der Server mit dem neuen Tool startet, und stellt die Frage aus Schritt 3 noch einmal, diesmal ohne den Zusatz „Nutze dafür den bookmonkey-Server“. In unserem Lauf hat Claude `list_series` einmal aufgerufen und danach geantwortet.

### 6. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

Claude wählt ein Tool anhand seines **Namens und seiner Beschreibung**. In unseren Läufen ließ Claude die zwei Tools entweder links liegen oder prüfte damit nur einen Teil der Reihen, weil keines alle Reihen kennt. Ein Tool, das genau die Frage beantwortet, ersetzt viele einzelne Abfragen. Deshalb baut ihr Tools für die Fragen, die bei euch immer wieder kommen, und beschreibt sie so, dass Claude erkennt, wann es sie braucht.

**Fertig, wenn** `/mcp` den Server `bookmonkey` als verbunden zeigt, Claude die Reihen-Frage mit `list_series` beantwortet hat und `.mcp.json` sowie `tools/bookmonkey-mcp/` committet sind.

<details>
<summary>Mehr dazu</summary>

Teammitglieder starten nach dem Klonen einmal `npm install` in `tools/bookmonkey-mcp`. Mit `claude mcp add --scope project` im Terminal entsteht dieselbe `.mcp.json`. Der MCP Inspector (`npx @modelcontextprotocol/inspector node tools/bookmonkey-mcp/server.mjs`) lässt euch die Tools im Browser ausprobieren. Im Bonus geht es um Resources, Prompts und Remote-Server.

[MCP in Claude Code](https://code.claude.com/docs/en/mcp), [MCP: Build a server](https://modelcontextprotocol.io/docs/develop/build-server)

</details>
