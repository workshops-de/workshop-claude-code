## Überblick

Verbindet Claude Code über das **Model Context Protocol (MCP)** mit einem echten Browser und lasst
den Agenten prüfen, was er gebaut hat, indem er es sich ansieht: klicken, lesen und berichten.
Manches lässt sich nicht durch Lesen des Codes prüfen: ob ein Cover wirklich angezeigt wird, ob sich das
Paging auf dem Handy richtig anfühlt, ob ein Link in der Reihe beim richtigen Buch landet.

## Das Feature

MCP ist ein offener Standard, um Agenten mit externen Tools und Daten zu verbinden: einem Browser,
einer Datenbank, einem Issue-Tracker oder eurem eigenen Tooling.

- **Einen Server hinzufügen**: Lokale (stdio-)Server starten einen Befehl nach `--`; Remote-Server
  bekommen eine URL:

  ```bash
  claude mcp add playwright -- npx -y @playwright/mcp@latest
  claude mcp add --transport http notion https://mcp.notion.com/mcp
  ```

- **Scopes**: Standard ist local (nur ihr, nur dieses Projekt). `--scope project` schreibt den
  Server in die `.mcp.json` im Projektstamm, sodass euer Team ihn über Git bekommt; `--scope user`
  macht ihn in allen euren Projekten verfügbar.
- **Status prüfen**: `claude mcp list` zeigt den Zustand je Server; `/mcp` in einer Session zeigt
  verbundene Server und ihre Tools und übernimmt die Anmeldung.
- **Kontextkosten**: Tool Search (standardmäßig an) schiebt Tool-Definitionen auf, bis sie gebraucht
  werden, aber die **Ergebnisse** von Tools landen trotzdem in eurem Kontext. Ein vollständiger
  Browser-Snapshot ist groß; ein Status-Check mit `curl` ist winzig.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist das **Katalogerlebnis**, das ihr bisher gebaut habt (Cover, Suche, Paging,
Navigation durch Reihen, Anmeldung und die Create-/Edit-Formulare), plus eine kleine Ergänzung nur
für den Client: ein **Cover-Fallback**. Manche Cover laden eventuell nicht (eine fehlende Datei,
ein Host, den eure App nicht erlaubt, ein Buch ohne Cover); die Karte soll dann einen Platzhalter
statt eines kaputten Bildes zeigen. Die Fehlerbehandlung `onError` für Bilder läuft nur im Browser,
deshalb liegt sie in einer Client Component. Nennt diese Einschränkung gleich zu Beginn, und lasst
den Agenten das Ergebnis dann in einem echten Browser belegen, statt darauf zu vertrauen, dass es
kompiliert.

## Schritte

1. Fügt einen MCP-Server für Browser-Automatisierung hinzu (z. B. Playwright:
   `claude mcp add playwright -- npx -y @playwright/mcp@latest`), startet eine Session und prüft
   mit `/mcp`, dass er verbunden ist und seine Tools aufgelistet werden. Playwright MCP schreibt
   Snapshots und Screenshots nach `.playwright-mcp/` in euer Repo: Tragt diesen Ordner in die
   `.gitignore` ein.
2. Nennt dem Agenten zuerst die **Einschränkung** (der Fallback ist eine kleine Client Component,
   der Rest der Karte bleibt serverseitig gerendert) und lasst ihn den Cover-Fallback
   implementieren. Legt ein Buch mit einer unsinnigen Cover-URL an, um einen Testfall zu haben.
   Euer Create-Formular hat kein Cover-Feld, nutzt also direkt die API:

   ```bash
   curl -X POST http://localhost:4730/books -H "Content-Type: application/json" \
     -d '{"isbn":"9990000000001","title":"Bogus Cover Test","author":"Test","cover":"https://nonexistent.invalid/cover.png"}'
   ```
3. Startet den Dev-Server und bittet den Agenten, **eine User Journey mit den Browser-Tools
   durchzugehen**: nach „of“ suchen (46 Treffer, genug für eine Seite 2; „harry“ hat nur 7), auf
   Seite 2 und zurück gehen, ein Buch öffnen, den Reihen-Links vor und zurück folgen, sich als
   Demo-User anmelden (`admin@bookmonkey.api` / `password1!`), versuchen, ein Buch mit bereits
   vorhandener ISBN anzulegen, und euer Buch mit dem unsinnigen Cover finden. Bittet ihn, konkrete
   Beobachtungen zu berichten, kein Urteil.
4. Wiederholt den Katalogteil in einem **Viewport in Handygröße** (z. B. 390 × 844) und lasst ihn
   Layoutprobleme melden.
5. Behebt, was der Browser-Check gefunden hat, und führt den Check danach erneut aus. Entfernt
   anschließend die Testdaten aus der gemeinsamen API: `curl -X POST http://localhost:4730/dev/reset`.
6. Findet eine Prüfung, bei der ein CLI-Befehl den Browser schlägt (z. B. „liefert `/books?q=harry`
   200?“ oder „wie viele Bücher hat die API?“), und erklärt, warum er die schlankere Wahl ist.

## Erfolgskriterien

**Feature**

- [ ] Ein MCP-Server ist verbunden und seine Tools erscheinen in `/mcp`
- [ ] Der Agent hat ihn genutzt, um die User Journey durchzugehen, und konkrete Beobachtungen
      berichtet
- [ ] Ihr wisst, welchen Scope ihr genutzt habt und wann ihr stattdessen `--scope project` wählen
      würdet
- [ ] Ihr habt mindestens eine Prüfung benannt, die besser mit einem CLI-Tool als über MCP geht

**App funktioniert weiterhin**

- [ ] Bücher ohne ladbares Cover zeigen einen Platzhalter, kein kaputtes Bild
- [ ] Suche, Paging und Navigation durch Reihen verhalten sich so, wie der Agent berichtet hat, auf
      Desktop- und Handybreite
- [ ] Nur der Fallback ist eine Client Component; `npm run build` läuft durch

## Referenzen

- Claude Code: MCP: https://code.claude.com/docs/en/mcp
- Claude Code: MCP quickstart: https://code.claude.com/docs/en/mcp-quickstart
- Playwright MCP server: https://github.com/microsoft/playwright-mcp
- Next.js: Server and Client Components: https://nextjs.org/docs/app/getting-started/server-and-client-components
