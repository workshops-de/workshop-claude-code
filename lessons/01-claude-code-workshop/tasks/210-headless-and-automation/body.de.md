> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

In dieser Aufgabe geht es um den **Headless-Modus**: Claude läuft ohne Chatfenster, ihr startet ihn mit `claude -p` in einem Terminal oder aus einem Skript und bekommt die Antwort als Text zurück. So baut ihr Claude in Skripte und später in Pipelines ein.

Ihr arbeitet in eurem `bookmonkey-legacy`-Repository mit Node.js 24. Öffnet in der Desktop-App das Terminal. Alle Befehle mit `claude -p` tippt ihr dort ein. Unter Windows nehmt die Git Bash. Prüft mit `jq --version`, ob jq installiert ist, sonst `brew install jq` oder unter Windows `winget install jqlang.jq`.

### 1. Stellt eine Frage ohne Chat

```text
claude -p "Wie ist dieses Projekt aufgebaut? Antworte in drei Sätzen."
```

Die Antwort steht im Terminal, danach ist Claude wieder beendet.

### 2. Gebt einen Diff per Pipe hinein

```text
git diff origin/main...origin/feature/admin-export-v2 | claude -p "Fasse diesen Diff in drei Stichpunkten zusammen: was wurde geändert und was ist riskant?" > zusammenfassung.md
```

Was vor dem `|` steht, bekommt Claude als Eingabe. Das `>` schreibt die Antwort in die Datei `zusammenfassung.md`. Öffnet sie.

### 3. Holt euch eine Antwort, die ein Skript lesen kann

```text
git diff origin/main...origin/feature/admin-export-v2 | claude -p "Prüfe diesen Diff auf Probleme. Gib ein Urteil und eine Liste der Probleme zurück." --output-format json --json-schema '{"type":"object","properties":{"urteil":{"type":"string","enum":["ok","bedenklich"]},"probleme":{"type":"array","items":{"type":"string"}}},"required":["urteil","probleme"]}' | jq .structured_output
```

Das Schema legt fest, welche Felder die Antwort hat. Ihr bekommt kein Fließtext, sondern ein Urteil und eine Liste, die `jq` ausliest. Das Feld heißt `structured_output`.

### 4. Lasst Claude daraus ein Skript bauen

Startet in der Desktop-App eine neue Session und gebt diesen Prompt ein:

```text
Schreib ein Shell-Skript review.sh im Projektordner. Es bekommt einen Branch als Argument, gibt den Diff von origin/main bis zu diesem Branch per Pipe an claude -p und lässt Claude auf Probleme prüfen. Die Antwort soll JSON mit einem Schema sein: urteil (ok oder bedenklich) und probleme (Liste). Das Skript gibt die Probleme lesbar aus (jq ist installiert) und endet mit Exit-Code 1, wenn das Urteil bedenklich ist. Claude darf in dem Lauf nur Read, Grep und Glob nutzen. Mach das Skript ausführbar.
```

Niemand beantwortet im Skript Rückfragen. Darum werden die erlaubten Tools vorab festgelegt. Lest das Skript durch, bevor ihr es startet.

### 5. Startet das Skript

```text
./review.sh origin/feature/admin-export-v2; echo "Exit-Code: $?"
```

Ihr seht das Urteil, die Probleme und zuletzt den **Exit-Code**, eine Zahl, an der andere Programme erkennen, ob etwas gelungen ist. Das Skript braucht etwas Zeit.

### 6. Baut ein eigenes Skript

Überlegt euch eine Prüfung oder Aufgabe, die ihr im Alltag wiederholt, und lasst Claude ein Skript dafür schreiben, das `claude -p` nutzt. Probiert es dann aus.

Zum Beispiel:

```text
Schreib ein Skript commit-vorschlag.sh, das die gestagten Änderungen (git diff --staged) per Pipe an claude -p gibt und eine kurze Commit-Nachricht vorschlägt. Mach es ausführbar.
```

Für dieses Beispiel braucht ihr eine gestagte Änderung (`git add review.sh`).

### 7. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

`claude -p` macht aus Claude ein Kommandozeilenprogramm: Eingabe per Pipe, Ausgabe auf der Konsole, und mit Schema und Exit-Code lässt es sich in Skripte einbauen. Dieselbe Idee steckt in jeder Pipeline, die Claude aufruft. Die Antworten unterscheiden sich in jedem Lauf, das Urteil und die Probleme prüft ihr selbst.

**Fertig, wenn** `review.sh` ein Urteil mit Exit-Code ausgibt, ihr ein eigenes Skript mit `claude -p` gebaut und ausprobiert habt und beides committet ist.

<details>
<summary>Mehr dazu</summary>

`claude -p` nutzt euren normalen Login. Ohne `-p` bleibt Claude interaktiv. Wollt ihr einen Lauf ohne eure lokalen Einstellungen und `CLAUDE.md` (etwa in CI), gibt es laut Docs `--bare`; es liest den Login nicht und braucht einen API-Key.

[Claude Code programmatisch nutzen](https://code.claude.com/docs/en/headless) und [CLI-Referenz](https://code.claude.com/docs/en/cli-reference)

</details>
