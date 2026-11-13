> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

---

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

Das Schema legt fest, welche Felder die Antwort hat. Ihr bekommt keinen Fließtext, sondern ein Urteil und eine Liste, die `jq` ausliest. Das Feld heißt `structured_output`.

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

### 6. Lasst jeden Push die Prüfung durchlaufen

Jetzt kommt das Skript zum Einsatz. Am nützlichsten ist es, wenn es von selbst läuft. Ein **Git-Hook** ist ein Skript, das Git zu einem festen Zeitpunkt startet, hier vor jedem `git push`. Endet es mit einem Exit-Code ungleich 0, stoppt Git den Push. Es ist kein Claude-Code-Hook wie in Aufgabe 120: Git startet ihn, nicht Claude.

Bereitet zuerst einen Testplatz vor, damit nichts auf euer echtes Remote gelangt:

```text
git init --bare ../test-remote.git
git remote add test ../test-remote.git
git checkout -b admin-export origin/feature/admin-export-v2
```

`git init --bare` legt ein leeres Repository ohne Arbeitsordner an, das Pushes wie ein Server annimmt (nicht zu verwechseln mit `claude --bare`). Gebt dann Claude diesen Prompt:

```text
Ich möchte, dass jeder Push meines Branches automatisch durch review.sh geprüft wird. Wenn das Urteil bedenklich ist, soll der Push gestoppt werden, damit niemand aus Versehen ungeprüften Code pusht. Richte das in diesem Repo ein und zeig mir danach, dass es greift. Zum Ausprobieren pushst du meinen Branch admin-export auf das Remote test, niemals auf origin.
```

<details>
<summary>🔑 Fachbegriffe zum Nachsteuern</summary>

Falls Claude etwas anderes baut:

- **Git-Hook `pre-push`**: läuft vor dem Push, nicht nach einem Commit
- Exit-Code **ungleich 0** stoppt den Push
- Hooks in `.git/hooks` werden **nicht committet**; ein Ordner im Repo plus `git config core.hooksPath` lässt sich teilen, `core.hooksPath` setzt aber jede Person selbst
- **`git push --no-verify`** überspringt den Hook

</details>

Der Push von `admin-export` soll mit Urteil und Problemliste stoppen. Startet dann selbst `git push --no-verify test admin-export`: Er geht durch. Darum läuft dieselbe Prüfung später auch auf dem Server (Aufgabe 215). Wer Zeit hat, lässt Claude noch einen Branch ohne Änderungen auf `test` pushen (`git checkout -b clean origin/main`): Er geht durch. Geht danach mit `git checkout main` zurück. Pusht diese Test-Branches nie auf `origin`.

In unserem Lauf (Claude Code 2.1.323, Sonnet) hat Claude den Hook in einem Ordner `.githooks` angelegt und `core.hooksPath` gesetzt. Der Push des PR-Branches stoppte, auf dem Test-Remote kam nichts an, der unveränderte Branch ging durch. Legt Claude den Hook woanders ab, ist das in Ordnung, solange der Push stoppt.

Überlegt, wohin so eine Prüfung gehört. Eine Prüfung, die so lange dauert, passt zu `pre-push`, nicht zu `pre-commit`: Ihr committet oft und pusht selten. Und das KI-Urteil ändert sich von Lauf zu Lauf, darum braucht es einen Ausweg wie `--no-verify`.

### 7. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

`claude -p` macht aus Claude ein Kommandozeilenprogramm: Eingabe per Pipe, Ausgabe auf der Konsole, und mit Schema und Exit-Code lässt es sich in Skripte einbauen. Mit einem Git-Hook läuft die Prüfung vor jedem Push von selbst. Dieselbe Idee steckt in jeder Pipeline, die Claude aufruft. Die Antworten unterscheiden sich in jedem Lauf, das Urteil und die Probleme prüft ihr selbst.

**Fertig, wenn** `review.sh` ein Urteil mit Exit-Code ausgibt, der Hook den Push des PR-Branches stoppt, dieser Push mit `--no-verify` aber durchgeht und Skript und Hook-Ordner committet sind (liegt der Hook in `.git/hooks`, nur das Skript).

<details>
<summary>Mehr dazu</summary>

`claude -p` nutzt euren normalen Login. Ohne `-p` bleibt Claude interaktiv. Wollt ihr einen Lauf ohne eure lokalen Einstellungen und `CLAUDE.md` (etwa in CI), gibt es laut Docs `--bare`; es liest den Login nicht und braucht einen API-Key.

[Claude Code programmatisch nutzen](https://code.claude.com/docs/en/headless) und [CLI-Referenz](https://code.claude.com/docs/en/cli-reference)

</details>
