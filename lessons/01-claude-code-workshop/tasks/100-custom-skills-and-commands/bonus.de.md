## Weiterführend – Skills mit Pfad-Scope, Fork und zum Teilen

- **Einen Skill auf Pfade begrenzen** – das Frontmatter `paths` lädt ihn nur, wenn Claude mit
  passenden Dateien arbeitet; verschachtelte `.claude/skills/`-Ordner werden geladen, sobald die
  Arbeit dieses Verzeichnis erreicht.
- **Einen Skill im eigenen Kontext ausführen** – `context: fork` führt ihn in einem Subagent aus,
  damit eine lange Prozedur eure Hauptsession nicht füllt. Zurück kommt nur das Ergebnis.

  | Frontmatter | Wo läuft der Skill? |
  | --- | --- |
  | ohne `context` und `agent` | in eurer Hauptsession |
  | `context: fork` | Subagent `general-purpose` |
  | `context: fork` + `agent: Explore` | Subagent `Explore`, nur lesen |
  | **nur** `agent: Explore` | in eurer Hauptsession, `agent` wirkt nur mit `context: fork` (getestet mit Claude Code 2.1.319, steht so nicht in den Docs) |

  Der Subagent sieht euren Chat nicht. Die SKILL.md braucht darum eine klare Aufgabe. Ein Skill mit
  reinen Richtlinien („nutzt diese API-Konventionen“) liefert im Fork kein brauchbares Ergebnis.
- **Skills als Plugins verpacken** – bündelt Skills, Subagents, Hooks und MCP-Server für
  versionierte Wiederverwendung im ganzen Team.
- **Beschreibungen auffindbar halten** – bei vielen Skills werden Beschreibungen gekürzt; beginnt
  mit Triggerwörtern.

Versucht, euren Skill `add-book-feature` mit `paths` auf euer App-Verzeichnis zu begrenzen, oder
macht aus eurem Command ein kleines Plugin, das euer Team installieren könnte.
