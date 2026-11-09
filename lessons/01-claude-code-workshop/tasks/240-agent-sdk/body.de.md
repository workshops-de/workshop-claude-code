## Überblick

Vom _Benutzen_ zum _Einbetten_ von Claude Code: Das **Claude Agent SDK** gibt euch dieselben Tools,
dieselbe Agent-Schleife und dasselbe Kontextmanagement als Bibliothek, die ihr aus Python oder
TypeScript aufrufen könnt.

## Hintergrund

Das Agent SDK ist dieselbe Engine, die Claude Code antreibt, bereitgestellt als
`@anthropic-ai/claude-agent-sdk` (TypeScript) und `claude-agent-sdk` (Python). Es lädt dieselbe
`.claude/`-Konfiguration und kann strukturiertes JSON zurückgeben. Nutzt die CLI für interaktive
und einmalige Arbeit; greift zum SDK, wenn ihr eigene Anwendungen, CI/CD-Automatisierung oder
wiederverwendbare Agenten baut.

## Schritte

1. Installiert das SDK für eure Sprache (Python 3.10+ oder TypeScript) und setzt einen API-Key aus
   der Console.
2. Schreibt einen minimalen Agenten, der eine echte Aufgabe in einem kleinen Projekt erledigt – zum
   Beispiel „alle TODO-Kommentare finden und zusammenfassen“ – und nur die Tools nutzt, die er
   braucht (`Read`, `Glob`, `Grep`).
3. Zieht die Zügel an: Setzt einen Permission Mode, fügt einen `PostToolUse`-Hook hinzu, der
   jeden Tool-Aufruf protokolliert, und setzt `tools: ['Read', 'Glob', 'Grep']` (`allowedTools` spart nur die Nachfrage).
4. Lasst ihn **strukturierte Ausgabe** zurückgeben (JSON-Schema / typisiertes Ergebnis) und
   verarbeitet sie in eurem Skript.
5. Optional: Fügt eine **Subagent**-Definition hinzu und lasst den Haupt-Agenten an ihn delegieren.
6. Vergleicht das Erlebnis mit `claude -p`: Wann würdet ihr statt der CLI zum SDK greifen?

## Erfolgskriterien

- [ ] Ein minimaler SDK-Agent läuft und erledigt eine echte, kleine Aufgabe
- [ ] Mit `tools: ['Read', 'Glob', 'Grep']` erzeugt eine Schreibaufgabe keine Datei
- [ ] Der Agent liefert strukturierte Ausgabe, die euer Skript verarbeitet
- [ ] Ihr könnt erklären, wann man zum SDK statt zur CLI greift

## Referenzen

- Claude Code – Agent SDK overview: https://code.claude.com/docs/en/agent-sdk/overview
- Claude Code – Agent SDK quickstart: https://code.claude.com/docs/en/agent-sdk/quickstart
- Example agents: https://github.com/anthropics/claude-agent-sdk-demos
