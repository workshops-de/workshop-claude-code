## Überblick

In der vorherigen Aufgabe habt ihr einen fertigen MCP-Server verbunden. Jetzt **baut ihr einen**:
einen kleinen Server, der Claude für den BookMonkey-Katalog ein paar präzise Tools gibt, statt
rohem HTTP. Ihr registriert ihn für das ganze Team, stellt eine Frage, die mehrere Tools
hintereinander braucht, und vergleicht die Kosten mit demselben Vorgehen per `curl`.

## Das Feature

Ein MCP-Server ist ein kleines Programm, das Claude sagt, welche **Tools** es anbietet (Name,
Beschreibung, Input-Schema), und sie ausführt, wenn Claude sie aufruft. Server können auch
**Resources** (Daten, die ihr per `@` erwähnen könnt) und **Prompts** (sie erscheinen als Slash
Commands) anbieten. Der **MCP Inspector** (`npx @modelcontextprotocol/inspector <command>`) lässt
euch die Tools eines Servers im Browser aufrufen, bevor Claude sie je sieht. Das offizielle
TypeScript SDK übernimmt die Protokollarbeit:

```bash
npm install @modelcontextprotocol/sdk zod
```

```js
// tools/bookmonkey-mcp/index.js  (ES-Modul: "type": "module" in seiner package.json)
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { z } from 'zod';

const server = new McpServer({ name: 'bookmonkey', version: '1.0.0' });

server.registerTool(
  'search_books',
  {
    description: 'Search the BookMonkey catalogue. Returns ISBN, title, author and price.',
    inputSchema: { query: z.string().min(1) },
    annotations: { readOnlyHint: true },
  },
  async ({ query }) => {
    const res = await fetch(`http://localhost:4730/books?q=${encodeURIComponent(query)}`);
    const books = await res.json();
    const rows = books.map(({ isbn, title, author, price }) => ({ isbn, title, author, price }));
    return { content: [{ type: 'text', text: JSON.stringify(rows) }] };
  },
);

await server.connect(new StdioServerTransport());
```

- **Transport.** Ein **stdio**-Server wird von Claude Code als Kindprozess gestartet und
  kommuniziert über stdin/stdout. Schreibt nie Logs nach stdout; nutzt `console.error`. Ein
  **Streamable-HTTP**-Server läuft eigenständig, und Claude Code verbindet sich mit einer URL (siehe
  Bonus).
- **Registrieren** für das ganze Team mit Projekt-Scope. Das `--` trennt die Optionen von Claude
  von dem Befehl, der den Server startet:

  ```bash
  claude mcp add --scope project bookmonkey -- node tools/bookmonkey-mcp/index.js
  ```

  Das schreibt die `.mcp.json` in den Projektstamm. Committet sie; Teammitglieder bestätigen den
  Server bei der ersten Nutzung. `claude mcp list`, `claude mcp get bookmonkey` und `/mcp` zeigen
  Status und Tools.
- **Beschreibungen sind Prompts.** Claude wählt Tools anhand von Name und Beschreibung. Eine
  präzise Beschreibung („Given any ISBN in a series, returns the whole series in order“) ist der
  Unterschied zwischen einem Aufruf und zehn.
- **Schreibende Tools brauchen eine Ask-Regel.** In Manual fragt Claude Code vor einem
  MCP-Tool-Aufruf nach, solange ihr ihn nicht erlaubt, zum Beispiel mit der Allow-Regel
  `mcp__bookmonkey__search_books`. Im Auto Mode kann ein Aufruf ohne Regel ohne Nachfrage laufen
  (im Test tat er das), also setzt für schreibende Tools eine Ask-Regel. `readOnlyHint` sagt Claude Code, dass ein Tool nichts ändert,
  sodass es diese Aufrufe parallel ausführen kann.
- **Ergebnisse kosten Kontext.** Tool-Definitionen werden durch Tool Search aufgeschoben, aber jedes
  Ergebnis landet in der Unterhaltung. Gebt nur die Felder zurück, die Claude braucht.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist euer **BookMonkey**-Repository und die `bookmonkey-api`, mit der es spricht
(`npx bookmonkey-api` auf Port 4730). Ihr baut `tools/bookmonkey-mcp` mit vier Tools:

| Tool | Art | Was es tut |
| ---- | --- | ---------- |
| `search_books` | lesen | Volltextsuche, liefert ISBN, Titel, Autor, Preis |
| `get_series` | lesen | folgt ab einer beliebigen ISBN einer Reihe den Reihen-Links und liefert alle Bände der Reihe in der richtigen Reihenfolge, mit Gesamtpreis |
| `catalogue_stats` | lesen | Anzahl der Bücher, Verlage, Preisspanne und der erste Band jeder Reihe |
| `create_book` | schreiben | legt ein Buch über die API an |

Danach stellt ihr Claude eine Frage, die kein einzelnes Tool beantwortet.

## Voraussetzungen

- Euer BookMonkey-Repository aus den früheren Aufgaben, und `npx bookmonkey-api` läuft auf
  `http://localhost:4730`
