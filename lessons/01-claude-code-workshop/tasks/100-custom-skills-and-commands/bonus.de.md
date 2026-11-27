## Weiterführend – Skills mit Pfad-Scope, Fork und zum Teilen

- **Festlegen, wer einen Skill starten darf** – zwei Felder im Frontmatter bestimmen, wer ihn laden
  kann.

  | Frontmatter | Claude lädt ihn von selbst | Ihr könnt `/name` tippen |
  | --- | --- | --- |
  | keines der beiden Felder | ja | ja |
  | `disable-model-invocation: true` | nein | ja |
  | `user-invocable: false` | ja | nein |

  Mit `disable-model-invocation: true` kommt die `description` nicht in Claudes Kontext. Claude
  weiß also nicht, dass es den Skill gibt. Nutzt das für Aufgaben mit Nebenwirkungen oder mit einem
  Zeitpunkt, den ihr selbst wählen wollt (Deploy, Commit, euer `/new-book-view`). Es spart auch in
  jeder Session Kontext. `user-invocable: false` ist das Gegenteil: Der Skill fehlt im `/`-Menü, so
  wie der shadcn-Skill aus Aufgabe 080.
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

## Nach der Diskussion: vom Buch-Rezept zum Projekt-Skill

`add-book-feature` wird geladen, wenn eine Anfrage nach einem Buch-Feature klingt. Ein Skill lohnt
sich aber, wenn dieselbe Vorgehensweise in verschiedenen Aufgaben wiederkommt. Macht euren in drei
Schritten breiter.

1. **Erst sortieren, dann umschreiben.** Lasst Claude die Liste machen und sortiert sie selbst:

   ```text
   Liste die 10 wichtigsten Entscheidungen hinter der Leseseite und den Formularen, die wir gebaut haben (wo Dateien liegen, wie die API aufgerufen wird, URL-State, Anmeldung, Prüfungen, Projekt-Fakten). Eine Zeile pro Punkt. Ändere nichts.
   ```

   | Topf | Wohin damit |
   | --- | --- |
   | kommt bei jedem Screen wieder | in den Skill |
   | gilt in diesem Projekt immer | `CLAUDE.md` |
   | eine Aufgabe, die ich selbst starte | ein Command |
   | nur dieses eine Feature | nirgends, es steht im Code |

   Fragt euch: Würde der Skill auch bei einer Anmeldeseite oder einer Übersicht aller Reihen
   helfen? Wenn nicht, ist er ein Rezept und kein Skill.

2. **Schreibt den Skill nur aus dem ersten Topf neu.**

   ```text
   Mach aus add-book-feature einen Skill unter .claude/skills/api-screens/SKILL.md, der beschreibt, wie hier jeder Screen gegen die bookmonkey-api gebaut wird: Liste, Detailseite, Formular. Nimm nur die Entscheidungen aus „kommt bei jedem Screen wieder“, die Buchseiten nur als Beispiel, nicht als Regel. Lösch den alten Skill und lass /new-book-view auf den neuen verweisen. Die description beginnt mit Wörtern aus echten Anfragen (Screen, Seite, Liste, Detailseite, Formular, Suche, Paging, API).
   ```

3. **Testet ihn mit einer Aufgabe, die nie „Buch-Feature“ sagt.** In einer neuen Session:

   ```text
   Füge eine Seite /series hinzu, die jede Buchreihe mit ihren Büchern in der richtigen Reihenfolge zeigt.
   ```

   Schaut im Transcript, ob Claude `api-screens` geladen hat. Wenn nicht, ergänzt die Wörter aus
   eurem Prompt in der `description`.
