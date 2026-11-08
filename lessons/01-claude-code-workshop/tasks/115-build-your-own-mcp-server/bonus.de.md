## Weiterführend: ein Ops-Server für die Legacy-App, remote über HTTP

Baut einen zweiten Server für [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy),
wie ihn ein Support- oder Ops-Team bei der Arbeit an Tickets haben möchte. Er gibt Claude
**nur lesenden** Zugriff auf die SQLite-Datenbank der App (`api/data/bookmonkey.db`, erzeugt von
`npm run db:reset`).

1. **Tools**, alle nur lesend:
   - `query` führt ein SQL-`SELECT` aus und liefert höchstens eine begrenzte Zahl von Zeilen
   - `list_tables`, `recent_mails` (die neuesten Zeilen der Outbox), `feature_flags`

   Macht die Garantie strukturell, nicht per Regex auf dem SQL: Öffnet die Datenbank schreibgeschützt,
   zum Beispiel mit `new DatabaseSync(file, { readOnly: true })` aus `node:sqlite` (Node 24 oder
   neuer).
2. **Eine Resource** mit dem Datenbankschema, die ihr per `@` an einen Prompt hängen könnt
   (`@legacy-ops:` zeigt, was der Server anbietet). Nutzt `server.registerResource(...)`.
3. **Ein Prompt**, der einen Ticket-Text in einen Untersuchungsplan verwandelt, sodass er im
   `/`-Menü als `/legacy-ops:investigate-ticket (MCP)` erscheint. Nutzt
   `server.registerPrompt(...)`.
4. **Lasst ihn remote über Streamable HTTP laufen** statt über stdio: Startet ihn als eigenen
   Prozess (zum Beispiel `node index.js --http 4790`, mit `StreamableHTTPServerTransport` aus dem
   SDK) und verbindet Claude Code mit seiner URL:

   ```bash
   claude mcp add --transport http legacy-ops http://localhost:4790/mcp
   ```

   Jetzt könnte der Server auf einer anderen Maschine laufen und von einem Team geteilt werden.
   Überlegt, was er brauchen würde, bevor ihr ihn über `localhost` hinaus freigebt: Authentifizierung,
   ein Zeilenlimit und welche Tabellen er überhaupt lesen darf.
5. Lasst ihn für die Debugging-Aufgabe verbunden, als ein weiteres Tool, das ihr nutzen dürft.

## Weiterführend: ein Remote-Server mit OAuth

Gehostete MCP-Server melden euch meist per OAuth an. Fügt einen hinzu, für den ihr ein Konto habt,
zum Beispiel:

```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

Meldet euch dann mit `/mcp` in einer Session an (oder mit `claude mcp login <name>` in eurer
Shell). Claude Code speichert und erneuert das Token; `claude mcp logout <name>` widerruft es, wo
der Anbieter das unterstützt. Vergleicht: Wer hält die Zugangsdaten bei eurem eigenen HTTP-Server,
und wer beim gehosteten?

## Weiterführend: bei einem gefährlichen Tool immer nachfragen

Setzt bei einem Tool, dessen Bestätigung der ganze Sinn ist, `_meta: { 'anthropic/requiresUserInteraction':
true }`. Claude Code fragt dann bei jedem Aufruf nach, auch im Auto Mode und mit Allow-Regeln.
