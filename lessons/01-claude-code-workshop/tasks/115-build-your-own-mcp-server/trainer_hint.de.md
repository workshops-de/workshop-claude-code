## Lernziele

- **Feature:** einen MCP-Server mit dem offiziellen SDK bauen (Tools mit Schemas, Annotations,
  stdio-Transport), `claude mcp add --scope project`, `.mcp.json`, `/mcp`, MCP-Berechtigungsregeln;
  im Bonus: Resources, Prompts, Streamable HTTP und OAuth für Remote-Server.
- **Konzepte:** Tools als Schnittstelle, die für einen Agenten entworfen ist; Beschreibungen als
  Prompts; Ergebnisgröße als Kontextkosten; lesende vs. schreibende Tools und menschliche
  Freigabe.
- **Erkenntnisse:** ein paar präzise Tools schlagen rohes HTTP bei wiederkehrenden Fragen;
  Tool-Ergebnisse für die Frage entwerfen, nicht auf Vollständigkeit; Schreibzugriffe hinter einer
  Abfrage halten.

## Hinweise zur Durchführung

- Diese Aufgabe deckt zusammen mit der vorherigen MCP-Aufgabe die Agenda-Punkte „MCP-Server
  verbinden, lokal und remote (OAuth)“ und „eigenen MCP-Server bauen“ ab. Der OAuth-Teil steht im
  Bonus; zeigt ihn live, wenn die meisten ihn überspringen.
- Ein Live-Einstieg von 5 Minuten hilft: Zeigt das Skelett aus dem Body im MCP Inspector laufend und
  lasst die Teilnehmenden es dann mit Claude erweitern.
- Der häufigste Fehler ist ein Server, der nach stdout loggt. Der zweite ist ein relativer Pfad in
  der `.mcp.json`, während Claude Code in einem Unterordner gestartet wurde; startet es im
  Repository-Stamm.
- Die Reihen-Frage braucht mehrere Aufrufe: die Reihe finden, jeden Band durchgehen, vergleichen.
  Achtet auf Teilnehmende, die eine Antwort annehmen, ohne das Transcript zu öffnen. Fragt, wie viele
  Aufrufe es waren und ob der Gesamtpreis berechnet oder geraten wurde.
- Gute Diskussion zum `curl`-Vergleich: `curl` braucht keinen Code und reicht für eine einmalige
  Prüfung; der MCP-Server zahlt sich aus, wenn dieselbe Art von Frage wiederkommt und Ergebnisse
  klein bleiben müssen.
- Referenz-Server für diese Aufgabe und ihren Bonus (mit Smoke-Tests) liegen im privaten
  Trainer-Repository (`bookmonkey-legacy-trainer/mcp/`), mit Hinweisen in `SOLUTIONS.md`.
  Veröffentlicht sie nicht in diesem Kurs-Repository; die Teilnehmenden sollen ihre eigenen bauen.
- Manche Firmennetzwerke blockieren `npx`-Downloads des MCP Inspectors. Er ist optional; `/mcp` und
  eine erste Frage in Claude Code reichen zum Testen.

## Zeitbedarf

~45 Minuten: 5 Demo, 20 Bauen und Inspizieren, 10 Registrieren und Tools verketten, 10 Schreib-Tool
und `curl`-Vergleich. Der Bonus braucht weitere 30 bis 45 Minuten.
