## Überblick

Nutzt Claude Code **ohne interaktive Oberfläche** – als skriptbares, kombinierbares
Kommandozeilen-Tool, das ihr in Build-Skripte, Pipelines und Automatisierung einbauen könnt. Lernt
den nicht interaktiven Print-Modus (`claude -p`), den Bare Mode, strukturierte Ausgabe und das
Vorab-Freigeben von Tools für unbeaufsichtigte Läufe.

## Hintergrund

Claude Code folgt der Unix-Philosophie: Mit `-p` (`--print`) läuft jeder Befehl nicht interaktiv,
liest `stdin` und schreibt das Ergebnis nach `stdout`. `--bare` überspringt die automatische Suche
nach Hooks, Skills, Plugins, MCP-Servern, Auto Memory, Subagents, Commands und `CLAUDE.md`, damit ein Skript auf jedem Rechner das
gleiche Ergebnis liefert. Weil kein Mensch Rückfragen beantwortet, gebt ihr Tools mit
`--allowedTools` vorab frei oder wählt einen Permission Mode.

## Schritte

1. Führt eine einmalige nicht interaktive Abfrage aus: Stellt mit `claude -p "..."` eine Frage zur
   Codebasis.
2. **Leitet** Daten durch Claude **per Pipe**: Gebt ein Build-Log oder einen `git diff` in
   `claude -p` und leitet die Erklärung in eine Datei um.
3. Erzeugt **strukturierte Ausgabe**: Führt eine Abfrage mit `--output-format json` aus, dann noch
   einmal eingeschränkt mit `--json-schema`, und lest ein Feld mit `jq` aus. Die Felder sind `.result`, `.structured_output` (prüft, ob es
   existiert) und `.total_cost_usd`.
4. Fügt ein **Projekt-Skript** hinzu, das den Diff gegen den Main-Branch per Pipe in `claude -p`
   gibt und es bittet, Probleme zu melden. Gebt nur die Tools vorab frei, die es braucht.
5. Führt zuerst `export ANTHROPIC_API_KEY=...` aus (PowerShell: `$env:ANTHROPIC_API_KEY="..."`), denn `--bare` liest euren Login nie. Probiert
   dann `--bare` und erklärt, was nicht mehr geladen wird; diskutiert, warum das für die
   Reproduzierbarkeit in CI wichtig ist.
6. Überlegt, welche wiederkehrenden Prüfungen in eurem Workflow zu Headless-Claude-Schritten werden
   könnten.

## Erfolgskriterien

- [ ] Eine nicht interaktive `claude -p`-Abfrage lief erfolgreich
- [ ] Strukturierte JSON-Ausgabe wurde erzeugt und ein Feld daraus ausgelesen
- [ ] Ein Projekt-Skript kapselt einen Headless-Claude-Check mit vorab freigegebenen Tools
- [ ] Ihr könnt erklären, was `--bare` ändert und warum das für CI wichtig ist

## Referenzen

- Claude Code – Run Claude Code programmatically: https://code.claude.com/docs/en/headless
- Claude Code – CLI reference: https://code.claude.com/docs/en/cli-reference
- Claude Code – GitHub Actions: https://code.claude.com/docs/en/github-actions
