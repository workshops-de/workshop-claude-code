> **⚠️ Zuerst die API starten:** Öffnet ein **separates Terminalfenster** und startet dort `npx bookmonkey-api`. Lasst es während der ganzen Aufgabe offen, damit der Server lokal auf http://localhost:4730 läuft.

In dieser Aufgabe geht es um **MCP** (Model Context Protocol): Darüber bekommt Claude zusätzliche Werkzeuge, hier einen echten Browser. Damit prüft Claude nicht nur den Code, sondern sieht sich die BookMonkey-Seiten an, klickt durch und berichtet, was es gefunden hat.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26. Es müssen zwei Server laufen: die API mit `npx bookmonkey-api` (http://localhost:4730) und die App mit `npm run dev` (http://localhost:3000).

### 1. Verbindet einen Browser-Server

Öffnet in der Desktop-App das Terminal im Projektordner und fügt den Playwright-Server hinzu. Danach zeigt die Liste, ob er läuft:

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest
claude mcp list
```

In der Liste steht `playwright` mit `Connected`. Startet jetzt eine neue Session, damit Claude die Browser-Tools kennt. Fragt Claude vor dem ersten Browser-Aufruf nach, erlaubt ihn.

### 2. Lasst Claude eine Journey durchgehen

```text
Öffne http://localhost:3000/books im Browser. Suche nach "of", geh auf Seite 2 und wieder zurück, öffne ein Harry-Potter-Buch mitten aus der Reihe und folge den Links zum vorherigen und nächsten Buch der Reihe. Melde bei jedem Schritt, was du auf der Seite siehst: Titel, Zahl der Karten und Adresszeile. Nur Beobachtungen, kein Urteil.
```

Claude steuert den Browser selbst. In unserem Lauf stand danach eine Tabelle da, Schritt für Schritt. Die Frage nach Beobachtungen statt nach einem Urteil liefert etwas, das ihr nachprüfen könnt.

### 3. Prüft die Handyansicht

```text
Öffne http://localhost:3000/books in einem Browserfenster in Handygröße (390 × 844). Gehe den Katalog durch und öffne ein Buch. Melde, was auf der Seite abgeschnitten ist, übereinander liegt oder zu klein zum Antippen ist. Nenne zu jeder Beobachtung die Seite und das Element.
```

In unserem Lauf kamen unter anderem abgeschnittene Titel und Links unter 44 px Höhe. Bei euch kann die Liste anders aussehen.

### 4. Behebt einen Fund und prüft ihn erneut

Wählt einen Fund aus Schritt 3 aus. Claude soll ihn beheben und danach im Browser messen, ob es geklappt hat. Den Prompt schreibt ihr selbst.

Zum Beispiel, wenn bei euch auch der Link „Next“ im Paging gemeldet wurde:

```text
Mach den Link „Next“ im Paging des Katalogs größer, sodass man ihn auf dem Handy gut antippen kann (mindestens 44 px hoch). Prüfe danach im Browser bei 390 × 844 auf http://localhost:3000/books, wie hoch der Link jetzt ist, und melde den gemessenen Wert.
```

### 5. Vergleicht mit curl

```text
Wie viele Bücher hat die API auf http://localhost:4730 insgesamt, und liefert dort /books?q=harry den Status 200? Antworte nur mit curl, ohne Browser.
```

Hier reicht curl: zwei Aufrufe, eine kurze Antwort und kein Browserfenster, dessen Inhalt in den Kontext kommt.

### 6. Committet euren Stand

Die Browser-Tools legen Screenshots in `.playwright-mcp/` in eurem Projekt ab. Die gehören nicht ins Repository.

```text
Trage .playwright-mcp/ in die .gitignore ein, weil dort die Browser-Tools ihre Screenshots ablegen. Committe dann alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

| | Browser per MCP | curl |
|---|---|---|
| Zeigt | was ein Nutzer sieht: Layout, Klicks, Navigation | Status, Header, Zahlen |
| Kosten im Kontext | groß, jede Seite kommt als Text oder Bild | klein |

Der MCP-Server gibt Claude Werkzeuge, die es von sich aus nicht hat. Die **Ergebnisse** dieser Werkzeuge landen in eurer Unterhaltung. Nehmt den Browser also dort, wo es auf das ankommt, was man sieht, und curl für alles, was eine Zahl oder ein Status beantwortet.

**Fertig, wenn** `claude mcp list` den Server `playwright` als verbunden zeigt, Claude eine Journey und die Handyansicht im Browser durchgegangen ist, ihr einen Fund behoben und erneut gemessen habt und `.playwright-mcp/` in der `.gitignore` steht.

<details>
<summary>Mehr dazu</summary>

`claude mcp add` speichert den Server standardmäßig nur für euch und dieses Projekt. Mit `--scope project` landet er in der `.mcp.json` im Projektordner, sodass euer Team ihn über Git bekommt. In der Standardeinstellung öffnet Playwright laut Doku ein sichtbares Browserfenster.

[MCP in Claude Code](https://code.claude.com/docs/en/mcp), [Playwright MCP](https://github.com/microsoft/playwright-mcp)

</details>