- Node.js 26 (wie für den Rest von BookMonkey). JavaScript reicht; bei TypeScript führt Node 26
  `.ts`-Dateien mit löschbarer Syntax (erasable syntax) direkt aus.
- **Unter Windows:** Die Shell-Snippets sind Bash. Führt sie in Git Bash aus (kommt mit Git for
  Windows), oder passt sie für PowerShell an: Führt die Befehle aus Schritt 1 nacheinander aus,
  statt sie mit `&&` zu verketten (`mkdir` legt den verschachtelten Ordner ohne `-p` an), und
  ruft `curl.exe` statt `curl` auf, denn `curl` ist in Windows PowerShell ein Alias für
  `Invoke-WebRequest`

## Schritte

1. Richtet das Package ein: `mkdir -p tools/bookmonkey-mcp && cd tools/bookmonkey-mcp && npm init -y
   && npm pkg set type=module && npm install @modelcontextprotocol/sdk zod`.
2. Bittet Claude im Plan Mode, den Server mit den vier Tools aus der Tabelle zu bauen, gegen das
   OpenAPI-Dokument der API (`http://localhost:4730/api-json`). Prüft im Plan die **Tool-
   Beschreibungen und Input-Schemas** so sorgfältig wie den Code: Genau das sieht Claude.
3. Zurück im Repository-Stamm (`cd ../..`), probiert den Server vor der Registrierung mit dem MCP
   Inspector aus:
   `npx @modelcontextprotocol/inspector node tools/bookmonkey-mcp/index.js`. Ruft jedes Lese-Tool
   einmal in der Browser-Oberfläche auf.
4. Registriert ihn im Repository-Stamm mit
   `claude mcp add --scope project bookmonkey -- node tools/bookmonkey-mcp/index.js`. Startet eine
   neue Session, bestätigt den Projekt-Server und prüft `/mcp`: vier Tools, verbunden.
5. Fragt: **„Welche Reihe hat die meisten Bände, und was kostet die ganze Reihe?“** Öffnet den
   Transcript-Viewer (`Ctrl+O`) und verfolgt, wie Claude die Tools verkettet. Wie viele Aufrufe hat
   es gebraucht? Hat es etwas geraten?
6. Verbessert eine Tool-Beschreibung oder die Form eines Ergebnisses, sodass dieselbe Frage weniger
   Aufrufe oder weniger Ausgabe braucht, startet eine neue Session und fragt erneut.
7. Legt in `/permissions` eine Ask-Regel `mcp__bookmonkey__create_book` an. Bittet Claude, über
   `create_book` **ein Buch anzulegen** (eine Test-ISBN wie `9990000000002`). Beobachtet die
   Berechtigungsabfrage und erlaubt dann die drei Lese-Tools in `/permissions`. Räumt danach auf: `curl -X POST http://localhost:4730/dev/reset`.
8. **Vergleicht mit `curl`.** Stellt in einer frischen Session ohne den MCP-Server (`/mcp` erlaubt
   es, ihn zu deaktivieren) dieselbe Frage und lasst Claude nur `curl` benutzen. Vergleicht die Zahl
   der Schritte, die Korrektheit der Antwort und `/context` nach beiden Läufen.
9. Committet `tools/bookmonkey-mcp/` (ohne `node_modules`) und `.mcp.json`.

## Erfolgskriterien

**Feature**

- [ ] Ein stdio-MCP-Server mit drei Lese-Tools und einem Schreib-Tool läuft aus `tools/bookmonkey-mcp`
- [ ] Er ist mit `--scope project` registriert; die `.mcp.json` ist committet und `/mcp` zeigt ihn
      als verbunden
- [ ] Claude hat die Reihen-Frage beantwortet, indem es eure Tools verkettet hat, und ihr habt die
      Aufrufe verfolgt
- [ ] Das Schreib-Tool hat eine Ask-Regel und fragt nach, bevor es läuft; die Lese-Tools sind erlaubt
- [ ] Ihr könnt den Unterschied bei Schritten und Kontextkosten zwischen euren Tools und `curl`
      erklären

**App funktioniert weiterhin**

- [ ] `npm run build` eurer BookMonkey-App läuft mit dem neuen Ordner im Repository weiterhin durch
- [ ] Das Testbuch ist nach `POST /dev/reset` wieder weg

## Referenzen

- Claude Code: MCP: https://code.claude.com/docs/en/mcp
- Claude Code: Permissions (MCP tool rules): https://code.claude.com/docs/en/permissions
- MCP: Build a server: https://modelcontextprotocol.io/docs/develop/build-server
- MCP TypeScript SDK: https://github.com/modelcontextprotocol/typescript-sdk
- MCP Inspector: https://modelcontextprotocol.io/docs/tools/inspector
